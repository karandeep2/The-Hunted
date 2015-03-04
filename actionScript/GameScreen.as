package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	
	public class GameScreen extends MovieClip {
		
		private var p = null; //stage
		private var player = null; 
		private var ai = null;
		private var boostObj = null;
		private var target1 = null;
		private var target2 = null;
		private var target3 = null;
		private var ar = null;
		private var keyDownArr = new Array;
		private var objArr = new Array;
		
		public function GameScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		private function addedHandler(ev : Event)
		{
			stop();
			p = this.parent;
			//this.x = p.stage.stageWidth/2;
			//this.y = p.stage.stageHeight/2;
			player = new mainPlayer();
			ai = new mainPlayer();
			boostObj = new boost();
			target1 = new Target();
			target2 = new Target();
			target3 = new Target();
			
			ai.makeAi();
			
			addChild(boostObj);
			addChild(player);
			addChild(ai);
			addChild(target1);
			addChild(target2);
			addChild(target3);
			
			target1.x = this.x + (stage.stageWidth/2 + 50);
			target2.x = this.x + (stage.stageWidth/2);
			target3.x = this.x + (stage.stageWidth/2 - 40);
			
			target1.y = this.y + (stage.stageHeight/2 + 300);
			target2.y = this.y + (stage.stageHeight/2 + 250);
			target3.y = this.y + (stage.stageHeight/2 + 75);
			
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function removedHandler(ev : Event)
		{
			
		}
		
		private function keyDown(ev : KeyboardEvent)
		{
			keyDownArr[ev.keyCode] = true;
		}
		
		private function keyUp(ev : KeyboardEvent)
		{
			keyDownArr[ev.keyCode] = false;
		}
		
		public function getKeyDownArr() : Array
		{
			return keyDownArr;
		}
		
		public function update()
		{
			boostObj.update();
			player.update();
			ai.update();
			target1.update();
			target2.update();
			target3.update();
			if(objArr.length != 0)
			{
				for(var i = 0; i < objArr.length; i++)
				{
					objArr[i].update();
				}
			}
		}
		
		public function getPlayer() : MovieClip
		{
			return player;
		}
		
		public function itemPickup(t : String)
		{
			trace("picked up Item " + t);
			speedBoost();
		}
		
		public function speedBoost()
		{
			player.speedBoost(50);
		}
		
		public function fire(xPos : int, yPos : int, xDir : int, yDir : int)
		{
			
			if(xDir > 0)
			{
				xPos += 100;
			}
			else if(xDir < 0)
			{
				xPos -+ 100;
			}
			
			if(yDir > 0)
			{
				yPos += 100;
			}
			else if(yDir < 0)
			{
				yPos -+ 100;
			}
			
			
			objArr.push(ar = new arrow(xPos, yPos, xDir, yDir));
			this.addChild(objArr[(objArr.length - 1)]);
			trace("added arrow");
		}
		
		public function getObjs() : Array
		{
			return objArr;
		}
		

	}
	
}
