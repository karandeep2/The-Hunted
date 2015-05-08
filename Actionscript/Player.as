package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Player extends MovieClip
	{
		
		private var id : String;
		private var status : Boolean = true;
		private var isCurrent : Boolean = false;
		private var xSpeed : Number = 0;
		private var ySpeed : Number = 0;
		private var xBounds : int = 0;
		private var yBounds : int = 0;
		private var rotationSpeed : Number = 0;
		private var slowDownSpeed : Number = 0.01;
		private var maxSpeed : int = 10;
		private var p = null;

		public function Player(name : String)
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			trace("created new player: " + name);
			id = name;
			this.x = 0;
			this.y = 0;
		}
		/*
		public function Player(name : String, xPos: int, yPos : int, rot : int)
		{
			this.id = name;
			this.x = xPos;
			this.y = yPos;
			this.rotation = rot;
		}
		*/
		public function setPosition(xPos : int, yPos : int)
		{
			this.x = xPos;
			this.y = yPos;
			//this.rotation = rot;
		}
		

		
		public function addYSpeed( ys : Number)
		{
			ySpeed = ySpeed + ys;
			if(ySpeed > maxSpeed)
			{
				ySpeed = maxSpeed;
			}
			else if(ySpeed < -maxSpeed)
			{
				ySpeed = -maxSpeed;
			}
		}
		
		public function rotate(rot : int)
		{
			//add to rotation speed limit top speed
			
			rotation+= (rot * 5);
			
				
		}
		
		//Changed from getId to getPlayerId - to remove conflict in names.
		public function getPlayerId() : String
		{
			return id;
		}
				
		public function setStatus(stat : Boolean)
		{
			status = stat;
		}
		
		public function getStatus() : Boolean
		{
			return status;
		}
		
		//only called for the current player
		public function update() : void
		{
			move();
			wrapAround(); //temporary code to wrap the player around
		}
		
		//sets the player to be this clients player
		public function setCurrent()
		{
			isCurrent = true;
		}
		
		//adds acceleration to the player
		private function move()
		{
			//first slow the player down in order to stop the player naturally
			
			if(xSpeed > 0)
			{
				xSpeed -= slowDownSpeed;
			}
			else if(xSpeed < 0)
			{
				xSpeed += slowDownSpeed;
			}
			
			if(ySpeed > 0)
			{
				ySpeed -= slowDownSpeed;
			}
			else if(ySpeed < 0)
			{
				ySpeed += slowDownSpeed;
			}
			
			if(xSpeed != 0 || ySpeed != 0)
			{
				p.setChanged(true);
			}
			
			//move the movie clip
			p.x -= xSpeed;
			p.y -= ySpeed;
			
			//then move the player
			x += xSpeed;
			y += ySpeed;
			
			//rotation ease off
			
			
		}
		
		private function wrapAround()
		{
			/*
			if(x > xBounds)
			{
				x = 0;
			}
			else if(x < 0)
			{
				x = xBounds;
			}
			
			if(y > yBounds)
			{
				y = 0;
			}
			else if(y < 0)
			{
				y = yBounds;
			}
			*/
		}
		
		/*
			Move in a direction using sin for xSpeed and cosine for y speed
			multiplied by dir which will be either 1 or -1 for forwards or
			backwards respectivly.
		*/
		public function moveDir(dir : int)
		{
			var angle :Number = rotation * Math.PI / 180;
			xSpeed += dir * (Math.sin(angle));
			ySpeed += dir * -((Math.cos(angle)));
			
			//todo need to limit the max speed of x and y speed using the maxSpeed variable
		}
		
		
		private function addedHandler(e:Event)
		{
			p = this.parent;
			xBounds = p.getXBounds();
			yBounds = p.getYBounds();
		}
	
	}
	
}
