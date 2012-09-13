package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SphereGeometry;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Eletron extends ObjectContainer3D
	{
		public function Eletron() 
		{
			var sphere:CubeGeometry = new CubeGeometry(2, 2, 2);
			var mesh:Mesh = new Mesh(sphere);
			mesh.material = new ColorMaterial(0x000000, 0.5);
			
			//var sphere2:SphereGeometry = new SphereGeometry(5);
			//var mesh2:Mesh = new Mesh(sphere2);
			//mesh2.material = new ColorMaterial(0x000000, 0.2);
			
			addChild(mesh);
			//addChild(mesh2);
			
		}
		
	}

}