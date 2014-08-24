package enemy;

import flixel.FlxG;
import flixel.util.FlxColor;

/**
 * Enemy that comes down from the top of the screen
 * following a Sine wave pattern.
 */
class Sine extends Enemy
{
	// Tweakable stuff

	private static inline var SPEED_VERTICAL:Int   = 40;
	private static inline var SPEED_HORIZONTAL:Int = 1;
	private static inline var AMPLITUDE:Int        = 100; // how wide it moves

	private var initialX:Float;

	public function new(x:Float, y:Float, state:Bool)
	{
		super(x, y, state);

		// Make square with (w, h)
		this.makeGraphic(20, 20, (state == false ?
		                          FlxColor.BLACK :
		                          FlxColor.WHITE));

		this.drag.x = SPEED_HORIZONTAL;
		this.drag.y = SPEED_VERTICAL;

		this.initialX = x;
	}

	override public function update():Void
	{
		// Forever scroll down
		this.acceleration.y = this.drag.y;

		var seconds:Float = (FlxG.game.ticks/1000);

		var offset:Float = (AMPLITUDE * Math.sin(Math.PI * this.drag.x * seconds));
		this.x = this.initialX + offset;

		super.update();
	}
}

