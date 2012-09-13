package  
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class CameraVideo extends Sprite
	{
		private var _video:Video;
		private var _captureWidth:Number;
		private var _captureHeight:Number;
		private var fps:Number;
		
		public function CameraVideo(cameraWidth:Number, cameraHeight:Number, videofps:Number) 
		{
			_captureWidth = cameraWidth;
			_captureHeight = cameraHeight;
			fps = videofps;
			
			setupCamera();
		}
		
		private function setupCamera():void
		{
			var webcam:Camera = Camera.getCamera();
			if (!webcam) {
				throw new Error("Camera não encontrada.");
			}
			
			webcam.setMode(captureWidth, captureHeight, fps);
			_video = new Video(captureWidth, captureHeight);
			_video.clear();
			_video.attachCamera(webcam);
			//addChild(_video);
		}
		
		public function get video():Video 
		{
			return _video;
		}
		
		public function get captureWidth():Number 
		{
			return _captureWidth;
		}
		
		public function get captureHeight():Number 
		{
			return _captureHeight;
		}
		
	}

}