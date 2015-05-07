package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	
	
	public class multiplayerManager extends Screen 
	{
		
		private var cm : ConnectionManager;
		private var m : GameModel;
		private var gc : gameController;
		private var userName : String = "";
		private var roomName : String = "room";
		
		private var speed : int = 1;
		
		public function multiplayerManager() 
		{
			/*create a random name to be used as the user name
			this is the primary place where this needs to be changed
			however a method will be made later in order to change
			this based upon the users choice in the log in screen
			*/
			userName = Math.random().toString();
			m = new GameModel(this);
			cm = new ConnectionManager(this);
			cm.connect(userName, roomName);
			m.setName(userName);
			gc  = new gameController(this);
		}
		
		override public function update()
		{
			gc.update();
			m.update();
			
			var temp : Player = m.getPlayer();
			var tempX = temp.x;
			var tempY = temp.y;
			
			cm.broadcast("!updatePlayer " + tempX + " " + tempY + " " + userName);
		}
		
		public function message(message : String) : void
		{
			//trace("DEBUG - Message received: " + message);
			
			//contains either...
			if(message.indexOf("!addPlayer") >= 0)
			{
				//prevents the player responding to something that already exists
				if(!m.addPlayer(message))//returns true if its its own message or the player was already found
				{
					//make this shorter or multiple lines
					cm.broadcast("!addPlayer " + m.getPlayer().x.toString() + " " + m.getPlayer().y.toString() + " " + m.getPlayer().getPlayerId().toString()); //add this player to the new client
				}
				
			}
			else if(message.indexOf("!updatePlayer") >=0)
			{
				//trace("update");
				m.updatePlayer(message);
				
			}
			else if(message.indexOf("!removePlayer") >=0)
			{
				m.removePlayer(message);
			}
		}
		
		/*
		 * 1 - left, 2 - down, 3 - right, 4 - up
		 */
		public function move(move : int) : void 
		{
				
			trace("entered move");
			var temp : Player = m.getPlayer();
			var tempX = temp.x;
			var tempY = temp.y;
			
			//move based upon rotation
			
			trace("BEUG - Movement request recieve: " + move);
			if(move == 1) //left
			{
				//tempX = tempX - speed;
				//temp.x -= speed;
				//temp.addXSpeed(-speed);
				temp.rotate(-1);
			}
			else if(move == 2) //down
			{
				//tempY = tempY + speed;
				//temp.y += speed;
			}
			else if(move == 3) //right
			{
				//tempX = tempX + speed;
				//temp.x += speed;
				//temp.addXSpeed(speed);
				temp.rotate(1);
			}
			else if(move == 4) //up
			{
				//tempY = tempY - speed;
				//temp.y -= speed;
				//temp.addYSpeed(-speed);
				temp.moveDir();
			}
			
			//broadcast the players positon to the other players
			//cm.broadcast("!updatePlayer " + tempX + " " + tempY + " " + userName);
		}

		public function event(e : KeyboardEvent) : void
		{
			gc.event(e);
		}
		
		public function getXBounds() : int
		{
			return stage.stageWidth;
		}
		
		public function getYBounds() : int
		{
			return stage.stageHeight;
		}
	}
	
}
