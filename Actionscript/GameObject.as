package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class GameObject 
	{

		private var p = null;
		
		public function GameObject() extends MovieClip
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}

		private function addedHandler(e : Event)
		{
			p = this.parent;
		}
		
		private function removedHandler(e : Event)
		{
			
		}

	}
	
}

