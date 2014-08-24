package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;

// Nice logging feature
// Include this:
//import haxe.Log;
//
// And then call with any object:
//Log.trace("test");

enum PlayerDirection
{
	RIGHT;
	LEFT;
	UP;
	DOWN;
}

class Player extends FlxSprite
{
	// Tweakable stuff
	private static inline var SPEED_RUN:Int       = 160;

	// Variables
	private var direction:PlayerDirection;

	// Functions

	/**
	 * Creates a Player at #x and #y (in pixels).
	 */
	public function new(x:Int, y:Int)
	{
		super(x, y);

		// Make square with (w, h)
		this.makeGraphic(50, 50, FlxColor.HOT_PINK);

		this.maxVelocity.x = this.maxVelocity.y = SPEED_RUN;

		// How quickly you slow down when
		// not pressing anything
		this.drag.x = this.maxVelocity.x * 8;
		this.drag.y = this.maxVelocity.y * 8;

		this.direction = PlayerDirection.UP;
	}

	override public function update():Void
	{
		this.acceleration.x = 0;
		this.acceleration.y = 0;

		if (FlxG.keys.anyPressed(["LEFT", "A"]))
		{
			this.acceleration.x = -this.drag.x;
			this.direction = PlayerDirection.LEFT;
		}
		else if (FlxG.keys.anyPressed(["RIGHT", "D"]))
		{
			this.acceleration.x = this.drag.x;
			this.direction = PlayerDirection.RIGHT;
		}

		if (FlxG.keys.anyPressed(["UP", "W"]))
		{
			this.acceleration.y = -this.drag.y;
			this.direction = PlayerDirection.UP;
		}
		else if (FlxG.keys.anyPressed(["DOWN", "S"]))
		{
			this.acceleration.y = this.drag.y;
			this.direction = PlayerDirection.DOWN;
		}

		// This NEEDS to be at the very end
		// of this function.
		// Otherwise the player won't move right.
		//
		// Thanks:
		// http://chipacabra.blogspot.de/2010/12/project-jumper-part-2.html
		super.update();
	}
}

