package 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.loaders.Loader3D;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.PlaneGeometry;
	import cepa.ai.AI;
	import cepa.utils.Cronometer;
	import com.eclecticdesignstudio.motion.Actuate;
	import fl.controls.Slider;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.net.URLLoaderDataFormat;
	import flash.ui.Keyboard;
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
		private var markerBase:FlarMark;
		private var camadaEletrons:CamadaEletrons;
		private var modeloLente:Modelo3d;
		private var baseModeloLamina:Mesh;
		private var layerAtividade:Sprite;
		private var modelo:Modelo3d;
		
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
			modelo = new Modelo3d();
			camadaEletrons = new CamadaEletrons(15, 150, 10, 20, 90, 10);
			//camadaEletrons = new CamadaEletrons(15, 10, 10, 20, 2, 10);
			modelo.object3d = camadaEletrons;
			//CamadaEletrons(modelo.object3d).startAnimation();
			camadaEletrons.addEventListener("playSound", playSound);
			
			//TO DO: ler todos os markers aqui
			var largura:Number = 70;
			var markerWH:Number = 60;
			var larguraAlturaModelo:Number = 30;
			
			var marker1:FlarMark = new FlarMark("./resources/marker/lado1.pat", markerWH);
			//var marker1:FlarMark = new FlarMark("./resources/marker/flarlogo.pat", markerWH);
			marker1.fileId = setSketchFile(marker1.source, URLLoaderDataFormat.TEXT);
			//marker1.loadModel("./resources/model/earth.3ds");
			marker1.modelo = modelo;
			marker1.transform.appendRotation(-90, new Vector3D(1, 0, 0));
			marker1.transform.appendTranslation(0, 0, -largura/2 + larguraAlturaModelo/2);
			
			var marker2:FlarMark = new FlarMark("./resources/marker/lado2.pat", markerWH);
			marker2.fileId = setSketchFile(marker2.source, URLLoaderDataFormat.TEXT);
			marker2.modelo = modelo;
			marker2.transform.appendRotation(-180, new Vector3D(1, 0, 0));
			marker2.transform.appendTranslation(0, larguraAlturaModelo / 2, -largura / 2);
			//marker2.transform.appendScale(3, 3, 3);
			
			var marker3:FlarMark = new FlarMark("./resources/marker/lado3.pat", markerWH);
			marker3.fileId = setSketchFile(marker3.source, URLLoaderDataFormat.TEXT);
			marker3.modelo = modelo;
			marker3.transform.appendRotation(90, new Vector3D(1, 0, 0));
			marker3.transform.appendTranslation(0, 0, -largura / 2 - larguraAlturaModelo / 2);
			
			var marker4:FlarMark = new FlarMark("./resources/marker/lado4.pat", markerWH);
			marker4.fileId = setSketchFile(marker4.source, URLLoaderDataFormat.TEXT);
			marker4.modelo = modelo;
			marker4.transform.appendTranslation(0, -larguraAlturaModelo/2, -largura/2);
			
			var marker5:FlarMark = new FlarMark("./resources/marker/lado5.pat", markerWH);
			marker5.fileId = setSketchFile(marker5.source, URLLoaderDataFormat.TEXT);
			marker5.modelo = modelo;
			marker5.transform.appendRotation(90, new Vector3D(0, 1, 0));
			marker5.transform.appendTranslation(0, -larguraAlturaModelo/2, -largura/2);
			
			var marker6:FlarMark = new FlarMark("./resources/marker/lado6.pat", markerWH);
			marker6.fileId = setSketchFile(marker6.source, URLLoaderDataFormat.TEXT);
			marker6.modelo = modelo;
			marker6.transform.appendRotation(-90, new Vector3D(0, 1, 0));
			marker6.transform.appendRotation(-90, new Vector3D(0, 0, 1));
			marker6.transform.appendTranslation( -larguraAlturaModelo / 2, 0, -largura / 2);
			
			var scaleBase:Number = 0.75;
			var geom:PlaneGeometry = new PlaneGeometry(10, 300 * scaleBase);
			var mat:ColorMaterial = new ColorMaterial(0xEAEAEA);
			baseModeloLamina = new Mesh(geom, mat);
			baseModeloLamina.rotate(new Vector3D(1, 0, 0), 90);
			baseModeloLamina.rotate(new Vector3D(0, 1, 0), 90);
			baseModeloLamina.translate(new Vector3D(0, 1, 0), -85);
			//baseModeloLamina.translate(new Vector3D(0, 0, 1), -larguraAlturaModelo/2);
			
			markerBase = new FlarMark("./resources/marker/base.pat", markerWH);
			markerBase.fileId = setSketchFile(markerBase.source, URLLoaderDataFormat.TEXT);
			markerBase.modelo = modelo;
			markerBase.modelo.object.addChild(baseModeloLamina);
			baseModeloLamina.visible = false;
			//markerBase.transform.appendRotation(-90, new Vector3D(0, 1, 0));
			//markerBase.transform.appendRotation(-90, new Vector3D(0, 0, 1));
			markerBase.transform.appendTranslation(0, -130, 0);
			markerBase.transform.appendTranslation(0, 0, larguraAlturaModelo);
			markerBase.transform.appendScale(scaleBase, scaleBase, scaleBase);
			
			
			marcas.push(marker1);
			marcas.push(marker2);
			marcas.push(marker3);
			marcas.push(marker4);
			marcas.push(marker5);
			marcas.push(marker6);
			marcas.push(markerBase);
		}
		
		private function playSound(e:Evt):void 
		{
			if (cron.isRunning()) {
				e.particula.blink();
				if(tocarSom){
					var pop:Pop = new Pop();
					pop.play();
				}
			}
		}
		
		override public function main():void 
		{
			init2();
		}
		
		private var cronometro:Cronometro;
		private var cron:Cronometer;
		
		private var animationMenu:AnimationMenu;
		
		private var ai:AI;
		
		private function init2(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			// entry point
			scrollRect = rect;
			
			layerAtividade = new Sprite();
			addChild(layerAtividade);
			//setChildIndex(layerAtividade, 0);
			
			ai = new AI(this);
			ai.container.optionButtons.addCreditosButton();
			ai.container.optionButtons.addResetButton();
			ai.container.optionButtons.addOrientacoesButton();
			ai.container.setMessageTextVisible(false);
			ai.container.setAboutScreen(new AboutScreen());
			var inst:InstScreen = new InstScreen();
			var rollText:RollText = new RollText();
			inst.addChild(rollText);
			rollText.x = -260;
			rollText.y = -150;
			var scrollBar:Scrollbar = new Scrollbar(rollText);
			inst.addChild(scrollBar);
			ai.container.setInfoScreen(inst);
			
			setupCamera();
			setup3d();
			load3dModels();
			
			cron = new Cronometer();
			
			cronometro = new Cronometro();
			cronometro.x = 10;
			cronometro.y = 10;
			cronometro.btn_play.addEventListener(MouseEvent.CLICK, startCronometro);
			cronometro.btn_pause.addEventListener(MouseEvent.CLICK, pauseCronometro);
			cronometro.btn_reset.addEventListener(MouseEvent.CLICK, resetCronometro);
			cronometro.openClose.addEventListener(MouseEvent.CLICK, openCloseCron);
			cronometro.openClose.gotoAndStop("CLOSE");
			cronometro.openClose.buttonMode = true;
			layerAtividade.addChild(cronometro);
			
			animationMenu = new AnimationMenu();
			animationMenu.x = 10;
			animationMenu.y = 85;
			layerAtividade.addChild(animationMenu);
			
			animationMenu.timeControl.addEventListener(Event.CHANGE, changeTime);
			animationMenu.acelControl.addEventListener(Event.CHANGE, changeAcel);
			animationMenu.scaleControl.addEventListener(Event.CHANGE, changeScale);
			animationMenu.wireOnOff.addEventListener(MouseEvent.CLICK, cubeOnOff);
			animationMenu.soundOnOff.addEventListener(MouseEvent.CLICK, soundOnOff);
			animationMenu.modelOnOff.addEventListener(MouseEvent.CLICK, modelOnOff);
			animationMenu.fullOnOff.addEventListener(MouseEvent.CLICK, goFullScreen);
			
			layerAtividade.setChildIndex(cronometro, layerAtividade.numChildren - 1);
			//layerAtividade.setChildIndex(timeControl, layerAtividade.numChildren - 1);
			//layerAtividade.setChildIndex(wireOnOff, layerAtividade.numChildren - 1);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(Event.RESIZE, onResize);
			
			//removeStats(ai);
			ai.initialize();
			
			//camadaEletrons = new CamadaEletrons(15, 150, 10, 20, 90, 10);
			//camadaEletrons.setLight(mainLight);
			//camadaEletrons.addEventListener("playSound", playSound);
			//modelo.object3d = camadaEletrons;
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function goFullScreen(e:MouseEvent):void 
		{
			if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}else {
				stage.displayState = StageDisplayState.NORMAL;
			}
			onResize(null);
		}
		
		private function openCloseCron(e:MouseEvent):void 
		{
			if (cronometro.x < 0) {
				Actuate.tween(cronometro, 0.5, { x:10 } );
				cronometro.openClose.gotoAndStop("CLOSE");
			}
			else {
				Actuate.tween(cronometro, 0.5, { x: -100 } );
				cronometro.openClose.gotoAndStop("OPEN");
			}
		}
		
		public function removeStats(ai:AI):void {
            ai.container.optionButtons.removeChild(ai.container.optionButtons.btStatistics)
            var qtBotoes:int = ai.container.optionButtons.numChildren-1            
            var mheight:int = -8;
            for (var i:int = 1; i <= qtBotoes; i++) {                
                mheight += ai.container.optionButtons.getChildAt(i).height + 6;
                trace(mheight, ai.container.optionButtons.getChildAt(i))
                ai.container.optionButtons.getChildAt(i).y = mheight;
            }
            mheight += 28
            ai.container.optionButtons.getChildAt(0).height = mheight;
			ai.container.optionButtons.y += 38;
           // trace(qtBotoes, mheight)
        }
		
		private function changeTime(e:Event):void 
		{
			camadaEletrons.velMult = animationMenu.timeControl.value;
		}
		
		private function changeAcel(e:Event):void 
		{
			camadaEletrons.setAceleracao(animationMenu.acelControl.value, 0, 0);
		}
		
		private var currentScale:Number = 1;
		private function changeScale(e:Event):void
		{
			var newSlace:Number = animationMenu.scaleControl.value;
			for each (var item:FlarMark in marcas) 
			{
				if (item != markerBase) {
					item.transform.appendScale(1/currentScale, 1/currentScale, 1/currentScale);
					item.transform.appendScale(newSlace, newSlace, newSlace);
					//item.transform.appendScale();
					//item.modelo.object.scaleX = newSlace;
					//item.modelo.object.scaleY = newSlace;
					//item.modelo.object.scaleZ = newSlace;
				}
			}
			currentScale = newSlace;
		}
		
		private function cubeOnOff(e:MouseEvent):void 
		{
			if (animationMenu.wireOnOff.currentFrame == 1) {
				animationMenu.wireOnOff.gotoAndStop(2);
				camadaEletrons.cubo.visible = false;
			}else {
				animationMenu.wireOnOff.gotoAndStop(1);
				camadaEletrons.cubo.visible = true;
			}
		}
		
		private var tocarSom:Boolean = true;
		private function soundOnOff(e:MouseEvent):void 
		{
			if (animationMenu.soundOnOff.currentFrame == 1) {
				animationMenu.soundOnOff.gotoAndStop(2);
				tocarSom = false;
			}else {
				animationMenu.soundOnOff.gotoAndStop(1);
				tocarSom = true;
			}
		}
		
		private var permitirModelo:Boolean = true;
		private function modelOnOff(e:MouseEvent):void 
		{
			if (animationMenu.modelOnOff.currentFrame == 1) {
				animationMenu.modelOnOff.gotoAndStop(2);
				permitirModelo = false;
				if (cron.isRunning()) {
					pauseCronometro(null);
				}
			}else {
				animationMenu.modelOnOff.gotoAndStop(1);
				permitirModelo = true;
			}
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE) {
				if (cron.isRunning()) {
					pauseCronometro(null);
				}else {
					startCronometro(null);
				}
			}
		}
		
		private var maxCron:Number = 999;
		private function startCronometro(e:MouseEvent):void 
		{
			if (!permitirModelo) return;
			if (totalTime >= maxCron) return;
			cron.start();
			camadaEletrons.counting = true;
			cronometro.btn_play.visible = false;
		}
		
		private function pauseCronometro(e:MouseEvent):void 
		{
			cron.pause();
			camadaEletrons.counting = false;
			cronometro.btn_play.visible = true;
		}
		
		private function resetCronometro(e:MouseEvent):void 
		{
			cron.stop();
			cron.reset();
			totalTime = 0;
			camadaEletrons.counting = false;
			camadaEletrons.count = 0;
			cronometro.btn_play.visible = true;
			cronometro.display.text = "0,0";
			cronometro.counter.text = "0";
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
		
		private var mainLight:PointLight;
		private function setup3d():void
		{
			var markerSysConf:FLARMarkerSystemConfig = new FLARMarkerSystemConfig(getSketchFile(cameraIndex), rasterWidth, rasterHeight);
			markerSys = new FLARAway3DMarkerSystem(markerSysConf);
			
			arSensor = new FLARSensor(new FLARIntSize(rasterWidth, rasterHeight));
			
			view3d = new View3D(new Scene3D(), markerSys.getAway3DCamera());
			view3d.width = rect.width;
			view3d.height = rect.height;
			
			mainLight = new PointLight();
			mainLight.x = 0;
			mainLight.y = 500;
			mainLight.z = -500;
			mainLight.color = 0xFFFFFF;
			//mainLight.ambientColor = 0x008000;
			//mainLight.ambient = 2;
			mainLight.radius = 400;
			view3d.scene.addChild(mainLight);
			
			camadaEletrons.setLight(mainLight);
			
			view3d.background = new FLARWebCamTexture(cameraWidth, cameraHeight);
			
			layerAtividade.addChild(view3d);
		}
		
		private var inicialWidth:Number;
		private var inicialHeight:Number;
		private function onResize(e:Event):void 
		{
			var scale:Number;
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				animationMenu.fullOnOff.gotoAndStop(1);
				scale = Math.min(stage.fullScreenHeight / rect.height, stage.fullScreenWidth / rect.width);
				//var scale:Number = stage.fullScreenHeight / stage.stageHeight;
				//trace(scale);
				view3d.width = rect.width * scale;
				view3d.height = rect.height * scale;
				this.width = rect.width * scale;
				this.height = rect.height * scale;
				
				//view3d.width = stage.fullScreenWidth;
				//view3d.height = stage.fullScreenHeight;
				//this.width = stage.fullScreenWidth;
				//this.height = stage.fullScreenHeight;
			}else {
				animationMenu.fullOnOff.gotoAndStop(2);
				scale = Math.min(stage.stageHeight / rect.height, stage.stageWidth / rect.width);
				view3d.width = rect.width * scale;
				view3d.height = rect.height * scale;
				this.width = rect.width * scale;
				this.height = rect.height * scale;
				
				//view3d.width = stage.stageWidth;
				//view3d.height = stage.stageHeight;
				//this.width = stage.stageWidth;
				//this.height = stage.stageHeight;
			}
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
		
		private var totalTime:Number = 0;
		private function onEnterFrame(e:Event):void 
		{
			if (camadaEletrons.counting) {
				totalTime += Number((cron.read() / 1000) * animationMenu.timeControl.value);
				cron.reset();
				cronometro.display.text = totalTime.toFixed(1).replace(".", ",");
				cronometro.counter.text = String(camadaEletrons.count);
				if (totalTime >= maxCron) pauseCronometro(null);
			}
			
			arSensor.update_3(camera.video, scaleRatio);
			markerSys.update(arSensor);
			FLARWebCamTexture(view3d.background).update(camera.video);
			var marcasStage:Vector.<FlarMark> = new Vector.<FlarMark>();
			
			search: for each (var marca:FlarMark in marcas) 
			{
				if (markerSys.isExistMarker(marca.markerId)) {
					if (marca == markerBase) {
						if (marcasStage.length > 0) {
							marca.modelo.object.visible = false;
							break search;
						}
					}
					
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
				if (marcaStage == markerBase) {
					baseModeloLamina.visible = true;
					animationMenu.scaleControl.enabled = false;
					animationMenu.scaleControl.alpha = 0.5;
					
				}
				else {
					baseModeloLamina.visible = false;
					animationMenu.scaleControl.enabled = true;
					animationMenu.scaleControl.alpha = 1;
				}
				
				if (permitirModelo) marcaStage.modelo.object.visible = true;
				else marcaStage.modelo.object.visible = false;
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