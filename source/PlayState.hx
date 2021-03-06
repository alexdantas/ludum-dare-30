package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxTypedGroup;
import enemy.Enemy;
import enemy.EnemyManager;
import firetongue.FireTongue;
import firetongue.Replace;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	// All of these things are populated inside the map.
	// They're created inside object `TiledArea` function `loadObjects()`
	public var player:Player;

	public var enemies:EnemyManager;

	private var shipsDestroyedText:FlxText;
	private var distanceTraveledText:FlxText;

	// // TODO: Make stars on the background
	// private var stars:FlxEmitter;
	// private var star:FlxParticle;

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

		// Reset score!
		Registry.shipsDestroyed   = 0;
		Registry.distanceTraveled = 0;

		this.player = new Player(300, 300);
		add(this.player);
		add(this.player.weapon.bullets);

		this.enemies = new EnemyManager();
		add(this.enemies);

		// // TODO: Make stars on the background
		// this.stars = new FlxEmitter(0, 0, 100);
		// this.stars.setSize(FlxG.width, 1);

		// this.stars.setYSpeed(50, 100);
		// for (i in 0...this.stars.maxSize)
		// {
		// 	this.star = new FlxParticle();
		// 	this.star.makeGraphic(2, 2, FlxColor.WHITE);
		// 	this.stars.add(this.star);
		// }
		// // Parameters: Explode, Lifespan, Emit rate (seconds)
		// this.stars.start(false, 3, 0.01);
		// add(this.stars);

		// Overlay with score information
		this.shipsDestroyedText = new FlxText(10, 5);
		this.shipsDestroyedText.size = 18;
		this.distanceTraveledText = new FlxText(10, 25);
		this.distanceTraveledText.size = 18;

		add(this.shipsDestroyedText);
		add(this.distanceTraveledText);

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
		// Input

		if (FlxG.keys.pressed.ESCAPE)
		{
			// Fade out to the Desktop
			FlxG.camera.fade(
				FlxColor.BLACK, 0.33, false,
				function()
				{
					Main.exitGame();
				}
			);
		}

		if (FlxG.keys.anyJustPressed(["P", "ENTER"]))
			this.openSubState(new PauseState());

		// Arbitrary way to increase score
		if (FlxG.game.ticks % 200 == 0)
			Registry.distanceTraveled += 1;

		// Is the Game Over?
		FlxG.overlap(
			this.player, this.enemies,
			function(left:FlxObject, right:FlxObject):Void
			{
				var player:Player = cast left;
				var enemy:Enemy   = cast right;

				if (player.state != enemy.state)
				{
					player.exists = enemy.exists = false;
					Registry.shipsDestroyed += 1;

					this.openSubState(new GameOverState());
				}
			}
		);

		this.player.weapon.bulletsOverlap(
			this.enemies,
			function(left:FlxObject, right:FlxObject):Void
			{
				var bullet:Bullet = cast left;
				var enemy:Enemy   = cast right;

				if (bullet.state == enemy.state)
				{
					bullet.exists = enemy.exists = false;
					Registry.shipsDestroyed += 1;
				}
			}
		);

		// The text needs to be internationalized, so we
		// use Firetongue to replace variables on the strings
		var tmp:String;

		tmp = Registry.language.get("$INGAME_SHIPS_DESTROYED", "ui");
		this.shipsDestroyedText.text = Replace.flags(
			tmp,
			["<X>"],
			[Std.string(Registry.shipsDestroyed)]
		);

		tmp = Registry.language.get("$INGAME_DISTANCE_TRAVELED", "ui");
		this.distanceTraveledText.text = Replace.flags(
			tmp,
			["<X>"],
			[Std.string(Registry.distanceTraveled)]
		);

		super.update();
	}
}

