package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.entities.SegmentSet;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.LineSegment;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class DistanceObject extends ObjectContainer3D
	{
		private var mesh:SegmentSet;
		private var reta:LineSegment;
		
		public function DistanceObject() 
		{
			reta = new LineSegment(new Vector3D(), new Vector3D(), 0x000000, 0x808000, 1);
			mesh = new SegmentSet();
			mesh.addSegment(reta);
			addChild(mesh);
		}
		
		public function setReta(vetor1:Vector3D, vetor2:Vector3D):void
		{
			reta.start = vetor1;
			reta.end = vetor2;
		}
		
	}

}