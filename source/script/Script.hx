package script;

import Type;
import flixel.FlxBasic;
import haxe.CallStack;
import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import util.CoolUtil;

using StringTools;

enum ScriptReturn
{
	PUASE;
	CONTINUE;
}

class Script extends FlxBasic
{
	public var variables(get, null):Map<String, Dynamic>;

	function get_variables()
		return _interp.variables;

	/**
	 *  If set to `true`, rethrow errors
	 *  or just trace the errors when set to `false`
	 */
	public var rethrowError:Bool = #if debug true #else false #end;

	/**
	 *  The last Expr executed
	 *  Used for debugging
	 */
	public var ast(default, null):Expr;

	/**
	 *  The last path whose text was executed
	 *  Used for debugging
	 */
	public var path(default, null):String;

	/**
	 *  Map<PackageName, Path>
	 */
	var _scriptPathMap = new Map<String, String>();

	var _parser:Parser;
	var _interp:Interp;

	public var name:Null<String>;

	public function new()
	{
		super();

		_parser = new Parser();
		_parser.allowTypes = true;
		_parser.allowMetadata = false;
		_parser.allowJSON = false;

		_interp = new Interp();

		set("new", function() {});
		set("destroy", function() {});
		set("import", function(path:String, ?as:Null<String>)
		{
			try
			{
				if (path == null || path == "")
					return;

				var clas = Type.resolveClass(path); // ! class but without a s LMAO -lunar

				if (clas == null)
					return;

				var stringName:String = "";

				if (as != null)
					stringName = as;
				else
				{
					var arr = Std.string(clas).split(".");
					stringName = arr[arr.length - 1];
				}

				set(stringName, clas);
			}
			catch (e)
			{
				trace("SCRIPT IMPORTING CLASS PROBLEM!");
			}
		});

		set("ScriptReturn", ScriptReturn);
		set("PAUSE", ScriptReturn.PUASE);
		set("CONTINUE", ScriptReturn.CONTINUE);

		set("__object__", this);
	}

	public inline function get(name:String):Dynamic
	{
		return _interp.variables.get(name);
	}

	public inline function set(name:String, val:Dynamic)
	{
		_interp.variables.set(name, val);
	}

	public function executeFunc(name:String, ?args:Array<Any>):Dynamic<ScriptReturn>
	{
		try
		{
			var func = get(name);

			var currentReturn:Dynamic = ScriptReturn.CONTINUE;

			if (func != null && Reflect.isFunction(func))
			{
				if (args != null && args != [])
				{
					currentReturn = Reflect.callMethod(null, func, args);
				}
				else
				{
					currentReturn = func();
				}
			}

			return currentReturn;
		}
		catch (e)
		{
			trace('ERROR CALLING FUNCTION $name', 'ARGS: $args');

			return null;
		}
	}

	public function executeString(script:String):Dynamic
	{
		ast = parseScript(script);
		return execute(ast);
	}

	function parseScript(script:String):Null<Expr>
	{
		try
		{
			return _parser.parseString(script, path);
		}
		catch (e:Dynamic)
		{
			#if hscriptPos
			error('$path:${e.line}: characters ${e.pmin} - ${e.pmax}: $e');
			#else
			error(e);
			#end
			return null;
		}
	}

	function execute(ast:Expr):Dynamic
	{
		try
		{
			var val = _interp.execute(ast);
			var main = get("new");

			if (main != null && Reflect.isFunction(main))
				return main();
			else
				return val;
		}
		catch (e:Dynamic)
		{
			error(e + CallStack.toString(CallStack.exceptionStack()));
			trace('Debug AST: $ast');
		}
		return null;
	}

	function error(e:Dynamic)
	{
		if (rethrowError)
			throw e;
		else
			trace(e);
	}

	public override function destroy()
	{
		super.destroy();

		var destroy = get("destroy");

		if (destroy != null && Reflect.isFunction(destroy))
			return destroy();

		_interp = null;
		_parser = null;

		return null;
	}
}
