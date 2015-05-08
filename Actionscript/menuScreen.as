package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	
	public class menuScreen extends Screen 
	{
		private var p = null;		
		
		public function menuScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			Start.addEventListener(MouseEvent.CLICK, start);
		}
		
		
		override public function update()
		{
			
		}
		
		public function addedHandler(e:Event)
		{
			p = this.parent;
		}
		
		public function start(e:Event)
		{
			p.mm();
		}

	}
	
}
