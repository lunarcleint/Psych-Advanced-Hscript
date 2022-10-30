package script;

import flixel.FlxBasic;

class ScriptGroup extends FlxBasic
{
	public var scripts:Array<Script> = [];

	public function addScript(tag:String):Script
	{
		var script:Script = ScriptUtil.getBasicScript();
		script = ScriptUtil.setUpFlixelScript(script);
		script = ScriptUtil.setUpFNFScript(script);

		script.set("__name", tag);
		scripts.push(script);

		return script;
	}

	public function destroyScripts()
	{
		for (_ in scripts)
		{
			if (_ == null)
				continue;

			_.destroy();
			_ = null;
		}

		scripts = [];
	}

	public function executeAllFunc(name:String, ?args:Array<Any>):Array<Dynamic>
	{
		var returns:Array<Dynamic> = [];

		for (_ in scripts)
		{
			if (_ == null)
				continue;

			returns.push(_.executeFunc(name, args));
		}

		return returns;
	}

	public function setAll(name:String, val:Dynamic)
	{
		for (_ in scripts)
		{
			if (_ == null)
				continue;

			_.set(name, val);
		}
	}

	public function getAll(name:String):Array<Dynamic>
	{
		var returns:Array<Dynamic> = [];

		for (_ in scripts)
		{
			if (_ == null)
				continue;

			returns.push(_.get(name));
		}

		return returns;
	}

	public function getScriptByTag(tag:Script):Null<Script>
	{
		for (_ in scripts)
		{
			if (_ == null)
				continue;

			if (_.get("__name") != null && _.get("__name") == tag)
				return _;
		}

		return null;
	}

	public override function destroy()
	{
		super.destroy();

		destroyScripts();
	}
}
