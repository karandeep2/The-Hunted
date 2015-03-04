package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class boost extends Item
	{
		private var p = null;
		private var tag : String = "boots";
		
		public function boost() 
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
		
		public function update()
		{
			if(this.hitTestObject(p.getPlayer()) == true)
			{
				trace("collide");
				p.itemPickup(this.tag);
				p.removeChild(this);
			}
		}
		
	}
	
}
