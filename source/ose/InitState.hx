package ose;

import flixel.util.typeLimit.NextState;
import flixel.FlxG;
import flixel.FlxState;

class InitState extends FlxState
{
	var initialState:NextState = () -> new PlayState();
        var song:String = 'tutorial';

        override function create() {
                super.create();


                #if debug
                initialState = () -> new TitleState();
                #if cpp
                initialState = () -> new Caching();
                #end
                #end

                FlxG.switchState(initialState);
        }
        
}