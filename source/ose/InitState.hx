package ose;

import states.*;
import backend.*;
import flixel.*;

using StringTools;

class InitState extends FlxState
{
	var missingTextBG:FlxSprite;
	var missingText:FlxText;

	override function create()
	{
		super.create();

		trace('yo');

		missingTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		add(missingTextBG);

		missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		add(missingText);

		#if debug
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		return;
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		return;
		#else
		if (FlxG.save.data.flashing == null && !FlashingState.leftState)
		{
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
			return;
		}
		#end
		#end

		trace('PLAYSTATE SHITZ');
		final songName:String = 'Tutorial';
		final curDifficulty:Int = 2; // 0 - ez, 1 - norm, 2 - hard
		final week:Int = 1;

		persistentUpdate = false;
		var songLowercase:String = Paths.formatToSongPath(songName);
		var poop:String = Highscore.formatSong(songLowercase, curDifficulty);

		try
		{
			Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
		}
		catch (e:haxe.Exception)
		{
			trace('ERROR! ${e.message}');

			var errorStr:String = e.message;
			if (errorStr.contains('There is no TEXT asset with an ID of'))
				errorStr = 'Missing file: ' + errorStr.substring(errorStr.indexOf(songLowercase), errorStr.length - 1); // Missing chart
			else
				errorStr += '\n\n' + e.stack;

			missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
			missingText.screenCenter(Y);
			missingText.visible = true;
			missingTextBG.visible = true;
			FlxG.sound.play(Paths.sound('cancelMenu'));

			return;
		}
		@:privateAccess
		if (PlayState._lastLoadedModDirectory != Mods.currentModDirectory)
		{
			trace('CHANGED MOD DIRECTORY, RELOADING STUFF');
			Paths.freeGraphicsFromMemory();
		}
		LoadingState.prepareToSong();
		LoadingState.loadAndSwitchState(new PlayState());
		#if !SHOW_LOADING_SCREEN FlxG.sound.music.stop(); #end

		#if (MODS_ALLOWED && DISCORD_ALLOWED)
		DiscordClient.loadModRPC();
		#end
	}
}
