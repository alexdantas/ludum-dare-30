package;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.FlxUIRadioGroup;

class MenuOptionsState extends FlxUIState
{
	public override function create():Void
	{
		_xml_id = "options";

		super.create();
	}

	public override function getEvent(event:String, target:Dynamic, data:Array<Dynamic>, ?params:Array<Dynamic>):Void
	{
		// Which Event just happened?
		switch (event)
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
				var command:String = cast params[0];

				if (command == "back")
					FlxG.switchState(new MenuState());
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
		FlxG.switchState(new MenuOptionsState());
	}
}

