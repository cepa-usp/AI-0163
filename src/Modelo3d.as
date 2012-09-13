package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.events.LoaderEvent;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.Parsers;
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
		public var object3d:ObjectContainer3D;
		
		public function Modelo3d(source:String = "") 
		{
			if(source != ""){
				Parsers.enableAllBundled();
				loader3d = new Loader3D();
				loader3d.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
				loader3d.addEventListener(LoaderEvent.LOAD_ERROR, onLoadError);
				
				loader3d.load(new URLRequest(source));
			}
		}
		
		private function onResourceComplete(e:LoaderEvent):void 
		{
			_loadComplete = true;
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
			if (object3d != null) return object3d;
			else return loader3d;
		}
	}

}