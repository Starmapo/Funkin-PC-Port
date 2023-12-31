package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.media.Video;
import openfl.net.NetStream;

class Main extends Sprite
{
	public static var instance:Main;

	var gameWidth:Int = 1280; // Width of the game in pixels.
	var gameHeight:Int = 720; // Height of the game in pixels.
	var initialState:Class<FlxState> = TitleState; // The FlxState the game starts with.
	#if web
	var framerate:Int = 60; // How many frames per second the game should run at.
	#else
	var framerate:Int = 144; // How many frames per second the game should run at.

	#end
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();
		instance = this;

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	var video:Video;
	var netStream:NetStream;
	private var overlay:Sprite;

	public static var fpsCounter:FPS;

	private function setupGame():Void
	{
		#if !debug
		initialState = TitleState;
		#end

		addChild(new FlxGame(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen));

		#if !mobile
		fpsCounter = new FPS(10, 3, 0xFFFFFF);
		addChild(fpsCounter);
		#end
		/* 
			video = new Video();
			addChild(video);

			var netConnection = new NetConnection();
			netConnection.connect(null);

			netStream = new NetStream(netConnection);
			netStream.client = {onMetaData: client_onMetaData};
			netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, netStream_onAsyncError);

			#if (js && html5)
			overlay = new Sprite();
			overlay.graphics.beginFill(0, 0.5);
			overlay.graphics.drawRect(0, 0, 560, 320);
			overlay.addEventListener(MouseEvent.MOUSE_DOWN, overlay_onMouseDown);
			overlay.buttonMode = true;
			addChild(overlay);

			netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnection_onNetStatus);
			#else
			netStream.play("assets/preload/music/dredd.mp4");
			#end 
		 */
	}
	/* 
		private function client_onMetaData(metaData:Dynamic)
		{
			video.attachNetStream(netStream);

			video.width = video.videoWidth;
			video.height = video.videoHeight;
		}

		private function netStream_onAsyncError(event:AsyncErrorEvent):Void
		{
			trace("Error loading video");
		}

		private function netConnection_onNetStatus(event:NetStatusEvent):Void
		{
		}

		private function overlay_onMouseDown(event:MouseEvent):Void
		{
			netStream.play("assets/preload/music/dredd.mp4");
		}
	 */
}
