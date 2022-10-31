import ("script.RandomTestClass");

function onSongStart()
{
	FlxG.camera.alpha -= 0.2;
	trace("h");

	RandomTestClass.deez();

	addScript("template");
}
