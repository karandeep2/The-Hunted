package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.globalization.LastOperationStatus;
	import flash.events.KeyboardEvent;
	
	public class Main extends MovieClip 
	{
		
		private var currentScreen:Screen;
		private var menu:menuScreen;
		private var settings:settingsScreen;
		private var multiplayer:multiplayerManager;
		private var singlePlayer:gameInstance;
		
		
		public function Main() 
		{
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			multiplayer = new multiplayerManager();
			currentScreen = multiplayer;
			addChild(currentScreen);
		}
		
		private function update(e : Event) : void
		{
			currentScreen.update();
		}
		
		private function keyDown(e : KeyboardEvent) : void
		{
			if(currentScreen == multiplayer)				
			{
				multiplayer.event(e);
			}
		}
		
		private function keyUp(e : KeyboardEvent) : void
		{
			if(currentScreen == multiplayer)
			{
				multiplayer.event(e);
			}
		}
	}
	
}
