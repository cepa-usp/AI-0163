package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.loaders.Loader3D;
	import away3d.loaders.parsers.Parsers;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SphereGeometry;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Eletron extends ObjectContainer3D
	{
		private var loader3d:Loader3D;
		private var source:String = "./resources/model/esfera.3DS";
		
		public function Eletron() 
		{
			//Parsers.enableAllBundled();
			//loader3d = new Loader3D();
			//loader3d.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			//loader3d.addEventListener(LoaderEvent.LOAD_ERROR, onLoadError);
			//
			//loader3d.load(new URLRequest(source));
			
			
			//var sphere1:CubeGeometry = new CubeGeometry(2, 2, 2);
			var sphere1:SphereGeometry = new SphereGeometry(1, 8, 6);
			var mesh1:Mesh = new Mesh(sphere1);
			mesh1.material = new ColorMaterial(0x000080);
			
			var sphere:SphereGeometry = new SphereGeometry(5, 16, 12);
			var mesh:Mesh = new Mesh(sphere);
			mesh.material = new ColorMaterial(0x00FF00, 0.2);
			
			//var sphere2:SphereGeometry = new SphereGeometry(5);
			//var mesh2:Mesh = new Mesh(sphere2);
			//mesh2.material = new ColorMaterial(0x000000, 0.2);
			
			addChild(mesh1);
			addChild(mesh);
			//addChild(mesh2);
			
		}
		
		private function onResourceComplete(e:LoaderEvent):void 
		{
			addChild(loader3d);
			this.scale(0.1);
		}
		
		private function onLoadError(e:LoaderEvent):void 
		{
			trace("pau no 3d!");
		}
		
	}

}