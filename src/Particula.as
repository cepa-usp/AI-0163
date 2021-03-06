package  
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.entities.SegmentSet;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FogMethod;
	import away3d.materials.methods.OutlineMethod;
	import away3d.materials.SegmentMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.LineSegment;
	import away3d.primitives.SphereGeometry;
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Linear;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Particula extends ObjectContainer3D	{
		
		private var _posAnt:Vector3D = new Vector3D();
		private var _velocidade:Vector3D = new Vector3D();
		private var mesh:Mesh;
		private var glowMesh:Mesh;
		private var lines:SegmentSet;
		private var glow:Modelo3d;
		//private var glow:Mesh;
		
		public var cron:Number = 0;
		
		public function Particula(cor:uint = 0x800000) 
		{
			//var sphere:CubeGeometry = new CubeGeometry(1, 1, 1);
			var sphere:SphereGeometry = new SphereGeometry(1.5, 8, 6);
			mesh = new Mesh(sphere);
			mesh.material = new ColorMaterial(cor);
			
			addChild(mesh);
			
			//var segHeight:Number = 1;
			//var line1:LineSegment = new LineSegment(new Vector3D( -segHeight, 0, 0), new Vector3D( segHeight, 0, 0), 0xFFFFFF, 0xFFFFFF, 2);
			//var line2:LineSegment = new LineSegment(new Vector3D( 0, -segHeight, 0), new Vector3D( 0, segHeight, 0), 0xFFFFFF, 0xFFFFFF, 2);
			//var line3:LineSegment = new LineSegment(new Vector3D( 0, 0, -segHeight), new Vector3D( 0, 0, segHeight), 0xFFFFFF, 0xFFFFFF, 2);
			//
			//lines = new SegmentSet();
			//lines.addSegment(line1);
			//lines.addSegment(line2);
			//lines.addSegment(line3);
			//lines.visible = false;
			
			//var sphere2:SphereGeometry = new SphereGeometry(2.5, 8, 6);
			//var sphere2:CubeGeometry = new CubeGeometry(6, 6, 6);
			//glowMesh = new Mesh(sphere2);
			//glowMesh.material = new ColorMaterial(0xFFFFFF);
			//glowMesh.material.alphaPremultiplied = false;
			//ColorMaterial(glowMesh.material).alpha = 0;
			//ColorMaterial(glowMesh.material).addMethod(new OutlineMethod(0xFFFFFF, 2));
			//ColorMaterial(glowMesh.material).addMethod(new FogMethod(10, 20, 0xFFFFFF));
			//glowMesh.visible = false;
			//
			//
			//addChild(glowMesh);
			//addChild(lines);
			
			glow = new Modelo3d("./resources/models/estrela.3DS");
			addChild(glow.object);
			glow.object.visible = false;
			glow.setScale = 0;
			
			//var sphere2:SphereGeometry = new SphereGeometry(2.5, 8, 6);
			//glow = new Mesh(sphere2, new ColorMaterial(0xFFFFFF));
			//addChild(glow);
			//glow.visible = false;
			//glow.scaleX = glow.scaleY = glow.scaleZ = 0;
		}
		
		private var light:PointLight;
		
		public function setLight(light:PointLight):void
		{
			this.light = light;
			mesh.material.lightPicker = new StaticLightPicker([light]);
			//glow.setLight(light);
		}
		
		public function set color(cor:uint):void
		{
			mesh.material = new ColorMaterial(cor);
			mesh.material.lightPicker = new StaticLightPicker([light]);
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
		
		public function blink():void
		{
			//glowMesh.visible = true;
			glow.object.visible = true;
			//glow.visible = true;
			//mesh.visible = false;
			mesh.scaleX = mesh.scaleY = mesh.scaleZ = 0;
			//lines.visible = true;
			Actuate.tween(glow, 0.15, {setScale:0.12}).ease(Linear.easeNone).onComplete(fadeOut);
			//Actuate.tween(glow, 0.15, { scaleX:1, scaleY:1, scaleZ:1 } ).ease(Linear.easeNone).onComplete(fadeOut);
			Actuate.tween(mesh, 0.15, { scaleX:1, scaleY:1, scaleZ:1 } ).ease(Linear.easeNone);
			//Actuate.tween(ColorMaterial(glowMesh.material), 0.15, {alpha:0.8}).ease(Linear.easeNone).onComplete(fadeOut);
			//Actuate.tween(glowMesh, 0.3, { rotationX:720, rotationY:720, rotationZ:720 } ).ease(Linear.easeNone).onComplete(rsetRotation);
		}
		
		private function rsetRotation():void 
		{
			glowMesh.rotationX = 0;
			glowMesh.rotationY = 0;
			glowMesh.rotationZ = 0;
		}
		
		private function fadeOut():void 
		{
			//Actuate.tween(glow, 0.15, { scaleX:0, scaleY:0, scaleZ:0 } ).ease(Linear.easeNone).onComplete(turnInvisible);
			Actuate.tween(glow, 0.15, { setScale:0} ).ease(Linear.easeNone).onComplete(turnInvisible);
			//Actuate.tween(ColorMaterial(glowMesh.material), 0.15, { alpha:0} ).ease(Linear.easeNone).onComplete(turnInvisible);
		}
		
		private function turnInvisible():void 
		{
			//lines.visible = false;
			//mesh.visible = true;
			//glowMesh.visible = false;
			glow.object.visible = false;
			//glow.visible = false;
		}
		
	}

}