import openfl.Lib;
// WINDOW MOVE VAR
var winx:Int;
var winy:Int;
var stream:Int = 0;
var blackbars:FlxSprite;
function create() {
    Lib.application.window.fullscreen = false;
    Lib.application.window.resizable = false;
    Lib.application.window.resize(600, 900);
    stream = 1;
    Lib.application.window.resizable = true;
    Lib.current.scaleX = 2.7;
    Lib.current.scaleY = 2.7;
    var camarasTODAS:Array<FlxCamera> = [camGame, camHUD];
    for (camera in camarasTODAS)
    {
    	camera.x = -400;
    	FlxG.camera.x = -400;
    
    	camera.y = -610;
    	FlxG.camera.y = -610;
    }
}
function destroy() {
    Lib.application.window.resizable = true;
	Lib.application.window.resize(1280, 720);
	stream = 1;
	Lib.current.x = 0;
	Lib.current.y = 0;
	Lib.current.scaleX = 1;
	Lib.current.scaleY = 1;
}
