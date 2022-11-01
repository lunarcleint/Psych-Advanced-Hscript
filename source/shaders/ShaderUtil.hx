package shaders;

import data.Paths;
import shaders.FlxRunTimeShader.FlxRuntimeShader;
import sys.FileSystem;
import sys.io.File;

class ShaderUtil
{
	public static function getShaderFromFile(name:String):Null<FlxRuntimeShader>
	{
		var fragPath:Null<String> = Paths.getPreloadPath('shaders/$name.frag');
		var frag:Null<String> = null;

		var vertPath:Null<String> = Paths.getPreloadPath('shaders/$name.vert');
		var vert:Null<String> = null;

		if (FileSystem.exists(fragPath))
			frag = File.getContent(fragPath);

		if (FileSystem.exists(vertPath))
			vert = File.getContent(vertPath);

		if (frag != null || vert != null)
			return new FlxRuntimeShader(frag, vert);

		return null;
	}
}
