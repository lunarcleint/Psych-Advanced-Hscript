//
import("flixel.addons.display.FlxRuntimeShader");
import("shaders.ShaderUtil");
import("states.game.PlayState");

function onCreate()
{
	var shader:FlxRuntimeShader = ShaderUtil.getShaderFromFile("chrom");
	shader.setFloatArray("rOffset", [-0.005, 0]);
	shader.setFloatArray("gOffset", [0, 0]);
	shader.setFloatArray("bOffset", [0.005, 0]);

	PlayState.addShaderToCamera(PlayState.camGame, shader);
}
