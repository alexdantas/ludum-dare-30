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

	private static inline var BULLET_MAX:Int       = 50;  // Max amount at once
	private static inline var BULLET_SPEED:Int     = 400; // Pixels per second
	private static inline var BULLET_FIRE_RATE:Int = 100; // Delay in milliseconds

	// Variables

	/**
	 * Container for all Bullets and logic for shooting them.
	 * (also known as "Bullet Manager")
	 *
	 * It handles by itself all the details on firing bullets
	 * (fire rate, making them disappear when out of bounds, etc)
	 *
	 * @note Make sure to add `weapon.group` group to the State!
	 */
	public var weapon:Weapon;

	private var direction:PlayerDirection;

	public var state:Bool;

	private var blackSprite:FlxSprite;
	private var whiteSprite:FlxSprite;


	/**
	 * Creates a Player at #x and #y (in pixels).
	 */
	public function new(x:Int, y:Int)
	{
		super(x, y);

		this.blackSprite = new FlxSprite(0, 0, "assets/images/player_black.png");
		this.whiteSprite = new FlxSprite(0, 0, "assets/images/player_white.png");

		this.loadGraphicFromSprite(this.whiteSprite);

		this.maxVelocity.x = this.maxVelocity.y = SPEED_RUN;

		this.weapon = new Weapon(this, BULLET_SPEED, BULLET_MAX);
		this.weapon.fireRate = BULLET_FIRE_RATE;
		this.weapon.offset.x = this.width/2;

		// How quickly you slow down when
		// not pressing anything
		this.drag.x = this.maxVelocity.x * 8;
		this.drag.y = this.maxVelocity.y * 8;

		this.direction = PlayerDirection.UP;
		this.state = true;
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

		if (FlxG.keys.anyPressed(["SPACE"]))
			this.weapon.fire(this.state);


		if (FlxG.keys.anyJustPressed(["Q"]))
			this.toggleState();

		// This NEEDS to be at the very end
		// of this function.
		// Otherwise the player won't move right.
		//
		// Thanks:
		// http://chipacabra.blogspot.de/2010/12/project-jumper-part-2.html
		super.update();
	}

	public function toggleState():Void
	{
		if (this.state == true)
		{
			this.state = false;
			this.loadGraphicFromSprite(this.blackSprite);
		}
		else
		{
			this.state = true;
			this.loadGraphicFromSprite(this.whiteSprite);
		}
	}
}

