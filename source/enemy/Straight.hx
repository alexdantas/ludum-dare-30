package enemy;

import flixel.util.FlxColor;

/**
 * Enemy that simply comes straight down from the
 * top of the screen.
 */
class Straight extends Enemy
{
	// Tweakable stuff

	private static inline var SPEED_RUN:Int = 80;

	public function new(x:Float, y:Float, state:Bool)
	{
		super(x, y, state);

		// Make square with (w, h)
		if (state == false)
			this.loadGraphic("assets/images/enemy_small_black.png");
		else
			this.loadGraphic("assets/images/enemy_small_white.png");

		this.angle = 180;

		this.maxVelocity.x = this.maxVelocity.y = SPEED_RUN;

		this.drag.x = this.drag.y = this.maxVelocity.x * 8;
	}

	override public function update():Void
	{
		this.acceleration.x = 0;
		this.acceleration.y = 0;

		// Going down
		this.acceleration.y = this.drag.y;

		super.update();
	}
}

