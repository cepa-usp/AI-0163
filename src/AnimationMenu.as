package  
{
	import com.eclecticdesignstudio.motion.Actuate;
	import fl.controls.Slider;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class AnimationMenu extends Sprite
	{
		private var menuOpen:Boolean = true;
		private var openX:Number = 10;
		private var closeX:Number = -100;
		private const tweenOpenCloseTime:Number = 0.5;
		
		private var bkg:MovieClip;
		
		private var _timeControl:Slider;
		private var _acelControl:Slider;
		private var _scaleControl:Slider;
		private var _wireOnOff:OnOffButton;
		private var _soundOnOff:OnOffButton;
		private var _modelOnOff:OnOffButton;
		
		private var openClose:OpenClose;
		
		public function AnimationMenu() 
		{
			createVisual();
		}
		
		private function createVisual():void 
		{
			//Backgroud
			bkg = new AnimationMenuBkg();
			addChild(bkg);
			
			var widthSliders:Number = 80;
			var slidersX:Number = 13;
			
			//Slider controle do tempo
			_timeControl = new Slider();
			_timeControl.liveDragging = true;
			_timeControl.maximum = 1;
			_timeControl.minimum = 0.05;
			_timeControl.snapInterval = 0.05;
			//_timeControl.tickInterval = 0.1;
			_timeControl.value = 1;
			_timeControl.width = widthSliders;
			_timeControl.x = slidersX;
			_timeControl.y = 88;
			addChild(_timeControl);
			
			//var timeText:TextField = new TextField();
			//timeText.selectable = false;
			//timeText.autoSize = TextFieldAutoSize.LEFT;
			//timeText.text = "Velocidade da animação";
			//timeText.x = 125 - timeText.textWidth / 2 + 20;
			//addChild(timeText);
			
			//Slider controle da aceleração
			_acelControl = new Slider();
			_acelControl.liveDragging = true;
			_acelControl.maximum = 30;
			_acelControl.minimum = 0;
			_acelControl.snapInterval = 1;
			//_acelControl.tickInterval = 1;
			_acelControl.value = 15;
			_acelControl.width = widthSliders;
			_acelControl.x = slidersX;
			_acelControl.y = 36;
			addChild(_acelControl);
			
			//var acelText:TextField = new TextField();
			//acelText.selectable = false;
			//acelText.autoSize = TextFieldAutoSize.LEFT;
			//acelText.text = "Aceleração dos elétrons";
			//acelText.x = -125 - acelText.textWidth / 2 - 20;
			//addChild(acelText);
			
			//Slider controle da escala
			_scaleControl = new Slider();
			_scaleControl.liveDragging = true;
			_scaleControl.maximum = 3;
			_scaleControl.minimum = 1;
			_scaleControl.snapInterval = 0.1;
			//_scaleControl.tickInterval = 0.5;
			_scaleControl.value = 1;
			_scaleControl.width = widthSliders;
			_scaleControl.x = slidersX;
			_scaleControl.y = 129;
			addChild(_scaleControl);
			
			//var scaleText:TextField = new TextField();
			//scaleText.selectable = false;
			//scaleText.autoSize = TextFieldAutoSize.LEFT;
			//scaleText.text = "Aceleração dos elétrons";
			//scaleText.x = -125 - scaleText.textWidth / 2 - 20;
			//addChild(scaleText);
			
			//Botão do wireframe
			_wireOnOff = new OnOffButton();
			_wireOnOff.x = 77;
			_wireOnOff.y = 160;
			_wireOnOff.buttonMode = true;
			addChild(_wireOnOff);
			
			//Botão do som
			_soundOnOff = new OnOffButton();
			_soundOnOff.x = 77;
			_soundOnOff.y = 176;
			_soundOnOff.buttonMode = true;
			addChild(_soundOnOff);
			
			//Botão do modelo
			_modelOnOff = new OnOffButton();
			_modelOnOff.x = 77;
			_modelOnOff.y = 192;
			_modelOnOff.buttonMode = true;
			addChild(_modelOnOff);
			
			//var wireText:TextField = new TextField();
			//wireText.selectable = false;
			//wireText.autoSize = TextFieldAutoSize.LEFT;
			//wireText.text = "Bordas";
			//wireText.x = - wireText.textWidth / 2;
			//addChild(wireText);
			
			//Botão de abrir e fechar
			openClose = new OpenClose();
			openClose.x = 105;
			openClose.y = 23;
			openClose.buttonMode = true;
			addChild(openClose);
			openClose.gotoAndStop("CLOSE");
			openClose.addEventListener(MouseEvent.CLICK, openCloseFunc);
		}
		
		private function openCloseFunc(e:MouseEvent):void 
		{
			if (menuOpen) closeMenu();
			else openMenu();
		}
		
		public function openMenu():void
		{
			Actuate.tween(this, tweenOpenCloseTime, { x:openX } );
			menuOpen = true;
			openClose.gotoAndStop("CLOSE");
		}
		
		public function closeMenu():void
		{
			if (!menuOpen) return;
			Actuate.tween(this, tweenOpenCloseTime, { x:closeX } );
			menuOpen = false;
			openClose.gotoAndStop("OPEN");
		}
		
		public function get timeControl():Slider 
		{
			return _timeControl;
		}
		
		public function get acelControl():Slider 
		{
			return _acelControl;
		}
		
		public function get scaleControl():Slider 
		{
			return _scaleControl;
		}
		
		public function get wireOnOff():OnOffButton 
		{
			return _wireOnOff;
		}
		
		public function get soundOnOff():OnOffButton 
		{
			return _soundOnOff;
		}
		
		public function get modelOnOff():OnOffButton 
		{
			return _modelOnOff;
		}
		
	}

}