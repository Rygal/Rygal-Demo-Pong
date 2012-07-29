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


package org.rygal.demos.pong.scenes;

import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import org.rygal.audio.Sound;
import org.rygal.demos.pong.entities.Ball;
import org.rygal.demos.pong.entities.Paddle;
import org.rygal.demos.pong.GameAI;
import org.rygal.Game;
import org.rygal.GameTime;
import org.rygal.graphic.Canvas;
import org.rygal.graphic.Font;
import org.rygal.input.KeyboardEvent;
import org.rygal.input.Keys;
import org.rygal.Scene;
import org.rygal.util.Storage;

/**
 * The scene representing the game. It manages the initialization of every
 * entity as well as controlling the game logic.
 * 
 * @author Robert Böhm
 */
class GameScene extends Scene {
	
	// Determines the distance between the score displays:
	static public inline var SCORE_PADDING:Float = 16;
	
	// Sound effects:
	private var ping:Sound;
	private var pong:Sound;
	private var lose:Sound;
	private var win:Sound;
	
	// The font used to display the score:
	private var scoreFont:Font;
	
	// Game entities:
	public var ball:Ball;
	public var paddleLeft:Paddle;
	public var paddleRight:Paddle;
	
	// The game AI:
	public var ai:GameAI;
	
	// Game statistics:
	public var scoreLeft:Int;
	public var scoreRight:Int;
	
	
	/**
	 * Empty constructor.
	 */
	public function new() {
		super();
	}
	
	/**
	 * Will be called once the scene gets active.
	 */
	override public function load(game:Game):Void {
		super.load(game);
		
		// Initialize some variables:
		scoreLeft = 0;
		scoreRight = 0;
		ai = new GameAI(this);
		
		// Load resources:
		scoreFont = Font.fromAssets(Assets.ASSET_SCOREFONT);
		ping = Sound.fromAssets(Assets.ASSET_PING);
		pong = Sound.fromAssets(Assets.ASSET_PONG);
		lose = Sound.fromAssets(Assets.ASSET_LOSE);
		win = Sound.fromAssets(Assets.ASSET_WIN);
		
		// Initialize entities and add them to the scene:
		this.addChild(ball = new Ball(game.width / 2, game.height / 2));
		this.addChild(paddleLeft = new Paddle(16, game.height / 2));
		this.addChild(paddleRight = new Paddle(game.width - 16, game.height / 2));
	}
	
	/**
	 * Controls player input, game AI and ball movement, as well as collision
	 * detection.
	 */
	override public function update(time:GameTime):Void {
		
		// Handle player input:
		if (game.keyboard.isKeyPressed(Keys.W) ||
			game.keyboard.isKeyPressed(Keys.UP)) {
			
			paddleLeft.moveUp();
		}
		
		if (game.keyboard.isKeyPressed(Keys.S) ||
			game.keyboard.isKeyPressed(Keys.DOWN)) {
			
			paddleLeft.moveDown();
		}
		
		// Update game AI:
		ai.update();
		
		// Check for ball <-> wall collisions:
		if (ball.y <= 0) ball.turnDown();
		if (ball.y + ball.height >= game.height) ball.turnUp();
		if (ball.x + ball.width < 0) {
			ball.reset();
			scoreRight++;
			lose.play();	// Play the lose-sound
		}
		if (ball.x > game.width) {
			ball.reset();
			scoreLeft++;
			win.play();		// Play the win-sound
		}
		
		// Check for ball <-> paddle collisions:
		if (ball.collides(paddleLeft)) {
			ball.turnRight();
			ping.play();	// Play the "ping"-sound
		}
		if (ball.collides(paddleRight)) {
			ball.turnLeft();
			pong.play();	// Play the "pong"-sound
		}
		
		// Movement update:
		super.update(time);
		
		// Check paddle <-> wall collisions:
		if (paddleLeft.y < 0)
			paddleLeft.y = 0;
		
		if (paddleLeft.y + paddleLeft.height > game.height)
			paddleLeft.y = game.height - paddleLeft.height;
		
		if (paddleRight.y < 0)
			paddleRight.y = 0;
		
		if (paddleRight.y + paddleRight.height > game.height)
			paddleRight.y = game.height - paddleRight.height;
		
	}
	
	/**
	 * Draws the scene onto the screen:
	 */
	override public function draw(screen:Canvas):Void {
		// Fill the screen black:
		screen.clear();
		
		// Draw all entities:
		super.draw(screen);
		
		// Draw the scores on top of the screen:
		screen.drawString(scoreFont, Std.string(scoreLeft), 0xFFFFFF, game.width / 2 - SCORE_PADDING / 2, SCORE_PADDING, Font.RIGHT);
		screen.drawString(scoreFont, Std.string(scoreRight), 0xFFFFFF, game.width / 2 + SCORE_PADDING / 2, SCORE_PADDING, Font.LEFT);
	}
	
}
