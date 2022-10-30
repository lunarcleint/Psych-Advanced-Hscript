package script;

import data.ClientPrefs;
import data.Highscore;
import data.Paths;
import data.StageData;
import data.WeekData;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Lib;
import openfl.system.Capabilities;
import song.Conductor;
import song.Section;
import song.Song;
import states.game.PlayState;
import util.CoolUtil;
import util.TimedEventHandler;

using StringTools;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

class ScriptUtil
{
	public static function getBasicScript():Script
	{
		var script = new Script();

		// Main Class
		script.set("Main", Main);

		// Haxe Classes
		script.set("Std", Std);
		script.set("Type", Type);
		script.set("Reflect", Reflect);
		script.set("Math", Math);
		script.set("StringTools", StringTools);

		#if sys
		script.set("FileSystem", FileSystem);
		script.set("File", File);
		script.set("Sys", Sys);
		#end

		return script;
	}

	public static function setUpFlixelScript(script:Script):Null<Script>
	{
		if (script == null)
			return null;

		// OpenFL
		script.set("Lib", Lib);
		script.set("Capabilities", Capabilities);

		// Basic Stuff
		script.set("state", FlxG.state);
		script.set("camera", FlxG.camera);
		script.set("_game", FlxG.game);
		script.set("FlxG", FlxG);

		script.set("add", function(obj:FlxBasic)
		{
			FlxG.state.add(obj);
		});

		script.set("remove", function(obj:FlxBasic)
		{
			FlxG.state.remove(obj);
		});

		script.set("FlxBasic", FlxBasic);
		script.set("FlxObject", FlxObject);

		// Sprites
		script.set("FlxSprite", FlxSprite);
		script.set("FlxGraphic", FlxGraphic);

		// Tweens
		script.set("FlxTween", FlxTween);
		script.set("FlxEase", FlxEase);

		// Timer
		script.set("FlxTimer", FlxTimer);

		// FlxText
		script.set("FlxText", FlxText);
		script.set("FlxTextFormat", FlxTextFormat);
		script.set("FlxTextFormatMarkerPair", FlxTextFormatMarkerPair);
		script.set("FlxTextBorderStyle", FlxTextBorderStyle);

		// Color Functions
		script.set("colorFromRGB", function(Red:Int, Green:Int, Blue:Int, Alpha:Int = 255)
		{
			return FlxColor.fromRGB(Red, Green, Blue, Alpha);
		});

		script.set("colorFromString", function(str:String)
		{
			return FlxColor.fromString(str);
		});

		// Key Board
		script.set("FlxKey", FlxKey);

		// Sounds
		script.set("FlxSound", FlxSound);

		return script;
	}

	public static function setUpFNFScript(script:Script):Null<Script>
	{
		if (script == null)
			return null;

		// States
		script.set("PlayState", PlayState);

		// Save Data
		script.set("ClientPrefs", ClientPrefs);
		script.set("WeekData", WeekData);
		script.set("Highscore", Highscore);
		script.set("StageData", StageData);

		// Assets
		script.set("Paths", Paths);

		// Song
		script.set("Song", Song);
		script.set("Section", Section);
		script.set("Conductor", Conductor);

		// Misc
		script.set("TimedEventHandler", TimedEventHandler);

		return script;
	}

	function findScriptsInDir(path:String):Array<String>
	{
		return CoolUtil.findFilesInPath(path, ["hx", "hscript", "hsc", "hxs"]);
	}
}
