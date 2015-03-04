package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class mainPlayer extends MovieClip 
	{
		
		private var p = null;
		
		private var speed = 10;
		private var xDir = 0;
		private var yDir = 0;
		private var dir = 0;
		
		private var fired = true;
		
		private var ai = false;
		
		private var player = null;
		
		var arr = null;
		
		public function mainPlayer() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
			this.gotoAndStop(1);
		}
		
		private function addedHandler(ev : Event)
		{
			p = this.parent;
			player = p.getPlayer();
			this.x = p.x + (stage.stageWidth / 2);
			this.y = p.y + (stage.stageHeight / 2);
		}
		
		private function removedHandler(ev : Event)
		{
			
		}
		
		public function update()
		{
			move();
			checkCollisions();
		}
		
		private function move()
		{
			
			if(ai != true)
			{
				
			
				var arr = p.getKeyDownArr();
				
				if(arr[37] == true)
				{
					p.x += speed;
					this.x -= speed;
					dir = 4;
					xDir = -1;
					yDir = 0;
					this.gotoAndStop(dir);
					
				}
				
				if(arr[38] == true)
				{
					p.y += speed;
					this.y -= speed;
					if(arr[37]==true)
					{
						dir = 5;
						xDir = -1;
						yDir = -1;
						
						this.gotoAndStop(dir); //topleft
					}
					else
					{
						xDir = 0;
						yDir = -1;
						dir = 1;
						this.gotoAndStop(dir);
					}
					
				}
				
				if(arr[39] == true)
				{
					p.x -= speed;
					this.x += speed;
					if(arr[38] == true)
					{
						xDir = 1;
						yDir = -1;
						dir = 6;
						this.gotoAndStop(dir); //topright
					}
					else
					{	
						yDir = 0;
						xDir = 1;
						dir = 2;
						this.gotoAndStop(dir);
					}
				}
				
				if(arr[40] == true)
				{
					p.y -= speed;
					this.y += speed;
					if(arr[39] == true)
					{
						xDir = 1;
						yDir = 1;
						dir = 7;
						this.gotoAndStop(dir); //bottom right
					}
					else if(arr[37] == true) //bottom left
					{
						xDir = -1;
						yDir = 1;
						dir = 8;
						this.gotoAndStop(dir);
					}
					else
					{
						xDir = 0;
						yDir = 1;
						dir = 3;
						this.gotoAndStop(dir);
					}
					
					
				
				}
				
				if(fired != true)
				{
					if(arr[32] == true)
					{
						p.fire(this.x, this.y, xDir, yDir);
						//fired = true;
					}
				}
				else
				{
					if(arr[32] == false)
					{
						fired = false;
					}
				}
					
				
			}
			else
			{
				if(player.x < this.x)
				{
					this.x -= speed;
					dir = 4;
					xDir = -1;
					yDir = 0;
					this.gotoAndStop(dir);
					
				}
				
				if(player.y < this.y) //go up
				{
					this.y -= speed;
					if(player.x < this.x)
					{
						dir = 5;
						xDir = -1;
						yDir = -1;
						
						this.gotoAndStop(dir); //topleft
					}
					else
					{
						xDir = 0;
						yDir = -1;
						dir = 1;
						this.gotoAndStop(dir);
					}
					
				}
				
				if(player.x > this.x)
				{
					this.x += speed;
					if(player.y < this.y)
					{
						xDir = 1;
						yDir = -1;
						dir = 6;
						this.gotoAndStop(dir); //topright
					}
					else
					{	
						yDir = 0;
						xDir = 1;
						dir = 2;
						this.gotoAndStop(dir);
					}
				}
				
				if(player.y > this.y)
				{
					this.y += speed;
					if(player.x > this.x)
					{
						xDir = 1;
						yDir = 1;
						dir = 7;
						this.gotoAndStop(dir); //bottom right
					}
					else if(player.x < this.x) //bottom left
					{
						xDir = -1;
						yDir = 1;
						dir = 8;
						this.gotoAndStop(dir);
					}
					else
					{
						xDir = 0;
						yDir = 1;
						dir = 3;
						this.gotoAndStop(dir);
					}
					
				
			}
			
				if(player.x == this.x || player.y == this.y)
					{
						if(fired != true)
						{
							p.fire(this.x, this.y, xDir, yDir);
							fired = true;
						}
					}
					else
					{
						fired = false;
					}
		}
		
	}
	
		public function checkCollisions()
		{
			arr = p.getObjs();
			
			for(var i = 0; i < arr.length; i++)
			{
				if(this.hitTestObject(arr[i]) && ai == true )
				{
					p.removeChild(arr[i]);
					arr.splice(arr.length, 1);
					this.x = p.x + (stage.stageWidth / 2);
					this.y = p.y + (stage.stageHeight / 2);
				}
			}
		}
		public function speedBoost(i : int)
		{
			speed = i;
		}
		
		public function makeAi()
		{
			ai = true;
			this.x += 100;
		}
		
	
	}
}
