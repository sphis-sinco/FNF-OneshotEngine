package ose;

class Results extends MusicBeatState
{
	public var ref:FlxSprite;

	public var character:FlxSprite;
	public var container:FlxSprite;

	public var resultsText:FlxText;

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

		resultsText = new FlxText(0, 0, 0, '', 64);
		resultsText.font = Paths.font('5by7.ttf');
		resultsText.setPosition(30, 160);
		add(resultsText);

		/**
                PlayState.campaignScore = FlxG.random.int(0, 2400);
		PlayState.campaignMisses = FlxG.random.int(0, 2400);
		PlayState.highestCombo = FlxG.random.int(0, 2400);
                **/
	}

	public var characterFileName:String = '';

	public var score:Float = 0;
	public var misses:Float = 0;
	public var highestCombo:Float = 0;

	public var tickScore:Float = 0.015;
	public var tickMisses:Float = 0.015;
	public var tickHighestCombo:Float = 0.015;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		tickScore += tickScore * 0.015;
		tickMisses += tickMisses * 0.015;
		tickHighestCombo += tickHighestCombo * 0.015;

		score = FlxMath.lerp(score, PlayState.campaignScore, tickScore);
		misses = FlxMath.lerp(misses, PlayState.campaignMisses, tickMisses);
		highestCombo = FlxMath.lerp(highestCombo, PlayState.highestCombo, tickHighestCombo);

		resultsText.text = 'Score: ${Std.int(score)}' + '\n\n\nMisses: ${Std.int(misses)}' + '\n\n\nHighest Combo: ${Std.int(highestCombo)}';
		resultsText.text = resultsText.text.toUpperCase();
	}

	public function getCharacterFileName():String
	{
		return 'boyfriend_results';
	}
}
