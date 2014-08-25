package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;

/**
 * Sub state that shows a Game Over text while
 * the game is playing on the background.
 */
class GameOverState extends FlxSubState
{
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		var gameOverText = new FlxText(200, 200);
		gameOverText.size = 36;
		gameOverText.text = Registry.language.get("$GAME_OVER", "ui");
		add(gameOverText);

		super.create();
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
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

		if (FlxG.keys.anyPressed(["SPACE", "ENTER"]))
		{
			// Restart game!
			FlxG.camera.fade(
				FlxColor.BLACK, 0.33, false,
				function()
				{
					FlxG.switchState(new PlayState());
				}
			);
		}

		super.update();
	}
}

