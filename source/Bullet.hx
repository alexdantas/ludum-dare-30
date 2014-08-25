package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxRect;
import flixel.util.FlxMath;

class Bullet extends FlxSprite
{
	public var state:Bool;

	/**
	 * If the bullet gets outside of this rectangle,
	 * it gets destroyed.
	 */
	public var bounds:FlxRect;

	public function new():Void
	{
		super(0, 0);

		this.bounds = null;
		this.state  = false;

		// Make it ready for
		// pool allocation straight away
		this.exists = false;
	}

	public function fire(x:Float, y:Float, speed:Int, state:Bool)
	{
		this.x = x;
		this.y = y;

		this.state = state;
		this.makeGraphic(
			5, 5,
			(this.state == false ?
			 FlxColor.BLACK :
			 FlxColor.WHITE)
		);

		// Constantly moving up
		this.velocity.y = -speed;

		// Ready for collision checks!
		this.exists = true;
	}

	override public function update():Void
	{
		if (this.bounds != null)
		{
			if (! FlxMath.pointInFlxRect(Math.floor(x), Math.floor(y), this.bounds))
				this.exists = false;
		}

		super.update();
	}
}

