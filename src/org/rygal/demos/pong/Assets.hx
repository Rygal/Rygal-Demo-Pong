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
import org.rygal.graphic.Texture;

/**
 * A class that contains all the names of the assets in this project.
 * 
 * @author Robert Böhm
 */
class Assets {
	
	static public inline var ASSET_BALL:String = "images/ball.png";
	static public inline var ASSET_PADDLE:String = "images/paddle.png";
	static public inline var ASSET_SCOREFONT:String = "fonts/scorefont.txt";
	static public inline var ASSET_FONT:String = "fonts/charset.txt";
	static public inline var ASSET_PING:String = "sounds/ping.wav";
	static public inline var ASSET_PONG:String = "sounds/pong.wav";
	static public inline var ASSET_START:String = "sounds/start.wav";
	static public inline var ASSET_LOSE:String = "sounds/lose.wav";
	static public inline var ASSET_WIN:String = "sounds/win.wav";
	
	/**
	 * This class shouldn't be instanciated, thus the constructor is private.
	 */
	private function new() {}
	
}