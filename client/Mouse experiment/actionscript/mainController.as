package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class mainController extends MovieClip 
	{
		private var currentScreen : MovieClip;
		private var game : gameScreen;
		private var keyDownArr = new Array;
		
		
		public function mainController() 
		{
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyBoardUpdate);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyBoardUpdate);
			goToLevelGameScreen();
		}
		
		public function update(ev : Event)
		{
			currentScreen.update();
		}
		
		public function keyBoardUpdate(ev : KeyboardEvent)
		{
			if(ev.type == ("keyDown"))
			{
				keyDownArr[ev.keyCode] = true;
			}
			else if(ev.type == ("keyUp"))
			{
				keyDownArr[ev.keyCode] = false;
			}
		}
		
		public function getKeyDownArr() : Array
		{
			return keyDownArr;
		}
		
		public function goToLevelGameScreen()
		{
			game = new gameScreen();
			currentScreen = game;
			this.addChild(game);
		}
	}
	
}
