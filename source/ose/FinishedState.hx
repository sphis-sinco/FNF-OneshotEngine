package ose;

import flixel.FlxGame;
import flixel.FlxState;

class FinishedState extends FlxState
{
	override function create()
	{
		super.create();

		var text:FlxText = new FlxText(0, 0, FlxG.width, 'Yo! You finished the oneshot mod, congrats bro.', 16);
		if (InitState.songs.length > 1)
		{
			text.text += '\nThere are ${InitState.songs.length - 1} more songs though, so you and try to get those if you want.'
				+ '\nIt\'s random chance unless coded otherwise.'
				+ '\n\n(Press ENTER to go back to InitState and try to get those other songs)';
		}
		text.screenCenter();
		add(text);
	}

        override function update(elapsed:Float) {
                super.update(elapsed);

                if (InitState.songs.length > 1 && FlxG.keys.justReleased.ENTER)
                {
                        FlxG.switchState(new InitState());
                }
        }
}
