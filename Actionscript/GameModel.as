package  {
	import flash.geom.Utils3D;
	
	public class GameModel 
	{
		
		private var p = null;
		private var players : Array = new Array();
		private var thisPlayer : Player;
		private var playerName : String;
		private var playerSet : Boolean = false; //has the current player been set?

		public function GameModel(par : multiplayerManager) 
		{
			p = par;
		}
		
		public function update()
		{
			if(playerSet)
			{
				trace("updating player");
				thisPlayer.update();
			}
		}
		
				
		public function setName(name : String)
		{
			playerName = name;
		}

		/*
		 * This has purpose of adding a new player to the model. 
		 * params m:String - Where m is expected to contain a message "!addPlayer [xPos] [yPos] [playerNum]"
		 */
		public function addPlayer(m : String) : Boolean
		{	
			//!addPlayer xPos yPos playerName
			var split:Array = m.split(" ");
			if(split.length > 0)
			{
				if(split[0] == "!addPlayer")
				{
					var found = false;
					
					//check if the player exists allready
					for(var i = 0; i < players.length; i++)
					{
						if(split[3] == players[i].getPlayerId())
						{
							found = true;
						}
					}
					
					if(found == false)
					{
						var tmpX:int = parseInt(split[1]);
						var tmpY:int = parseInt(split[2]);
						var tmpPlayer:Player = new Player(split[3]);
						tmpPlayer.setPosition(tmpX,tmpY); //0 rotation
						players.push(tmpPlayer);
						//players.push(new Player(split[3],tmpX,tmpY,0));
						p.addChild(tmpPlayer);
						if(tmpPlayer.getPlayerId() == playerName)
						{
							thisPlayer = tmpPlayer;
							thisPlayer.setCurrent();
							playerSet = true;
							found = true;
						}
					}
						
				}
			}
			
			return found;
		}
		
		/*
		 * This has purpose of removing a player from the known model. 
		 * params mes:String - Where mes is expected to contain a message "!removePlayer [playerNum]"
		 * return Boolean - If success, retrun true. Else return false
		 */
		public function removePlayer(mes : String) : Boolean
		{
			var removed:Boolean = false;
			var split:Array = mes.split(" ");
			if(split.length > 0)
			{
				if(split[0] == "!removePlayer")
				{
					//Loop through the player the model knows about
					for(var i:int = 0; i < players.length; i++)
					{
						//If the player currently selected is the same as the player
						//being removed. Remove that player.
						if(players[i].getPlayerId() == split[3])
						{
							players.splice(i, 1);
							removed = true;
						}
					}
				}
			}
			return removed;
		}
		
		public function updatePlayer(m : String)
		{
			var split:Array = m.split(" ");
			if(split.length > 0)
			{
				if(split[0] == "!updatePlayer")
				{
					//Loop through the player the model knows about
					for(var i:int = 0; i < players.length; i++)
					{
						//If the player currently selected is the same as the player
						//being updated. Send new values
						if(players[i].getPlayerId() == split[3] && split[3] != playerName)
						{
							players[i].setPosition(int(split[1]), int(split[2]));
						}
					}
				}
			}
		}
		
		public function getPlayer() : Player
		{
			return thisPlayer;
		}
		
		public function getXBounds() : int
		{
			return p.stage.stageWidth;
		}
		
		public function getYBounds() : int
		{
			return p.stage.stageHeight;
		}

	}
	
}
