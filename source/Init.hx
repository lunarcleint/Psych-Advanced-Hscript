package;

import cpp.CPPInterface;
import data.ClientPrefs;
import data.Highscore;
import data.Paths;
import flixel.FlxG;
import flixel.FlxState;
import input.PlayerSettings;
import lime.app.Application;
import openfl.Lib;
import shaders.ShaderUtil;
import states.menus.StoryMenuState;
import states.menus.TitleState;
import util.CoolUtil;
import util.Discord.DiscordClient;

class Init extends FlxState
{
	public override function new()
	{
		super();
		FlxG.mouse.visible = false;
	}

	public override function create()
	{
		super.create();

		#if cpp
		CPPInterface.darkMode();
		#end

		#if cpp
		cpp.NativeGc.enable(true);
		cpp.NativeGc.run(true);
		#end

		ClientPrefs.loadDefaultKeys();

		FlxG.autoPause = true;

		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

		PlayerSettings.init();

		PlayerSettings.init();

		FlxG.save.bind(CoolUtil.formatBindString(Lib.application.meta.get("file")), CoolUtil.formatBindString(Lib.application.meta.get("company")));

		ClientPrefs.loadPrefs();

		Highscore.load();

		if (FlxG.save.data != null && FlxG.save.data.fullscreen)
		{
			FlxG.fullscreen = FlxG.save.data.fullscreen;
		}

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		#if desktop
		if (!DiscordClient.isInitialized)
		{
			DiscordClient.initialize();
			Application.current.onExit.add(function(exitCode)
			{
				DiscordClient.shutdown();
			});
		}
		#end

		FlxG.switchState(Type.createInstance(Main.initialState, []));
	}
}
