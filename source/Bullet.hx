package;

import flixel.FlxSprite;
import flixel.util.FlxColor;


class Bullet extends FlxSprite
{
	private static inline var SPEED_BULLET = 400;

	public function new():Void
	{
		super(0, 0);

		this.makeGraphic(5, 5, FlxColor.YELLOW);

		// Make it ready for
		// pool allocation straight away
		this.exists = false;
	}
	public function fire(x:Float, y:Float):Void
	{
		this.x = x;
		this.y = y;

		this.velocity.y = -SPEED_BULLET;

		this.exists = true;
	}
}

