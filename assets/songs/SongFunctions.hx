import funkin.backend.utils.WindowUtils;
import openfl.Lib;
var resizedCamera = false;
function postCreate() {
    window.title = "Friday Night Funkin': This GC's Insanity | ?????????? | ??????????";
    FlxG.mouse.visible = false;
    if (FlxG.save.data.purespeed) {
        FlxG.cameras.remove(camGame, false);
    }
}
static function toggleHUD() {
    for (sprites in [healthOverlay, healthBar, timeBar, timeBarBG, timeTxt, statsTxt, iconP1, iconP2]) sprites.visible = !sprites.visible;
}
function postUpdate(elapsed:Float) {
    if (!healthBar.visible) botplayhealthOverlay.visible = false;
}
function destroy() {
	WindowUtils.resetTitle();
    FlxG.mouse.visible = true;
    if (resizedCamera) {
        Lib.current.x = 0;
        Lib.current.y = 0;
        Lib.current.scaleX = 1;
        Lib.current.scaleY = 1;
    }
}
static function customResizeCameras(camerax:Int,cameray:Int,camerascalex:Int,camerascaley:Int,camerawidth:Int,cameraheight:Int,resizeplaystatecameras:Bool) {
    resizedCamera = true;
    Lib.current.x = camerax;
	Lib.current.y = cameray;
	Lib.current.scaleX = camerascalex;
	Lib.current.scaleY = camerascaley;
    if (resizeplaystatecameras) {
        for (cameras in [PlayState.instance.camHUD,PlayState.instance.camGame]) {
            cameras.scale.x = camerascalex;
            cameras.scale.y = camerascaley;
            cameras.x = camerax;
            cameras.y = cameray;
            cameras.width = camerawidth;
            cameras.height = cameraheight;
        }
    }
}