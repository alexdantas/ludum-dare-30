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
import firetongue.FireTongue;
import flash.system.System; // System.exit()

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
		// Setting up the language - a Firetongue
		// instance on the `Main` class
		if (Main.tongue == null)
		{
			Main.tongue = new FireTongueEx();
			Main.tongue.init(Registry.save.data.language);

			// All FlxUIStates will use this tongue
			FlxUIState.static_tongue = Main.tongue;
		}

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
				if (Main.tongue != null)
					radio.selectedId = Main.tongue.locale.toLowerCase();
			}

		case "click_button":
			if (params != null && params.length > 0)
			{
				// Which button was pressed?
				switch (cast(params[0], String))
				{
				case "start":
					FlxG.camera.fade(FlxColor.BLACK, .33, false, function()
					                 {
						                 FlxG.switchState(new PlayState());
					                 });

				case "quit":
					// I don't know if this is safe at all,
					// but at least its something.
					System.exit(0);
				}
			}

		// When selecting the language, immediately
		// change it and reload the state
		case "click_radio_group":
			var id:String = cast data;

			if (Main.tongue != null)
			{
				Main.tongue.init(id, reloadState); // callback

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

