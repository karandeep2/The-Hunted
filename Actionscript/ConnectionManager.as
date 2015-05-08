package  {
	import flash.system.fscommand;
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.PublicMessageRequest; 
	import flash.events.Event;
	
	public class ConnectionManager 
	{

		private var sfs : SmartFox;
		private var userName : String;
		private var roomName : String;
		private var p = null;
		
		public function ConnectionManager(par: multiplayerManager) 
		{
				
			p = par;
			
			sfs = new SmartFox();
			
			addEventListeners();
		}
		
		public function connect(user : String, room : String) : void
		{
			userName = user;
			roomName = room;
			trace("attempting to connect");
			sfs.loadConfig("sfs-config.xml");
		}
		
		public function broadcast(m : String) : void
		{
			sfs.send( new PublicMessageRequest(m));
		}
		
		private function onConnection(e:SFSEvent) : void
		{
			if(e.params.success)
			{
				trace("connection sucessful");
				sfs.send( new LoginRequest(userName.toString()));
				//sfs.send( new LoginRequest(Math.random().toString()));
			}
		}
		
		private function onConnectionLost(e:SFSEvent) : void
		{
			trace("connection lost");
		}
		
		private function onConfigLoadSuccess(e:SFSEvent) : void
		{
			trace("file loaded");
		}
		
		private function onConfigLoadFailure(e:SFSEvent) : void
		{
			trace("file failed to load");
			trace(e.toString());
			fscommand("quit");
			
		}
		
		private function onLogin(e:SFSEvent) : void
		{
			trace("login successful: " + e.params.user.name);
			sfs.send( new JoinRoomRequest("The Lobby"));
		}
		
		private function onLoginError(e:SFSEvent) : void
		{
			trace("login failed: " + e.params.errorMessage);
		}
		
		private function onRoomJoin(e:SFSEvent) : void
		{
			broadcast("!addPlayer 0 0 " + userName + " " + p.getShipNum());
			trace("joined room: " + e.params.room.name);
		}
		
		private function onRoomJoinError(e:SFSEvent) : void
		{
			trace("failed to join room: " + e.params.errorMessage);
		}
		
		private function onUserEnterRoom(e:SFSEvent) : void
		{
			trace("User entered room: " + e.params.user.name);
		}
		
		private function onUserExitRoom(e:SFSEvent) : void
		{
			trace("User left room: " + e.params.user.name);
		}
		
		private function onPublicMessage(e:SFSEvent) : void
		{
			trace(e.params.sender + ": " + e.params.message);
			p.message(e.params.message);
		}
		
		private function addEventListeners() : void
		{
				
			sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
			sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
			sfs.addEventListener(SFSEvent.LOGIN, onLogin);
			sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			sfs.addEventListener(SFSEvent.ROOM_JOIN, onRoomJoin);
			sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onRoomJoinError);
			sfs.addEventListener(SFSEvent.USER_ENTER_ROOM, onUserEnterRoom);
			sfs.addEventListener(SFSEvent.USER_EXIT_ROOM, onUserExitRoom);
			sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
		}

	}
	
}
	