package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.assets.AssetType;
	import away3d.lights.PointLight;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.TextureMaterial;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Modelo3d 
	{
		private var loader3d:Loader3D;
		private var _loadComplete:Boolean = false;
		private var _object3d:ObjectContainer3D;
		public var container:ObjectContainer3D;
		private var material:ColorMaterial;
		
		public function Modelo3d(source:String = "") 
		{
			container = new ObjectContainer3D();
			if(source != ""){
				Parsers.enableAllBundled();
				loader3d = new Loader3D();
				//loader3d.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
				loader3d.addEventListener(AssetEvent.ASSET_COMPLETE, onResourceComplete);
				loader3d.addEventListener(LoaderEvent.LOAD_ERROR, onLoadError);
				
				loader3d.load(new URLRequest(source));
			}
		}
		
		private function onResourceComplete(e:AssetEvent):void 
		{
			loader3d.removeEventListener(LoaderEvent.LOAD_ERROR, onLoadError);
			if (e.asset.assetType == AssetType.MATERIAL) {
				material = ColorMaterial(e.asset);
				if(light != null) material.lightPicker = new StaticLightPicker([light]);
				loader3d.removeEventListener(AssetEvent.ASSET_COMPLETE, onResourceComplete);
			}
			_loadComplete = true;
			object3d = loader3d;
		}
		
		private var light:PointLight;
		public function setLight(light:PointLight):void
		{
			this.light = light;
			if(material != null) material.lightPicker = new StaticLightPicker([light]);
		}
		
		private function onLoadError(e:LoaderEvent):void 
		{
			loader3d.removeEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			loader3d.removeEventListener(LoaderEvent.LOAD_ERROR, onLoadError);
			loader3d = null;
			throw new Error("Erro ao ler arquivo 3d.");
		}
		
		public function get loadComplete():Boolean 
		{
			return _loadComplete;
		}
		
		public function get object():ObjectContainer3D
		{
			return container;
		}
		
		//public function get object3d():ObjectContainer3D 
		//{
			//return _object3d;
		//}
		
		public function set object3d(value:ObjectContainer3D):void 
		{
			if (_object3d != null) container.removeChild(_object3d);
			_object3d = value;
			container.addChild(_object3d);
		}
		
		public function set transform(transMat:Matrix3D):void
		{
			_object3d.transform = transMat;
		}
		
		public function set setScale(value:Number):void
		{
			container.scaleX = container.scaleY = container.scaleZ = value;
		}
		
		public function get setScale():Number
		{
			return container.scaleX;
		}
	}

}