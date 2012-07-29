// Copyright (C) 2012 Robert Böhm
// This file is part of RygalDemoPong.
// 
// RygalDemoPong is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// RygalDemoPong is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with RygalDemoPong.  If not, see <http://www.gnu.org/licenses/>.


package org.rygal.demos.pong.entities;
import org.rygal.demos.pong.Assets;
import org.rygal.GameTime;
import org.rygal.graphic.Sprite;
import org.rygal.graphic.Texture;

/**
 * A ball that moves with a specific velocity and is able to bounce off other
 * objects.
 * 
 * @author Robert Böhm
 */
class Ball extends Sprite {
	
	// Determines the maximum speed, the speed won't increase as soon as this
	// limit is reached:
	static public inline var MAX_SPEED:Float = 850;
	
	// The acceleration of this ball in pixels per second:
	static public inline var ACCELERATION:Float = 25;
	
	// The initial speed after each reset:
	static public inline var INITIAL_SPEED:Float = 100;
	
	
	// The start coordinates of the ball:
	private var startX:Float;
	private var startY:Float;
	
	// Determines if the ball goes to the left side after the next reset:
	public var nextBallGoLeft:Bool;
	
	// Velocity variables, used to determine the direction:
	public var velocityX:Float;
	public var velocityY:Float;
	
	// The speed of this ball in pixels per second:
	public var speed:Float;
	
	
	/**
	 * Creates a new ball with the given start coordinates.
	 */
	public function new(startX:Float, startY:Float) {
		// Initialize this sprite with the ball texture:
		super(Texture.fromAssets(Assets.ASSET_BALL));
		
		// Setup the start coordinates and also correct them to determine the
		// middle of the ball rather than the top left corner:
		this.startX = startX - this.width / 2;
		this.startY = startY - this.height / 2;
		
		// Determine if the ball goes to the left at the beginning:
		this.nextBallGoLeft = Math.random() < 0.5;
		
		// Resets this ball, thus also initializing stuff like the ball
		// direction:
		this.reset();
	}
	
	/**
	 * Resets this ball for a new round. It places the ball at the start
	 * coordinates and also resets the speed to the initial one.
	 */
	public function reset():Void {
		
		// Reset the speed:
		this.speed = INITIAL_SPEED;
		
		// Determine the initial direction, limited from -45 to +45 degrees:
		// (Math.PI / 4 == 45°)
		var initialDirection:Float = Math.random() * Math.PI / 2 - Math.PI / 4;
		// This is done by first of all determining a value in the range from
		// 0° to 90° and later on subtracting 45°, resulting in a random value
		// between -45° and +45°.
		
		
		if (this.nextBallGoLeft) {
			// If the ball goes to the left, add 180°: (Thus swapping direction)
			initialDirection += Math.PI;
			
			// Also, if the ball went to the left this time, it shall go to the
			// right next time:
			this.nextBallGoLeft = false;
			
		} else {
			// Else let the ball go to the left next time:
			this.nextBallGoLeft = true;
		}
		
		// Now get the X and Y offset from that direction:
		this.velocityX = Math.cos(initialDirection);
		this.velocityY = Math.sin(initialDirection);
		
		// Reset the ball's coordinates:
		this.x = this.startX;
		this.y = this.startY;
	}
	
	/**
	 * Forces this ball to go to the left: (Thus bouncing off the right)
	 */
	public function turnLeft():Void {
		// If the ball already goes to the left, don't do anything, else swap
		// direction:
		this.velocityX = this.velocityX > 0 ? -this.velocityX : this.velocityX;
	}
	
	/**
	 * Forces this ball to go to the right: (Thus bouncing off the left)
	 */
	public function turnRight():Void {
		// If the ball already goes to the right, don't do anything, else swap
		// direction:
		this.velocityX = this.velocityX < 0 ? -this.velocityX : this.velocityX;
	}
	
	/**
	 * Forces this ball to go to the top: (Thus bouncing off the bottom)
	 */
	public function turnUp():Void {
		// If the ball already goes to the top, don't do anything, else swap
		// direction:
		this.velocityY = this.velocityY > 0 ? -this.velocityY : this.velocityY;
	}
	
	/**
	 * Forces this ball to go to the bottom: (Thus bouncing off the top)
	 */
	public function turnDown():Void {
		// If the ball already goes to the bottom, don't do anything, else swap
		// direction:
		this.velocityY = this.velocityY < 0 ? -this.velocityY : this.velocityY;
	}
	
	/**
	 * Updates ball movement.
	 */
	override public function update(time:GameTime):Void {
		super.update(time);
		
		// Increases the speed using the acceleration and the time elapsed
		// since the last update()-call:
		this.speed += ACCELERATION * time.elapsedS;
		
		// Limit the speed on MAX_SPEED:
		if (this.speed > MAX_SPEED) {
			this.speed = MAX_SPEED;
		}
		
		// Move the ball using the velocities and speed values calculated
		// earlier, also integrate the elapsed time since the last update to
		// make ball movement frame-independent:
		this.x += this.velocityX * this.speed * time.elapsedS;
		this.y += this.velocityY * this.speed * time.elapsedS;
	}
	
}