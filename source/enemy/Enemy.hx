package enemy;

import flixel.FlxG;
import flixel.FlxSprite;

class Enemy extends FlxSprite
{
	// Variables

	public var state:Bool;

	// Functions

	public function new(x:Float, y:Float, state:Bool)
	{
		super(x, y);

		this.state = state;
	}
	override public function update():Void
	{
		if (this.y > FlxG.height)
			this.exists = false;

		super.update();
	}
}

