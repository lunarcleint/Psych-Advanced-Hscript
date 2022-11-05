package script;

import flixel.FlxBasic;

class ScriptGroup extends FlxBasic
{
	public var scripts:Array<Script> = [];

	public var onAddScript:Array<Script->Void> = [];

	public override function new()
	{
		super();
	}

	public function addScript(tag:String):Script
	{
		var script:Script = ScriptUtil.getBasicScript();
		ScriptUtil.setUpFlixelScript(script);
		ScriptUtil.setUpFNFScript(script);

		@:privateAccess
		script._group = this;

		script.set("name", tag);
		script.name = tag;

		for (func in onAddScript)
		{
			if (func == null)
				continue;
			func(script);
		}

		scripts.push(script);

		return script;
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

	public function getScriptByTag(tag:String):Null<Script>
	{
		for (_ in scripts)
		{
			if (_ == null)
				continue;

			if (_.name != null && _.name == tag)
				return _;
		}

		return null;
	}

	public override function destroy()
	{
		super.destroy();

		for (_ in scripts)
		{
			if (_ == null)
				continue;

			_.destroy();
			_ = null;
		}

		scripts = [];
	}

	public function reloadScriptInteractions()
	{
		for (script in scripts)
		{
			if (script.interacter.presetVars == [])
				continue;

			script.interacter.upadteObj();

			for (_ in scripts)
			{
				if (_ == null || script == _)
					continue;

				if (_.variables.exists(script.name))
				{
					script.error(script.name + " is alreadly a variable in the script, please change the variable to a different name!",
						'${script.name}: Interation Error!');
					continue;
				}

				_.set(script.name, script.interacter.interactObj);
			}
		}
	}
}
