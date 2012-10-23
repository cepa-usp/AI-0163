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
		private const openY:Number = 445;
		private const closeY:Number = 495;
		private const tweenOpenCloseTime:Number = 0.5;
		
		private var bkg:MovieClip;
		
		private var _timeControl:Slider;
		private var _acelControl:Slider;
		private var _wireOnOff:WireButton;
		
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
			
			//Slider controle do tempo
			_timeControl = new Slider();
			_timeControl.liveDragging = true;
			_timeControl.maximum = 1;
			_timeControl.minimum = 0.05;
			_timeControl.snapInterval = 0.05;
			_timeControl.tickInterval = 0.1;
			_timeControl.value = 1;
			_timeControl.width = 200;
			_timeControl.x = 40;
			_timeControl.y = 30;
			addChild(_timeControl);
			
			var timeText:TextField = new TextField();
			timeText.autoSize = TextFieldAutoSize.LEFT;
			timeText.text = "Velocidade da animação";
			timeText.x = 125 - timeText.textWidth / 2 + 20;
			addChild(timeText);
			
			//Slider controle da aceleração
			_acelControl = new Slider();
			_acelControl.liveDragging = true;
			_acelControl.maximum = 30;
			_acelControl.minimum = 0;
			_acelControl.snapInterval = 1;
			_acelControl.tickInterval = 1;
			_acelControl.value = 15;
			_acelControl.width = 200;
			_acelControl.x = -240;
			_acelControl.y = 30;
			addChild(_acelControl);
			
			var acelText:TextField = new TextField();
			acelText.autoSize = TextFieldAutoSize.LEFT;
			acelText.text = "Aceleração dos elétrons";
			acelText.x = -125 - acelText.textWidth / 2 - 20;
			addChild(acelText);
			
			//Botão do wireframe
			_wireOnOff = new WireButton();
			_wireOnOff.x = 0;
			_wireOnOff.y = 25;
			addChild(_wireOnOff);
			
			//Botão de abrir e fechar
			openClose = new OpenClose();
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
			Actuate.tween(this, tweenOpenCloseTime, { y:openY } );
			menuOpen = true;
			openClose.gotoAndStop("CLOSE");
		}
		
		public function closeMenu():void
		{
			if (!menuOpen) return;
			Actuate.tween(this, tweenOpenCloseTime, { y:closeY } );
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
		
		public function get wireOnOff():WireButton 
		{
			return _wireOnOff;
		}
		
	}

}