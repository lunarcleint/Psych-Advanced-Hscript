//

var test:String = "p";

function create()
{
	var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
	bg.scrollFactor.set(0.9, 0.9);
	add(bg);

	var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
	stageFront.scrollFactor.set(0.9, 0.9);
	stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
	stageFront.updateHitbox();
	add(stageFront);

	if (!ClientPrefs.lowQuality)
	{
		var stageLight:FlxSprite = new FlxSprite(-125, -100).loadGraphic(Paths.image('stage_light'));
		stageLight.scrollFactor.set(0.9, 0.9);
		stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
		stageLight.updateHitbox();
		add(stageLight);

		var stageLight:FlxSprite = new FlxSprite(1225, -100).loadGraphic(Paths.image('stage_light'));
		stageLight.scrollFactor.set(0.9, 0.9);
		stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
		stageLight.updateHitbox();
		stageLight.flipX = true;
		add(stageLight);

		var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
		stageCurtains.scrollFactor.set(1.3, 1.3);
		stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
		stageCurtains.updateHitbox();
		add(stageCurtains);
	}
}

function stepHit(step:Int)
{
	if (step == 16)
	{
		trace(test);
	}
}
