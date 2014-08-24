package enemy;

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
}

