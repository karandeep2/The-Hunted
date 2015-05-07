/*
 * This has purpose of recording the relvant keypresses
 * so it can send the request to multiplayer manager using a 
 * method called "move" which takes in a string.
 */
package { 
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.EventDispatcher;
	
	public class gameController extends EventDispatcher{
		 
		private var manager:multiplayerManager;
		private var keysArray:Array = [];
		
		public function gameController(m:multiplayerManager) 
		{
			this.manager = m;
		}

		/*
		 * Has a purpose of sending the movmement request to the multipler manager
		 */
		public function update():void
		{
			//Switch statements are as inefficent in AS
			//So I decided to use poor pratice of "if's
			
			/*I have imrpoved this by seperating verticle
			and horizontal movements, before it was not
			possible to move diagonally
			*/
			if(keysArray[Keyboard.LEFT])
			{
				manager.move(1);
			}
			else if(keysArray[Keyboard.RIGHT])
			{
				manager.move(3);
			}
			
			if(keysArray[Keyboard.DOWN])
			{
				manager.move(2);
			}
			else if(keysArray[Keyboard.UP])
			{
				manager.move(4);
			}
		}
		
		public function event(e:KeyboardEvent) : void
		{
			if(e.type == "keyDown")
			{
				keysArray[e.keyCode] = true;
			}
			else if(e.type == "keyUp")
			{
				keysArray[e.keyCode] = false;
			}
		}
	}
}
	