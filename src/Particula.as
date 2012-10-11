package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SphereGeometry;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Particula extends ObjectContainer3D	{
		
		private var _posAnt:Vector3D = new Vector3D();
		private var _velocidade:Vector3D = new Vector3D();
		
		public var cron:Number = 0;
		
		public function Particula(cor:uint = 0x800000) 
		{
			//var sphere:CubeGeometry = new CubeGeometry(1, 1, 1);
			var sphere:SphereGeometry = new SphereGeometry(1.5, 8, 6);
			var mesh:Mesh = new Mesh(sphere);
			mesh.material = new ColorMaterial(cor);
			
			addChild(mesh);
		}
		
		public function get direcao():Vector3D
		{
			var dir:Vector3D = _velocidade.clone();
			dir.normalize();
			return dir;
		}
		
		public function get intensidade():Number
		{
			return _velocidade.length;
		}
		
		public function get posAnt():Vector3D 
		{
			return _posAnt;
		}
		
		public function set posAnt(value:Vector3D):void 
		{
			_posAnt = new Vector3D(value.x, value.y, value.z, value.w);
		}
		
		public function get velocidade():Vector3D 
		{
			return _velocidade;
		}
		
		public function set velocidade(value:Vector3D):void 
		{
			_velocidade = new Vector3D(value.x, value.y, value.z, value.w);
		}
		
	}

}