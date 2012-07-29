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

import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import org.rygal.demos.pong.scenes.GameScene;
import org.rygal.demos.pong.scenes.MenuScene;
import org.rygal.demos.pong.scenes.MenuScene;
import org.rygal.Game;

/**
 * The Main-class containing the entry point of the game as well as
 * initializing the game.
 * 
 * @author Robert Böhm
 */
class Main extends Sprite {
	
	// The zoom used for this game:
	static public inline var ZOOM:Int = 2;
	
	public function new() {
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) {
		// Calculating the game's metrics:
		var gameWidth:Int = Std.int(stage.stageWidth / ZOOM);
		var gameHeight:Int = Std.int(stage.stageHeight / ZOOM);
		
		// Creating the game using the MenuScene as the default scene:
		var game:Game = new Game(gameWidth, gameHeight, ZOOM,
			new MenuScene(), "menu");
		
		// Registering the GameScene using the name "game":
		game.registerScene(new GameScene(), "game");
		
		
		// Adds the game to the stage:
		stage.addChild(game.getDisplayObject());
	}
	
	static public function main() {
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
