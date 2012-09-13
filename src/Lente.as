package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CylinderGeometry;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Lente extends ObjectContainer3D
	{
		public var mesh:Mesh;
		
		public function Lente() 
		{
			var sphere:CylinderGeometry = new CylinderGeometry(25, 25, 1, 16, 1, true, true);
			mesh = new Mesh(sphere);
			mesh.material = new ColorMaterial(0xFF0000, 0.5);
			
			addChild(mesh);
			mesh.z = 25;
			//mesh.rotationZ = 90;
		}
		
	}

}