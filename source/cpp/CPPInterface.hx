package cpp;

/**
 * ! LITTERLY THE ONLY REASON THIS EXIST IS BECAUSE IF YOU NATIVELY INTERACT WITH THE CPPWindows.hx FILE 
 * ! THE COMPILIER WILL CRY 
 */
class CPPInterface
{
	#if windows
	public static function darkMode()
	{
		CPPWindows.setWindowColorMode(DARK);
	}

	public static function lightMode()
	{
		CPPWindows.setWindowColorMode(LIGHT);
	}

	public static function setWindowAlpha(a:Float)
	{
		CPPWindows.setWindowAlpha(a);
	}

	public static function _setWindowLayered()
	{
		CPPWindows._setWindowLayered();
	}
	#end

	#if windows
	public static function getRam():UInt64
	{
		return CPPWindows.obtainRAM();
	}
	#elseif linux
	public static function getRam():UInt64
	{
		return CPPLinux.obtainRAM();
	}
	#end
}
