package shaders;

import data.Paths;
import flixel.FlxCamera;
import flixel.system.FlxAssets.FlxShader;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import shaders.FlxRunTimeShader;
import sys.FileSystem;
import sys.io.File;

class ShaderUtil
{
	public function new() {}

	public static function getShaderFromFile(name:String):FlxRuntimeShader
	{
		return new FlxRuntimeShader(getShaderFrag(name), getShaderVert(name));
	}

	public static function getShaderFrag(name:String):String
	{
		var fragPath:Null<String> = Paths.getPreloadPath('shaders/$name.frag');
		var frag:Null<String> = null;

		if (FileSystem.exists(fragPath))
			frag = File.getContent(fragPath);

		return frag;
	}

	public static function getShaderVert(name:String):String
	{
		var vertPath:Null<String> = Paths.getPreloadPath('shaders/$name.vert');
		var vert:Null<String> = null;

		if (FileSystem.exists(vertPath))
			vert = File.getContent(vertPath);

		return vert;
	}

	public static function addShaderToCamera(camera:FlxCamera, shader:FlxShader)
	{
		if (camera == null || shader == null)
			return;

		@:privateAccess
		var camShaders:Null<Array<BitmapFilter>> = camera._filters;
		if (camShaders == null)
			camShaders = [];
		camShaders.push(cast new ShaderFilter(shader));

		camera.setFilters(camShaders);
	}
}
