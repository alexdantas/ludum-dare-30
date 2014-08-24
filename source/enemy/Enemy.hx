package enemy;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;

class Enemy extends FlxSprite
{
	// Tweakable stuff
	private static inline var SPEED_RUN:Int = 80;

	public var state:Bool;

	public function new(x:Float, y:Float, state:Bool)
	{
		super(x, y);

		this.state = state;

		// Make square with (w, h)
		this.makeGraphic(20, 20, (state == false ?
		                          FlxColor.BLACK :
		                          FlxColor.WHITE));

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

