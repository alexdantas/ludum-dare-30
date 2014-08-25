package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;

class Main extends Sprite
{
	// Width/height of the game in pixels
	// (might be less / more in actual
	//  pixels depending on your zoom).
	var gameWidth:Int  = 640;
	var gameHeight:Int = 480;

	// If -1, zoom is automatically calculated to fit the window
	// dimensions.
	var zoom:Float = -1;

	// How many frames per second the game should run at.
	var framerate:Int = 60;

	// Whether to skip the flixel splash screen that appears in
	// release mode.
	var skipSplash:Bool = true;

	// Whether to start the game in fullscreen on desktop targets
	var startFullscreen:Bool = false;

	// First state that the game starts with.
#if debug
	var initialState:Class<FlxState> = PlayState;
#else
	var initialState:Class<FlxState> = MenuState;
#end

	// You can pretty much ignore everything from here on - your code
	// should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

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

	private function setupGame():Void
	{
		var stageWidth:Int  = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;

			zoom = Math.min(ratioX, ratioY);

			gameWidth  = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		// Initializing and loading all game settings
		// (including the language)
		Registry.initialize();

		addChild(
			new FlxGame(
				gameWidth, gameHeight,
				initialState,
				zoom,
				framerate, framerate,
				skipSplash,
				startFullscreen
			)
		);
	}
}

