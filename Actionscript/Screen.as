package  {
	
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Screen extends MovieClip{

		private var p = null;
		private var s = null;
		
		public function Screen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		public function update()
		{
			trace("unimplemented");
		}
		
		private function addedHandler(e:Event) : void
		{
			p = this.parent;
		}
		
		private function removedHandler(e:Event) : void
		{
			//nothing
		}

	}
	
}
