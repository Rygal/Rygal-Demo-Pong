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


package org.rygal.demos.pong;
import org.rygal.demos.pong.scenes.GameScene;
import org.rygal.Game;

/**
 * The game AI for the enemy's paddle.
 * 
 * @author Robert Böhm
 */
class GameAI {
	
	// Store the scene this AI is attached to so it can obtain game information
	// like the ball's position or to force the enemy's paddle to move:
	private var scene:GameScene;
	
	/**
	 * Creates a new game AI using the given scene.
	 */
	public function new(scene:GameScene) {
		this.scene = scene;
	}
	
	/**
	 * Updates the game AI so it's able to think and act.
	 */
	public function update():Void {
		// Determines the target position using the ball's coordinates:
		var target:Float = scene.ball.y + scene.ball.height / 2;
		
		// However, if the ball is moving away from the enemy's paddle, the
		// paddle will try to get back to the center of the game area so it
		// gets a better initial situation when the ball is moving back.
		if (scene.ball.velocityX < 0)
			target = scene.game.height / 2;
		
		if (scene.paddleRight.y + scene.paddleRight.height / 3 > target) {
			// If the ball is too far beneath the paddle, move down:
			scene.paddleRight.moveUp();
			
		} else if(scene.paddleRight.y + scene.paddleRight.height * 2 / 3 < target) {
			// If the ball is too far above the paddle, move up:
			scene.paddleRight.moveDown();
		}
	}
	
}