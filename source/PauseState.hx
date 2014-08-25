package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.addons.ui.interfaces.IFlxUIWidget;

/**
 * Sub state that shows a Game Over text while
 * the game is playing on the background.
 */
class PauseState extends FlxSubState
{
	private var pausedText:FlxText;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		this.pausedText = new FlxText(200, 200);
		this.pausedText.size = 36;
		this.pausedText.text = Registry.language.get("$PAUSED", "ui");
		add(this.pausedText);

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

		if (FlxG.keys.anyJustPressed(["SPACE", "ENTER"]))
			this.close();

		super.update();
	}
}

