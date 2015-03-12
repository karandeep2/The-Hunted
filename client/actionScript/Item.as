package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Item extends MovieClip
	{
		private var p = null;
		
		public function Item() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		private function addedHandler(ev : Event)
		{
			p = this.parent;
			this.x = p.x + (stage.stageWidth / 2) + 200;
			this.y = p.y + (stage.stageHeight / 2) + 200;
		}
		
		private function removedHandler(ev : Event)
		{
			
		}
		
	}
	
}
