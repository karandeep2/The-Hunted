package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class gameScreen extends MovieClip {
		
		private var p = null;
		private var playerArr = new Array;
		
		public function gameScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		public function update() : void
		{	
			if(playerArr.length > 0)
			{
				for(var i = 0; i < playerArr.length; i++)
				{
					playerArr[i].update();
				}
			}
		}
		
		public function getKeyDownArr() : Array
		{
			var arr = p.getKeyDownArr();
			return arr;
		}
		
		private function addedHandler(ev : Event)
		{
			p = this.parent;
			this.x = stage.stageWidth / 2;
			this.y = stage.stageHeight / 2;
				
			playerArr.push(new player());
			
			addChild(playerArr[0]);
		}
	}
	
}
