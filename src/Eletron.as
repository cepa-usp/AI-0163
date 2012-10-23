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
			var sphere:SphereGeometry = new SphereGeometry(1, 4, 4);
			var mesh:Mesh = new Mesh(sphere);
			mesh.material = new ColorMaterial(0x800000);
			
			//var sphere1:SphereGeometry = new SphereGeometry(2, 6, 4);
			//var mesh1:Mesh = new Mesh(sphere1);
			//mesh1.material = new ColorMaterial(0x00FF00, 0.2);
			//mesh1.material.alphaPremultiplied = true;
			
			var sphere2:SphereGeometry = new SphereGeometry(2.5, 8, 6);
			var mesh2:Mesh = new Mesh(sphere2);
			mesh2.material = new ColorMaterial(0x00FF00, 0.2);
			//mesh2.material.alphaPremultiplied = true;
			
			//var sphere3:SphereGeometry = new SphereGeometry(4, 12, 8);
			//var mesh3:Mesh = new Mesh(sphere3);
			//mesh3.material = new ColorMaterial(0x00FF00, 0.15);
			//mesh3.material.alphaPremultiplied = true;
			
			var sphere4:SphereGeometry = new SphereGeometry(5, 10, 10);
			var mesh4:Mesh = new Mesh(sphere4);
			mesh4.material = new ColorMaterial(0x00FF00, 0.15);
			//mesh4.material.alphaPremultiplied = true;
			
			//var sphere2:SphereGeometry = new SphereGeometry(5);
			//var mesh2:Mesh = new Mesh(sphere2);
			//mesh2.material = new ColorMaterial(0x000000, 0.2);
			
			addChild(mesh4);
			//addChild(mesh3);
			addChild(mesh2);
			//addChild(mesh1);
			addChild(mesh);
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