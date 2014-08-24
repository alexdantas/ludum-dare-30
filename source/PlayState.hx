package;

import flixel.FlxG;
import openfl.Assets;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxTypedGroup;

import enemy.Enemy;
import enemy.Straight;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	// All of these things are populated inside the map.
	// They're created inside object `TiledArea` function `loadObjects()`
	public var player:Player;

	public var enemies:FlxTypedGroup<Enemy>;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		FlxG.cameras.bgColor = FlxColor.GRAY;

		// Nice Fade-In
		FlxG.camera.fade(FlxColor.BLACK, 0.33, true);

		// Misc. game settings
		FlxG.mouse.visible = false;

		this.player = new Player(300, 300);
		add(this.player);
		add(this.player.weapon.group);

		this.enemies = new FlxTypedGroup<Enemy>();
		this.enemies.add(new Straight(50, 50, false));
		this.enemies.add(new Straight(100, 100, true));
		this.enemies.add(new Straight(150, 10, false));
		this.enemies.add(new Straight(200, 200, true));
		add(this.enemies);

		super.create();
	}

	/**
	 * Function that is called when this state is destroyed.
	 *
	 * You might want to consider setting all objects this state uses
	 * to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		FlxG.overlap(
			this.player.weapon.group, this.enemies,
			function(left:FlxObject, right:FlxObject):Void
			{
				var bullet:Player = cast left;
				var enemy:Enemy   = cast right;

				if (bullet.state == enemy.state)
				{
					bullet.exists = enemy.exists = false;
				}
			}
		);

		super.update();
	}
}

