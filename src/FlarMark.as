package  
{
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class FlarMark 
	{
		public var fileId:int;
		public var markerId:int;
		public var modelo:Modelo3d;
		private var _source:String;
		
		private var _resolution:int;
		private var _edgePercentage:int;
		private var _size:Number;
		
		private var _transform:Matrix3D = new Matrix3D();
		
		public function FlarMark(source:String, size:Number, resolution:int = 16, edgePercentage:int = 25) 
		{
			this._source = source;
			this._size = size;
			this._resolution = resolution;
			this._edgePercentage = edgePercentage;
		}
		
		public function loadModel(source:String):void
		{
			modelo = new Modelo3d(source);
		}
		
		public function get source():String 
		{
			return _source;
		}
		
		public function get resolution():int 
		{
			return _resolution;
		}
		
		public function get edgePercentage():int 
		{
			return _edgePercentage;
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function get transform():Matrix3D 
		{
			return _transform;
		}
		
		public function set transform(value:Matrix3D):void 
		{
			_transform = value;
		}
		
	}

}