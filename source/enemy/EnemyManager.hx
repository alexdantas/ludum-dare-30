package enemy;

import flixel.FlxG;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxRandom;

class EnemyManager extends FlxTypedGroup<Enemy>
{
	override public function update()
	{
		// Randomly add a Random type of enemy within a Random portion of the screen...
		// Wow!
		if (FlxRandom.chanceRoll(5)) // 50% chance of adding an Enemy
		{
			var x:Int = FlxRandom.intRanged(0, FlxG.width);
			var y:Int = -25;

			var state:Bool = FlxRandom.chanceRoll(50);

			var whichEnemy:Int = FlxRandom.weightedPick([70, 30]);

			if (whichEnemy == 0)
				this.add(new Straight(x, y, state));
			else
				this.add(new Sine(x, y, state));
		}

		super.update();
	}
}

