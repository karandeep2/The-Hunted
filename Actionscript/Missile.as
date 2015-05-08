package 
{
	import flash.events.Event;
	public class Missile extends Entity 
	{

		private var speed = 10;
		private var immune = false;
		private var player : Player = null;
		private var p = null;

		public function Missile(tmpX : int, tmpY : int, tmpR : int, plyr : Player) 
		{
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			x = tmpX;
			y = tmpY;
			rotation = tmpR;
			player = plyr;
		}
		
		override public function update()
		{
			var angle :Number = rotation * Math.PI / 180;
			x += speed * Math.sin(angle);
			y += speed * -Math.cos(angle);
			
			checkCollisions();
		}
		
		//ignore this player
		public function setImmune()
		{
			immune = true;
		}
		
		//check for collisions ignoring this player
		private function checkCollisions()
		{
			if(immune == false)
			{
				if(this.hitTestObject(player))
				{
					p.destroy(this);
				}
			}
		}
		
		public function addedHandler(e:Event)
		{
			p = this.parent;
		}

	}
	
}
