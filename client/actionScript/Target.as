package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class Target extends MovieClip {
		
		var p = null;
		var arr = null;
		var canCollide = true;
		
		public function Target() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
			
		}
		
		private function addedHandler(ev : Event)
		{
			p = this.parent;
			
			//this.x = p.x + ((stage.stageWidth / 2)+ 40);
			//this.y = p.y + (stage.stageHeight / 2);
		}
		
		private function removedHandler(ev : Event)
		{
			
		}
		
		public function update()
		{
			trace("target update");
			arr = p.getObjs();
			trace("getOBJS");
			
			for(var i = 0; i < arr.length; i++)
			{
				if(this.hitTestObject(arr[i]) && canCollide == true)
				{
					//p.removeChild(arr[i]);
					arr.splice(arr.length, 1);
					//p.removeChild(this);
					this.visible = false;
					canCollide = false;
				}
			}
		}
		
	}
	
}
