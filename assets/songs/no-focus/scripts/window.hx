import openfl.Lib;
var ogwinX:Int;
var ogwinY:Int;
function create() {
    Lib.application.window.resizable = false;
    var win = Lib.application.window; // just to make this following line shorter
    win.resize(512, 768);
    Lib.current.x = 0;
    Lib.current.y = 0;
    Lib.current.scaleX = 2.665;
    Lib.current.scaleY = 2.665;
    var camarasTODAS:Array<FlxCamera> = [camHUD];
    for (camera in camarasTODAS)
    {
        camera.x = 0;
        FlxG.camera.x = 0;
        camera.y = -600;
        FlxG.camera.y = -600;
    }
}
function destroy() {
    Lib.application.window.resizable = true;
	Lib.application.window.resize(1280, 720);
	Lib.current.x = 0;
	Lib.current.y = 0;
	Lib.current.scaleX = 1;
	Lib.current.scaleY = 1;
}