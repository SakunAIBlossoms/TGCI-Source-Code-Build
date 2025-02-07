import openfl.Lib;
// WINDOW MOVE VAR
var winx:Int;
var winy:Int;
function create() {
    winx = Lib.application.window.x;
	winy = Lib.application.window.y;
    Lib.application.window.fullscreen = false;
			Lib.application.window.resizable = false;

			//if (Lib.application.window.maximized == false)
			//{
			//	if (Lib.application.window.width == 1280 && Lib.application.window.height == 720)
			//	{
			//		Lib.application.window.move(winx + 240, winy + 60);
			//	}
			//}
			//else
			//{
			//	Lib.application.window.maximized = false;
			//	Lib.application.window.move(560, 240);
			//}
			Lib.application.window.resize(540, 900);

			stream = 1;
			Lib.application.window.resizable = false;

			Lib.current.x = -540;
			Lib.current.y = -900;
			Lib.current.scaleX = 3;
			Lib.current.scaleY = 3;
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