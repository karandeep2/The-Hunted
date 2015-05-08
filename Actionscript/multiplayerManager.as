package  {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	
	
	public class multiplayerManager extends Screen 
	{
		
		private var cm : ConnectionManager;
		private var m : GameModel;
		private var gc : gameController;
		private var userName : String = "";
		private var roomName : String = "room";
		private var changed : Boolean = true;
		private var shipNum : int = 0;
		private var lasNum : int = 0;
		
		private var speed : int = 1;
		
		public function multiplayerManager(sn:int , ls:int) 
		{

			trace("sent variable is: " + sn);
			
			shipNum = sn;
			lasNum = ls;
			
			trace("shipNum mm is: " + shipNum);
			
			/*create a random name to be used as the user name
			this is the primary place where this needs to be changed
			however a method will be made later in order to change
			this based upon the users choice in the log in screen
			*/
			userName = Math.ceil((Math.random() * 100)).toString();
			m = new GameModel(this);
			cm = new ConnectionManager(this);
			cm.connect(userName, roomName);
			m.setName(userName);
			gc  = new gameController(this);
			//cm.broadcast("!addPlayer 100 100 " + m.getName() + " " + shipNum);
			
			var updateTimer:Timer = new Timer(10);
			updateTimer.addEventListener(TimerEvent.TIMER, updateTimerListener);
			updateTimer.start();
		}
		
		override public function update()
		{
			gc.update();
			m.update();
			
			var temp : Player = m.getPlayer();
			var tempX = temp.x;
			var tempY = temp.y;
			var rot = temp.rotation;
			
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
					cm.broadcast("!addPlayer " + m.getPlayer().x.toString() + " " + m.getPlayer().y.toString() + " " + m.getPlayer().getPlayerId().toString() + " " + shipNum); //add this player to the new client
				}
				
			}
			else if(message.indexOf("!up") >=0)
			{
				//trace("update");
				m.updatePlayer(message);
				
			}
			else if(message.indexOf("!removePlayer") >=0)
			{
				m.removePlayer(message);
			}
			
			if(message.indexOf("!f") >=0)
			{
				m.createProjectile(message);
			}
			
			if(message.indexOf("!des") >=0)
			{
				m.destroy(message);
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
				temp.moveDir(-1);
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
				temp.moveDir(1);
			}
			
			//broadcast the players positon to the other players
			//cm.broadcast("!updatePlayer " + tempX + " " + tempY + " " + userName);
		}
		
		//message passed on from the controller to fire weapon
		public function fire()
		{
			var temp : Player = m.getPlayer();
			//get the players rotation (players rotation is equal to the missiles rotation)
			var rot = temp.rotation;
			//get the position (position is equal to the players original position)
			var xPos = temp.x;
			var yPos = temp.y;
			
			trace(rot);
			
			cm.broadcast("!f " + xPos + " " + yPos + " " + rot + " " + userName + " " + lasNum);
		}
		
		//send position updates to the other players
		public function updateTimerListener(e:TimerEvent) : void
		{
				
			var temp : Player = m.getPlayer();
			//get the players rotation (players rotation is equal to the missiles rotation)
			var rot = temp.rotation;
			//get the position (position is equal to the players original position)
			var tempX = temp.x;
			var tempY = temp.y;
			
			
			//optomisation, dont need to update if not moved
			if(changed == true)
			{
				cm.broadcast("!up " + tempX + " " + tempY + " " + rot + " " + userName);
				changed = false;
			}
	
		}

		public function event(e : KeyboardEvent) : void
		{
			gc.event(e);
		}
		
		public function getXBounds() : int
		{
			return stage.stageWidth * 4;
		}
		
		public function getYBounds() : int
		{
			return stage.stageHeight * 4;
		}
		
		public function setChanged(b : Boolean)
		{
			changed = b;
		}
		
		public function destroy(miss : Missile)
		{
			cm.broadcast("!des " + userName); 
		}
		
		public function getShipNum() : String
		{
			return shipNum.toString();
		}
		
		public function removeMissile( miss : Missile)
		{
			m.removeMissile(miss);
		}
	}
	
}
