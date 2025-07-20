import flixel.input.gamepad.FlxGamepad;
import openfl.Lib;
import flixel.FlxG;

class KadeEngineData
{
	static var overrideSaves:Bool = #if !debug false #else true #end;

	public static function initSave()
	{
		if (FlxG.save.data.newInput == null || overrideSaves)
			FlxG.save.data.newInput = true;

		if (FlxG.save.data.downscroll == null || overrideSaves)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.dfjk == null || overrideSaves)
			FlxG.save.data.dfjk = false;

		if (FlxG.save.data.accuracyDisplay == null || overrideSaves)
			FlxG.save.data.accuracyDisplay = false;

		if (FlxG.save.data.offset == null || overrideSaves)
			FlxG.save.data.offset = 0;

		if (FlxG.save.data.songPosition == null || overrideSaves)
			FlxG.save.data.songPosition = false;

		if (FlxG.save.data.fps == null || overrideSaves)
			FlxG.save.data.fps = false;

		if (FlxG.save.data.changedHit == null || overrideSaves)
		{
			FlxG.save.data.changedHitX = -1;
			FlxG.save.data.changedHitY = -1;
			FlxG.save.data.changedHit = false;
		}

		if (FlxG.save.data.fpsRain == null || overrideSaves)
			FlxG.save.data.fpsRain = false;

		if (FlxG.save.data.fpsCap == null || overrideSaves)
			FlxG.save.data.fpsCap = 120;

		if (FlxG.save.data.fpsCap > 285 || FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = 120; // baby proof so you can't hard lock ur copy of kade engine

		if (FlxG.save.data.scrollSpeed == null || overrideSaves)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.npsDisplay == null || overrideSaves)
			FlxG.save.data.npsDisplay = false;

		if (FlxG.save.data.frames == null || overrideSaves)
			FlxG.save.data.frames = 10;

		if (FlxG.save.data.accuracyMod == null || overrideSaves)
			FlxG.save.data.accuracyMod = 1;

		if (FlxG.save.data.watermark == null || overrideSaves)
			FlxG.save.data.watermark = true;

		if (FlxG.save.data.ghost == null || overrideSaves)
			FlxG.save.data.ghost = false;

		if (FlxG.save.data.distractions == null || overrideSaves)
			FlxG.save.data.distractions = true;

		if (FlxG.save.data.flashing == null || overrideSaves)
			FlxG.save.data.flashing = true;

		if (FlxG.save.data.resetButton == null || overrideSaves)
			FlxG.save.data.resetButton = false;

		if (FlxG.save.data.botplay == null || overrideSaves)
			FlxG.save.data.botplay = false;

		if (FlxG.save.data.cpuStrums == null || overrideSaves)
			FlxG.save.data.cpuStrums = false;

		if (FlxG.save.data.strumline == null || overrideSaves)
			FlxG.save.data.strumline = false;

		if (FlxG.save.data.customStrumLine == null || overrideSaves)
			FlxG.save.data.customStrumLine = 0;

		if (FlxG.save.data.camzoom == null || overrideSaves)
			FlxG.save.data.camzoom = true;

		if (FlxG.save.data.scoreScreen == null || overrideSaves)
			FlxG.save.data.scoreScreen = true;

		if (FlxG.save.data.inputShow == null || overrideSaves)
			FlxG.save.data.inputShow = false;

		if (FlxG.save.data.optimize == null || overrideSaves)
			FlxG.save.data.optimize = false;

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		KeyBinds.gamepad = gamepad != null;

		Conductor.recalculateTimings();
		PlayerSettings.player1.controls.loadKeyBinds();
		KeyBinds.keyCheck();

		Main.watermarks = FlxG.save.data.watermark;

		(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
	}
}
