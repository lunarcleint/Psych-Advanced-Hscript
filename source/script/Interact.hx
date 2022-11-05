package script;

import flixel.FlxBasic;

class Interact extends FlxBasic
{
	public var presetVars:Array<String> = [];

	var parent:Script;

	public var interactObj:Dynamic = {};

	public function new(_:Script)
	{
		super();
		parent = _;
	}

	public function loadPresetVars()
	{
		for (str in parent.variables.keys())
		{
			presetVars.push(str);
		}
	}

	public function upadteObj()
	{
		if (parent == null)
			return;

		// Var Name => Var Orgin (in variables or locals)
		var newVars:Array<String> = [];

		@:privateAccess
		for (map in [parent.variables, parent._interp.locals])
		{
			for (str in map.keys())
			{
				var isScriptCheck:Bool = false;

				@:privateAccess
				var group:Null<ScriptGroup> = parent._group;

				if (group != null)
				{
					var scriptNames:Array<String> = [];

					for (script in group.scripts)
					{
						if (script != parent)
							scriptNames.push(script.name);
					}

					isScriptCheck = scriptNames.contains(str);
				}

				if (!presetVars.contains(str) && !isScriptCheck && !newVars.contains(str))
					newVars.push(str);
			}
		}

		for (varName in newVars)
		{
			try
			{
				@:privateAccess
				var val:Dynamic = parent._interp.resolve(varName);

				Reflect.setProperty(interactObj, varName, val);
			}
			catch (e)
			{
				parent.error("INTERACTION ERROR: " + Std.string(e), '${parent.name}: Interaction');
			}
		}
	}
}
