package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.addons.ui.interfaces.IFlxUIWidget;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxUIState
{
	// Where to save stuff
	private var gameSave:FlxSave;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		// Which XML file to use when building UI
		// (must be inside "assets/xml")
		_xml_id = "main_menu";

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
		super.update();
	}


	// Handles events on the UI
	override public function getEvent(name:String, sender:IFlxUIWidget, data:Dynamic, ?params:Array<Dynamic>):Void
	{
		// Which Event just happened?
		switch (name)
		{
		// Right after we load, let's fill the
		// Language Radio with the current language
		case "finish_load":
			var radio:FlxUIRadioGroup = cast _ui.getAsset("locale_radio");
			if (radio != null)
			{
				if (Registry.language != null)
					radio.selectedId = Registry.language.locale.toLowerCase();
			}

		case "click_button":
			if (params != null && params.length > 0)
			{
				// Which button was pressed?
				switch (cast(params[0], String))
				{
				case "start":
					// Fade out to the next state!
					FlxG.camera.fade(
						FlxColor.BLACK, 0.33, false,
						function()
						{
							FlxG.switchState(new PlayState());
						}
					);
				case "quit":
					// Fade out to the Desktop
					FlxG.camera.fade(
						FlxColor.BLACK, 0.33, false,
						function()
						{
							Main.exitGame();
						}
					);
				}
			}

		// When selecting the language, immediately
		// change it and reload the state
		case "click_radio_group":
			var id:String = cast data;

			if (Registry.language != null)
			{
				// Restart with other language,
				// calling function when done
				Registry.language.init(id, reloadState);

				Registry.save.data.language = id;
				Registry.apply();
			}
		}
	}

	private function reloadState():Void
	{
		FlxG.switchState(new MenuState());
	}
}

