package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxRect;
import flixel.group.FlxTypedGroup;

class Weapon
{
	/**
	 * The FlxGroup into which all the bullets for this weapon are
	 * drawn.
	 *
	 * This should be added to your display and collision checked
	 * against it.
	 */
	public var bullets:FlxTypedGroup<Bullet>;

	// Internal variables, use with caution

	/**
	 * The delay in milliseconds (ms) between which each bullet is
	 * fired, set to zero to clear.
	 */
	public var fireRate:Int;

	private var lastFired:Int;
	private var nextFire:Int;

	/**
	 * When a bullet goes outside of this bounds it will be
	 * automatically killed, freeing it up for firing again.
	 *
	 * TODO - Needs testing with a scrolling map (when not using
	 * single screen display)
	 */
	public var bounds:FlxRect;

	/**
	 * Position to offset the bullet when shooting a
	 * bullet.
	 */
	public var offset:FlxPoint;

	/**
	 * The Weapon will fire from the parents x/y value, as seen in
	 * Space Invaders and most shoot-em-ups.
	 */
	public var parent:FlxObject;

	/**
	 * A reference to the Bullet that was last fired
	 */
	public var currentBullet:Bullet;


	// // Sounds
	// public var onPreFireSound:FlxSound;
	// public var onPostFireSound:FlxSound;

	private var bulletSpeed:Int;

	/**
	 * Creates a new Weapon, dude!
	 */
	public function new(parent:FlxObject, bulletSpeed:Int, maxBullets:Int)
	{
		this.fireRate  = 0;
		this.lastFired = 0;
		this.nextFire  = 0;

		this.parent = parent;

		this.bulletSpeed = bulletSpeed;

		this.bullets = new FlxTypedGroup<Bullet>(maxBullets);
		for (i in 0...maxBullets)
			this.bullets.add(new Bullet());

		this.bounds = FlxRect.get(0, 0, FlxG.width, FlxG.height);
		this.offset = new FlxPoint(0, 0);
	}

	/**
	 * Actually fire a bullet.
	 *
	 * @return True if a bullet was fired or false if one wasn't
	 *         available.
	 *         Bullet is stored on FlxWeapon.currentBullet.
	 */
	public function fire(state:Bool):Bool
	{
		if (this.fireRate > 0 && FlxG.game.ticks < nextFire)
			return false;

		// #if !FLX_NO_SOUND_SYSTEM
		// if (onPreFireSound != null)
		// {
		// 	onPreFireSound.play();
		// }
		// #end

		this.lastFired = FlxG.game.ticks;
		this.nextFire  = FlxG.game.ticks + Std.int(fireRate / FlxG.timeScale);

		// Get a free bullet from the pool
		this.currentBullet = this.bullets.getFirstAvailable();
		if (this.currentBullet == null)
			return false;

		this.currentBullet.bounds = bounds;
		this.currentBullet.fire(this.parent.x + this.offset.x,
		                        this.parent.y + this.offset.y,
		                        this.bulletSpeed,
		                        state);

		// #if !FLX_NO_SOUND_SYSTEM
		// if (onPostFireSound != null)
		// {
		// 	onPostFireSound.play();
		// }
		// #end

		return true;
	}

	/**
	 * Checks to see if the bullets are overlapping the specified object or group
	 *
	 * @param  objectOrGroup  	The group or object to check
	 *                          if bullets collide
	 * @param  notifyCallBack   A function that will get called
	 *                          if a bullet overlaps an object
	 * @param  skipParent    	Don't trigger colision notifies
	 *                          with the parent of this object
	*/
	public inline function bulletsOverlap(objectOrGroup:FlxBasic, ?notifyCallBack:FlxObject->FlxObject->Void, skipParent:Bool = true):Void
	{
		if (this.bullets == null || this.bullets.length == 0)
			return;

		FlxG.overlap(objectOrGroup, this.bullets, notifyCallBack);
	}
}

