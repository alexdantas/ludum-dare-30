package;

import flixel.util.FlxSave;

/**
 * Contains data to be used globally on the game.
 * Settings, saves, whatever.
 *
 * It that can be used to store references to objects and
 * other things for quick-access.
 *
 */
class Registry
{
	/**
	 * Container for data to be preserved between executions.
	 *
	 * Usage:
	 *
	 *     // Saving something
	 *     Registry.save.data.YOUR_VARIABLE = "value";
	 *     Registry.save.data.flush
	 *
	 *     // Getting it back
	 *     // (don't forget to check if it's NULL)
	 *     Registry.save.data.YOUR_VARIABLE
	 *
	 */
	public static var save:FlxSave = null;

	/**
	 * Initializes the save data to default variables.
	 */
	public static function initialize():Void
	{
		if (Registry.save != null)
		{
			Registry.save.erase();
			Registry.save = null; // TODO: perhaps destroy in a better way?
		}

		Registry.save = new FlxSave();

		// Initializes save with unique identifier
		// It's only this identifier that allows to retrieve
		// the same data later!
		Registry.save.bind("SaveSlot0");

		// Setting all default variables

		if (Registry.save.data.language == null)
			Registry.save.data.language = "en-US";
	}

	/**
	 * Applies the changes made to the Registry on the disk.
	 *
	 * @note Make sure to do it so settings can be preserved!
	 */
	public static function save():Void
	{
		if (Registry.save == null)
			return;

		Registry.save.flush();
	}
}

