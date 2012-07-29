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
import org.rygal.demos.pong.Assets;
import org.rygal.demos.pong.entities.Ball;
import org.rygal.demos.pong.entities.Paddle;
import org.rygal.demos.pong.GameAI;
import org.rygal.Game;
import org.rygal.GameTime;
import org.rygal.graphic.BitmapFont;
import org.rygal.graphic.Canvas;
import org.rygal.graphic.Font;
import org.rygal.input.KeyboardEvent;
import org.rygal.input.Keys;
import org.rygal.input.MouseEvent;
import org.rygal.physics.Rectangle;
import org.rygal.Scene;
import org.rygal.util.Storage;

/**
 * The scene containing the main menu.
 * 
 * @author Robert Böhm
 */
class MenuScene extends Scene {
	
	// The strings used in the menu:
	static public inline var TITLE:String = "Pong - Rygal demonstration";
	static public inline var BUTTON_CAPTION:String = "Play game";
	
	// Various positioning variables:
	static public inline var PADDING:Int = 32;
	static public inline var PRESSOFFSET:Int = 1;
	
	// The font for the menu:
	private var font:BitmapFont;
	
	// Determines if the mouse was pressed down on the button:
	private var hasPressedButton:Bool;
	
	
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
		
		// Initialize variables:
		hasPressedButton = false;
		
		// Load resources:
		font = BitmapFont.fromAssets(Assets.ASSET_FONT);
		
		// Register event listeners:
		game.mouse.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		game.mouse.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
	}
	
	/**
	 * Will be called when the left mouse button is pressed down.
	 */
	private function onMouseDown(e:MouseEvent):Void {
		if (hoversButton()) {
			// If the mouse was pressed over the "Play game"-button, set the
			// corresponding variable:
			hasPressedButton = true;
			
		} else {
			// Else, unset it:
			hasPressedButton = false;
			
		}
	}
	
	/**
	 * Will be called when the left mouse button is released.
	 */
	private function onMouseUp(e:MouseEvent):Void {
		if (hasPressedButton && hoversButton()) {
			// Only if the mouse was also pressed down on the button and also
			// still is in the button, it will go ingame:
			game.useScene("game");
			
			// Also, for audio feedback, play a start sound:
			Sound.fromAssets(Assets.ASSET_START).play();
		}
		hasPressedButton = false;
	}
	
	/**
	 * Determines if the "Play game"-button is currently hovered by the mouse.
	 */
	private function hoversButton():Bool {
		// Get the text metrics of the "Play game"-button.
		var textWidth:Int = font.charWidth * BUTTON_CAPTION.length;
		var textHeight:Int = font.charHeight;
		var textRect:Rectangle = new Rectangle(PADDING,
			PADDING * 2 + font.charHeight, textWidth, textHeight);
		
		// Determines if the mouse is in that rectangle:
		return textRect.contains(game.mouse.x, game.mouse.y);
	}
	
	/**
	 * Draws the menu onto the screen:
	 */
	override public function draw(screen:Canvas):Void {
		screen.clear();
		super.draw(screen);
		
		// Determines the color of the button font:
		var buttonFontColor:Int = 0xAAAAAA;
		if (hasPressedButton) {
			buttonFontColor = 0x888888;
		} else if (hoversButton()) {
			buttonFontColor = 0xFFFFFF;
		}
		
		// Draws the title:
		screen.drawString(font, TITLE, 0xFFFFFF, PADDING, PADDING);
		
		// Draws the button:
		if (hasPressedButton) {
			screen.drawString(font, BUTTON_CAPTION, buttonFontColor,
				PADDING + PRESSOFFSET,
				PADDING * 2 + font.charHeight + PRESSOFFSET);
		} else {
			screen.drawString(font, BUTTON_CAPTION, buttonFontColor, PADDING,
				PADDING * 2 + font.charHeight);
		}
	}
	
}
