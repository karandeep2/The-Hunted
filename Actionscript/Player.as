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
		
		//add x or y speed to the player
		public function addXSpeed( xs : Number)
		{
			xSpeed = xSpeed + xs;
			
			//limit the maxmimum speed
			if(xSpeed > maxSpeed)
			{
				xSpeed = maxSpeed;
			}
			else if(xSpeed < -maxSpeed)
			{
				xSpeed = -maxSpeed;
			}
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
			rotation += rot;
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
		
			//then move the player
			x += xSpeed;
			y += ySpeed;
			
		}
		
		private function wrapAround()
		{
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
		}
		
				
		public function moveDir()
		{
			if(rotation >= 0 && rotation < 90)
			{
				//top - right
				
				if(rotation > 45)
				{
					var tempX = ((rotation / 90)/100); //a percentage of the rotation
					var tempY = 1 - tempX; //if tempX = 0.6 temp T = 0.4
					addXSpeed(tempX * 2);
					addYSpeed(tempY * 2);
				}
				else if(rotation < 45)
				{
					var tempY = ((rotation / 90)/100); //a percentage of the rotation
					var tempX = 1 - tempY;
					addXSpeed(tempX * 2);
					addYSpeed(tempY * 2);
				}
				else
				{
					addXSpeed(1);
					addYSpeed(1);
				}
				
			}
			else if(rotation >= 90 && rotation < 180)
			{
				//right - bottom
				var tempR = rotation - 90;
				if(tempR > 45)
				{
					var tempX = ((tempR / 90)/100); //a percentage of the rotation
					var tempY = 1 - tempX; //if tempX = 0.6 temp T = 0.4
					addXSpeed(tempX * 2);
					addYSpeed(-(tempY * 2));
				}
				else if(tempR < 45)
				{
					var tempY = ((tempR / 90)/100); //a percentage of the rotation
					var tempX = 1 - tempY;
					addXSpeed(tempX * 2);
					addYSpeed(-(tempY * 2));
				}
				else
				{
					addXSpeed(1);
					addYSpeed(1);
				}
				
			}
			else if(rotation >= 180 && rotation < 270)
			{
				//bottom - left
				var tempR = tempR - 180;
				if(tempR > 45)
				{
					var tempX = ((tempR / 90)/100); //a percentage of the rotation
					var tempY = 1 - tempX; //if tempX = 0.6 temp T = 0.4
					addXSpeed(-(tempX * 2));
					addYSpeed(-(tempY * 2));
				}
				else if(tempR < 45)
				{
					var tempY = ((tempR / 90)/100); //a percentage of the rotation
					var tempX = 1 - tempY;
					addXSpeed(-(tempX * 2));
					addYSpeed(-(tempY * 2));
				}
				else
				{
					addXSpeed(1);
					addYSpeed(1);
				}
				
			}
			else
			{
				//left - top
				var tempR = rotation - 270;
				if(tempR > 45)
				{
					var tempX = ((tempR / 90)/100); //a percentage of the rotation
					var tempY = 1 - tempX; //if tempX = 0.6 temp T = 0.4
					addXSpeed(-(tempX * 2));
					addYSpeed(tempY * 2);
				}
				else if(tempR < 45)
				{
					var tempY = ((tempR / 90)/100); //a percentage of the rotation
					var tempX = 1 - tempY;
					addXSpeed(-(tempX * 2));
					addYSpeed(tempY * 2);
				}
				else
				{
					addXSpeed(1);
					addYSpeed(1);
				}
			}
		}
		
		
		private function addedHandler(e:Event)
		{
			p = this.parent;
			xBounds = p.getXBounds();
			yBounds = p.getYBounds();
		}
		

	}
	
}
