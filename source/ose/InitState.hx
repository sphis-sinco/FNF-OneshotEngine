package ose;

import flixel.util.typeLimit.NextState;
import flixel.FlxG;
import flixel.FlxState;

class InitState extends FlxState
{
	var initialState:NextState = () -> new PlayState();
	var song:String = 'Tutorial';
	var difficulty:Int = 2; // 0 - ez, 1 - norm, 2 - hard
	var week:Int = 0;

	override function create()
	{
		super.create();

		#if debug
		initialState = () -> new TitleState();
		#if cpp
		initialState = () -> new Caching();
		#end
		#end

		if (initialState == () -> new PlayState())
		{
			var songFormat = StringTools.replace(song, " ", "-");
			var poop:String = Highscore.formatSong(songFormat, difficulty);
			PlayState.SONG = Song.loadFromJson(poop, song);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = difficulty;
			PlayState.storyWeek = week;
		}

		FlxG.switchState(initialState);
	}
}
