package;

import flixel.FlxG;
import flixel.util.FlxSignal;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.display.Stage;

using StringTools;

/**
 * MADE BY GEOKURELI THE LEGENED GOD HERO MVP
 */
class NGio
{
	public static var isLoggedIn:Bool = false;
	public static var scoreboardsLoaded:Bool = false;

	public static var scoreboardArray = null;

	public static var ngDataLoaded(default, null):FlxSignal = new FlxSignal();
	public static var ngScoresLoaded(default, null):FlxSignal = new FlxSignal();

	public static var GAME_VER:String = "";
	public static var GAME_VER_NUMS:String = '';
	public static var gotOnlineVer:Bool = false;

	public static function noLogin(api:String)
	{
	}

	public function new(api:String, encKey:String, ?sessionId:String)
	{
	}

	function onNGLogin():Void
	{
	}

	// --- MEDALS
	function onNGMedalFetch():Void
	{
	}

	// --- SCOREBOARDS
	function onNGBoardsFetch():Void
	{
	}

	inline static public function postScore(score:Int = 0, song:String)
	{
	}

	function onNGScoresFetch():Void
	{
	}

	inline static public function logEvent(event:String)
	{
		trace(event);
	}

	inline static public function unlockMedal(id:Int)
	{
	}
}
