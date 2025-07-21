package ose;

class Results extends MusicBeatState
{
	public var ref:FlxSprite;

	public var character:FlxSprite;
	public var container:FlxSprite;

	override function create()
	{
		super.create();

		characterFileName = getCharacterFileName();

		ref = new FlxSprite();
		ref.loadGraphic(Paths.image('results/reference'));
		add(ref);
		ref.screenCenter();

                var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
                add(bg);
                bg.screenCenter();

		character = new FlxSprite();
		character.frames = Paths.getSparrowAtlas('results/$characterFileName');
		character.animation.addByPrefix('animation', characterFileName, 24, false);
		character.animation.play('animation');
		character.setPosition(530.95 - 306.15, -76 + 3.1);
		add(character);
	}

	public var characterFileName:String = '';

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function getCharacterFileName():String
	{
		return 'boyfriend_results';
	}
}
