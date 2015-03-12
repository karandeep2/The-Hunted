package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class mainController extends MovieClip 
	{
		private var currentScreen : MovieClip;
		private var game : GameScreen;
		
		
		public function mainController() 
		{
			trace("created mainController");
			addEventListener(Event.ENTER_FRAME, update);
			//goToLevelStartScreen();
			goToLevelGameScreen();
		}
		
		public function update(ev : Event)
		{
			currentScreen.update();
		}
		
		public function goToLevelGameScreen()
		{
			trace("starting game");
			game = new GameScreen();
			currentScreen = game;
			this.addChild(game);
		}
	}
	
}
