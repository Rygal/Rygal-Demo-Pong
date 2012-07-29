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
 * A ball that can be controlled by either the player or the AI.
 * 
 * @author Robert Böhm
 */
class Paddle extends Sprite {
	
	// The speed of this paddle in pixel per second:
	static public inline var SPEED:Float = 150;
	
	// The start position:
	private var startY:Float;
	
	// The current movement of this paddle: (Negative values move the paddle
	// up, positive ones move the paddle down)
	private var velocityY:Float;
	
	
	/**
	 * Creates a new paddle using the given start coordinates.
	 */
	public function new(startX:Float, startY:Float) {
		super(Texture.fromAssets(Assets.ASSET_PADDLE));
		
		// Initialize the coordinates of this paddle:
		this.x = startX - this.width / 2;
		this.startY = startY - this.height / 2;
		
		// Reset this paddle to initialize the y-coordinate as well as the
		// velocity:
		this.reset();
	}
	
	public function reset():Void {
		// Reset the position of this paddle:
		this.y = this.startY;
		
		// Also reset the movement of this paddle:
		this.velocityY = 0;
	}
	
	/**
	 * Forces this paddle to move up:
	 */
	public function moveUp():Void {
		this.velocityY--;
	}
	
	/**
	 * Forces this paddle to move down:
	 */
	public function moveDown():Void {
		this.velocityY++;
	}
	
	/**
	 * Update paddle movement:
	 */
	override public function update(time:GameTime):Void {
		super.update(time);
		
		// Move the paddle using the velocity, speed and the time elapsed
		// since the last update()-call:
		this.y += this.velocityY * SPEED * time.elapsedS;
		this.velocityY = 0;
	}
	
}