package ose;

import lime.app.Application;
import Discord.DiscordClient;
import flixel.util.FlxTimer;
import flixel.util.typeLimit.NextState;
import flixel.FlxG;
import flixel.FlxState;

using StringTools;

class InitState extends FlxState
{
	var outdated = false;

	override function create()
	{
		super.create();

		trace('yo');

		#if polymod
		polymod.Polymod.init({modRoot: "mods", dirs: ['introMod']});
		#end

		#if sys
		if (!sys.FileSystem.exists(Sys.getCwd() + "/assets/replays"))
			sys.FileSystem.createDirectory(Sys.getCwd() + "/assets/replays");
		#end

		@:privateAccess
		{
			trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");
		}

		PlayerSettings.init();

		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add(function(exitCode)
		{
			DiscordClient.shutdown();
		});
		#end
		FlxG.save.bind('oneshotengine', 'Sinco');
		KadeEngineData.initSave();

		// NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		// var file:SMFile = SMFile.loadFile("file.sm");
		// this was testing things

		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null)
		{
			// FIX LATER!!!
			// WEEK UNLOCK PROGRESSION!!
			// StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			// QUICK PATCH OOPS!
			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			// Get current version of Engine

			var http = new haxe.Http('https://raw.githubusercontent.com/sphis-sinco/FNF-OneshotEngine/refs/heads/main/version.downloadMe');
			var returnedData:Array<String> = [];

			http.onData = function(data:String)
			{
				returnedData[0] = data.substring(0, data.indexOf(';'));
				returnedData[1] = data.substring(data.indexOf('-'), data.length);
				if (!Global.OSEVersion.contains(returnedData[0].trim()) && !OutdatedSubState.leftState)
				{
					trace('outdated lmao! ' + returnedData[0] + ' != ' + Global.OSEVersion);
					OutdatedSubState.needVer = returnedData[0];
					OutdatedSubState.currChanges = returnedData[1];
					outdated = true;
				}
			}

			http.onError = function(error)
			{
				trace('error: $error');
				FlxG.switchState(new MainMenuState()); // fail but we go anyway
			}

			http.request();
		});

		if (outdated)
		{
			FlxG.switchState(new OutdatedSubState());
		}
		else
		{
			#if debug
			FlxG.switchState(new TitleState());
			#if cpp
			FlxG.switchState(new Caching());
			#end
			#else
			trace('PLAYSTATE SHITZ');
			final song:String = 'Tutorial';
			final difficulty:Int = 2; // 0 - ez, 1 - norm, 2 - hard
			final week:Int = 1;

			final songFormat = StringTools.replace(song, " ", "-");
			final poop:String = Highscore.formatSong(songFormat, difficulty);
			PlayState.SONG = Song.loadFromJson(poop, songFormat);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = difficulty;
			PlayState.storyWeek = week;
			trace('PLAYSTATE SHITZ done');

			FlxG.switchState(new PlayState());
			#end
		}
		#end
	}
}
