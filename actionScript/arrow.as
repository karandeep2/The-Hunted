package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class arrow extends MovieClip {
		
		var speed = 20;
		var xDir = 0;
		var yDir = 0;
		var p = null;
		
		public function arrow(xPos : int, yPos : int, xdir : int, ydir: int) 
		{
			this.x = xPos;
			this.y = yPos;
			xDir = xdir;
			yDir = ydir;
			
			if(xdir == 1)
			{
				if(ydir == - 1)
				{
					this.gotoAndStop(8);
				}
				else if(ydir == 0)
				{
					this.gotoAndStop(1);
				}
				else
				{
					this.gotoAndStop(2);
				}
			}
			
			if(ydir == 1 )
			{
				if(xdir == 0)
				{
					gotoAndStop(3);
				}
				else if(xdir == - 1)
				{
					gotoAndStop(4);
				}
			}
			
			if(xdir == -1)
			{
				if(ydir == 0)
				{
					this.gotoAndStop(5);
				}
				else if(ydir == - 1)
				{
					this.gotoAndStop(6);
				}
			}
			
			if(ydir == -1 && xdir == 0)
			{
				this.gotoAndStop(7);
			}
			
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		private function addedHandler(ev : Event)
		{
			p = this.parent;
		}
		
		private function removedHandler(ev : Event)
		{
			
		}
		
		public function update()
		{
			move();
		}
		
		private function move()
		{
			this.x += (xDir * speed);
			this.y += (yDir * speed);
		}
	}
	
}
