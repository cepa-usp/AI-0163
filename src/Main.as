package 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.loaders.Loader3D;
	import fl.controls.Slider;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.net.URLLoaderDataFormat;
	import jp.nyatla.as3utils.sketch.FLSketch;
	import org.libspark.flartoolkit.core.types.FLARIntSize;
	import org.libspark.flartoolkit.markersystem.FLARMarkerSystemConfig;
	import org.libspark.flartoolkit.markersystem.FLARSensor;
	import org.libspark.flartoolkit.support.away3dv40.FLARAway3DMarkerSystem;
	import org.libspark.flartoolkit.support.away3dv40.FLARWebCamTexture;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Main extends FLSketch 
	{
		private var camera:CameraVideo;
		private var view3d:View3D;
		private var markerSys:FLARAway3DMarkerSystem;
		private var arSensor:FLARSensor;
		private var rect:Rectangle = new Rectangle(0, 0, 700, 500);
		
		private var camerafps:int = 30;
		private var cameraWidth:Number = 640;
		private var cameraHeight:Number = 480;
		private var rasterWidth:int = 320;
		private var rasterHeight:int = 240;
		
		private var scaleRatio:Matrix;
		
		private var cameraIndex:int;
		private var cameraURL:String = "./resources/camera_param/camera_para.dat";
		
		private var marcas:Vector.<FlarMark> = new Vector.<FlarMark>();
		private var camadaEletrons:CamadaEletrons;
		private var modeloLente:Modelo3d;
		
		private var distanceObject:DistanceObject = new DistanceObject();
		
		public function Main():void 
		{
			//if (stage) init();
			//else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		override public function setup():void 
		{
			cameraIndex = setSketchFile(cameraURL, URLLoaderDataFormat.BINARY);
			
			//var modelo:Modelo3d = new Modelo3d("./resources/model/earth.3ds");
			var modelo:Modelo3d = new Modelo3d();
			camadaEletrons = new CamadaEletrons(15, 150, 10, 20, 500, 10);
			modelo.object3d = camadaEletrons;
			//CamadaEletrons(modelo.object3d).startAnimation();
			
			//TO DO: ler todos os markers aqui
			var largura:Number = 70;
			var markerWH:Number = 60;
			
			var marker1:FlarMark = new FlarMark("./resources/marker/lado1.pat", markerWH);
			//var marker1:FlarMark = new FlarMark("./resources/marker/flarlogo.pat", markerWH);
			marker1.fileId = setSketchFile(marker1.source, URLLoaderDataFormat.TEXT);
			//marker1.loadModel("./resources/model/earth.3ds");
			marker1.modelo = modelo;
			marker1.transform.appendRotation(90, new Vector3D(1, 0, 0));
			
			var marker2:FlarMark = new FlarMark("./resources/marker/lado2.pat", markerWH);
			marker2.fileId = setSketchFile(marker2.source, URLLoaderDataFormat.TEXT);
			marker2.modelo = modelo;
			marker2.transform.appendTranslation(0, largura/2, -largura/2);
			
			var marker3:FlarMark = new FlarMark("./resources/marker/lado3.pat", markerWH);
			marker3.fileId = setSketchFile(marker3.source, URLLoaderDataFormat.TEXT);
			marker3.modelo = modelo;
			marker3.transform.appendRotation(-90, new Vector3D(1, 0, 0));
			marker3.transform.appendTranslation(0, 0, -largura);
			
			var marker4:FlarMark = new FlarMark("./resources/marker/lado4.pat", markerWH);
			marker4.fileId = setSketchFile(marker4.source, URLLoaderDataFormat.TEXT);
			marker4.modelo = modelo;
			marker4.transform.appendRotation(180, new Vector3D(1, 0, 0));
			marker4.transform.appendTranslation(0, -largura/2, -largura/2);
			
			var marker5:FlarMark = new FlarMark("./resources/marker/lado5.pat", markerWH);
			marker5.fileId = setSketchFile(marker5.source, URLLoaderDataFormat.TEXT);
			marker5.modelo = modelo;
			marker5.transform.appendRotation(90, new Vector3D(0, 1, 0));
			marker5.transform.appendRotation(180, new Vector3D(1, 0, 0));
			marker5.transform.appendTranslation(0, -largura/2, -largura/2);
			
			var marker6:FlarMark = new FlarMark("./resources/marker/lado6.pat", markerWH);
			marker6.fileId = setSketchFile(marker6.source, URLLoaderDataFormat.TEXT);
			marker6.modelo = modelo;
			marker6.transform.appendRotation(-90, new Vector3D(0, 1, 0));
			marker6.transform.appendRotation(90, new Vector3D(0, 0, 1));
			marker6.transform.appendTranslation(-largura/2, 0, -largura/2);
			
			
			marcas.push(marker1);
			marcas.push(marker2);
			marcas.push(marker3);
			marcas.push(marker4);
			marcas.push(marker5);
			marcas.push(marker6);
		}
		
		override public function main():void 
		{
			init();
		}
		
		private var timeControl:Slider = new Slider();
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			scrollRect = rect;
			
			setupCamera();
			setup3d();
			load3dModels();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			timeControl.liveDragging = true;
			timeControl.maximum = 1;
			timeControl.minimum = 0.05;
			timeControl.snapInterval = 0.05;
			timeControl.tickInterval = 0.1;
			timeControl.value = 1;
			timeControl.width = 200;
			timeControl.x = 250;
			timeControl.y = 475;
			addChild(timeControl);
			timeControl.addEventListener(Event.CHANGE, changeTime);
			
			setChildIndex(timeControl, numChildren - 1);
		}
		
		private function changeTime(e:Event):void 
		{
			camadaEletrons.velMult = timeControl.value;
		}
		
		private function setupCamera():void 
		{
			camera = new CameraVideo(cameraWidth, cameraHeight, camerafps);
			//addChild(camera);
			camera.x = 30;
			camera.y = 10;
			
			scaleRatio = new Matrix();
			scaleRatio.scale(rasterWidth / cameraWidth, rasterHeight / cameraHeight);
		}
		
		private function setup3d():void
		{
			var markerSysConf:FLARMarkerSystemConfig = new FLARMarkerSystemConfig(getSketchFile(cameraIndex), rasterWidth, rasterHeight);
			markerSys = new FLARAway3DMarkerSystem(markerSysConf);
			
			arSensor = new FLARSensor(new FLARIntSize(rasterWidth, rasterHeight));
			
			view3d = new View3D(new Scene3D(), markerSys.getAway3DCamera());
			view3d.width = rect.width;
			view3d.height = rect.height;
			
			view3d.background = new FLARWebCamTexture(cameraWidth, cameraHeight);
			
			addChild(view3d);
		}
		
		private function load3dModels():void 
		{
			for each (var marca:FlarMark in marcas) 
			{
				marca.markerId = markerSys.addARMarker_2(getSketchFile(marca.fileId), marca.resolution, marca.edgePercentage, marca.size);
				view3d.scene.addChild(marca.modelo.object);
				//trace(marca.modelo.object);
				marca.modelo.object.visible = false;
			}
			view3d.scene.addChild(distanceObject);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			arSensor.update_3(camera.video, scaleRatio);
			markerSys.update(arSensor);
			FLARWebCamTexture(view3d.background).update(camera.video);
			var marcasStage:Vector.<FlarMark> = new Vector.<FlarMark>();
			
			for each (var marca:FlarMark in marcas) 
			{
				if (markerSys.isExistMarker(marca.markerId)) {
					if (marcasStage.length == 0) {
						marcasStage.push(marca);
					}else {
						var temIgual:Boolean = false;
						loopIgual: for each (var item:FlarMark in marcasStage) 
						{
							if (item.modelo == marca.modelo) {
								temIgual = true;
								
								if (markerSys.getConfidence(marca.markerId) > markerSys.getConfidence(item.markerId)) {
									marcasStage[marcasStage.indexOf(item)] = marca;
								}
								
								break loopIgual;
							}
						}
						if (!temIgual) {
							marcasStage.push(marca);
						}
					}
				}
				marca.modelo.object.visible = false;
				/*
				if (markerSys.isExistMarker(marca.markerId)) {
					marca.modelo.object.visible = true;
					var resultMat:Matrix3D = new Matrix3D();
					markerSys.getAway3dMarkerMatrix(marca.markerId, resultMat);
					marca.modelo.object.transform = resultMat;
					objectTransform(marca.modelo.object);
				}else {
					marca.modelo.object.visible = false;
				}
				*/
			}
			
			for each (var marcaStage:FlarMark in marcasStage) 
			{
				marcaStage.modelo.object.visible = true;
				var resultMat:Matrix3D = new Matrix3D();
				markerSys.getAway3dMarkerMatrix(marcaStage.markerId, resultMat);
				marcaStage.modelo.object.transform = resultMat;
				//trace(marcaStage.modelo.object.x, marcaStage.modelo.object.y, marcaStage.modelo.object.z);
				//trace(marcaStage.modelo.object.visible);
				objectTransform(marcaStage);
			}
			camadaEletrons.enterFrame();
			//verificaContato();
			
			view3d.render();
		}
		
		private function verificaContato():void 
		{
			var mat3dCamadaEletrons:Matrix3D = camadaEletrons.transform.clone();
			
			var mat3dCamadaSessao:Matrix3D = modeloLente.object.transform.clone();
			var mat3dSessao:Matrix3D = Lente(modeloLente.object).mesh.transform.clone();
			mat3dSessao.append(mat3dCamadaSessao);
			
			var mat3dItem:Matrix3D;
			for each (var item:Particula in camadaEletrons.particulas) 
			{
				mat3dItem = item.transform.clone();
				mat3dItem.append(mat3dCamadaEletrons);
				
				distanceObject.setReta(mat3dItem.position, mat3dSessao.position);
			}
		}
		
		private function objectTransform(marca:FlarMark):void
		{
			marca.modelo.transform = marca.transform;
		}
		
		private function getDistance(x1:Number, y1:Number, z1:Number, x2:Number, y2:Number, z2:Number):Number
		{
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2) + Math.pow(z1 - z2, 2));
		}
		
	}
	
}