package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Alexandre
	 */
	public class Evt extends Event 
	{
		public var particula:Particula;
		
		public function Evt(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}