import openfl.Lib;
// WINDOW MOVE VAR
var winx:Int;
var winy:Int;
var stream:Int = 0;
function create() {
    Lib.application.window.fullscreen = false;
    Lib.application.window.resizable = false;
    Lib.application.window.resize(800, 600);
    stream = 1;
    Lib.application.window.resizable = false;
    Lib.current.scaleX = 1.35;
    Lib.current.scaleY = 1.35;
    var camarasTODAS:Array<FlxCamera> = [camGame, camHUD];
    for (camera in camarasTODAS)
    {
    	camera.x = -180;
    	FlxG.camera.x = -180;
    
    	camera.y = -130;
    	FlxG.camera.y = -130;
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