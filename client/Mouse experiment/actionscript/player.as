package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class player extends MovieClip {
		
		private var p = null;
		private var speed = 50;
		
		public function player() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		public function update()
		{
			move();
			rotate();
		}
		
		private function move()
		{
			var arr = p.getKeyDownArr();
			if(arr[37] == true)
			{
				p.x += speed;
				x -= speed;
			}
			
			if(arr[38] == true)
			{
				p.y += speed;
				y -= speed;
			}
			
			if(arr[39] == true)
			{
				p.x -= speed;
				x += speed;
			}
			
			if(arr[40] == true)
			{
				p.y -= speed;
				y += speed;
			}
		}
		
		private function rotate()
		{
			rotation = (180*Math.atan2(stage.mouseY-y,stage.mouseX-x))/Math.PI + 90;
		}
		
		private function addedHandler(ev : Event)
		{
			p = this.parent;
			this.x = p.x/2;
			this.y = p.y/2;
		}
		
		public function setSpeed(s : int)
		{
			speed = s;
		}
		
		public function incrementSpeed(s : int)
		{
			speed += s;
		}
	}
	
}
