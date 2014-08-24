package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.addons.weapon.FlxWeapon;

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
	public var weapon:FlxWeapon;

	private var direction:PlayerDirection;

	/**
	 * Creates a Player at #x and #y (in pixels).
	 */
	public function new(x:Int, y:Int)
	{
		super(x, y);

		// Make square with (w, h)
		this.makeGraphic(50, 50, FlxColor.HOT_PINK);

		this.maxVelocity.x = this.maxVelocity.y = SPEED_RUN;

		this.weapon = new FlxWeapon("default", this);
		this.weapon.makePixelBullet(BULLET_MAX, 5, 5, FlxColor.GOLDENROD, 25, 0);
		this.weapon.setBulletDirection(FlxWeapon.BULLET_UP, BULLET_SPEED);
		this.weapon.setFireRate(BULLET_FIRE_RATE);

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

		if (FlxG.keys.anyPressed(["SPACE"]))
			this.weapon.fire();

		// This NEEDS to be at the very end
		// of this function.
		// Otherwise the player won't move right.
		//
		// Thanks:
		// http://chipacabra.blogspot.de/2010/12/project-jumper-part-2.html
		super.update();
	}
}

