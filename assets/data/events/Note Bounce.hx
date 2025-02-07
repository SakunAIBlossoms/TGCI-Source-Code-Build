var bounceMult:Int = 0;
var iLoveTrampolining:Bool = false;
var originalY:Int = 0;
function postCreate() {
    originalY = camHUD.y;
}
function onEvent(e) {
    if (e.event.name == "Note Bounce" || e.event.name == "Note_Bounce") {
        var params:Array = e.event.params;
        iLoveTrampolining = params[0];
        bounceMult = params[1];
    }
}

function stepHit(curStep:Int) {
    if (iLoveTrampolining) {
        if (curStep % 4 == 0) {
            FlxTween.tween(camHUD, {y: originalY + -10 * bounceMult}, Conductor.stepCrochet*0.002, {ease: FlxEase.circOut});
        }
        if (curStep % 4 == 2) {
            FlxTween.tween(camHUD, {y: originalY}, Conductor.stepCrochet*0.002, {ease: FlxEase.sineIn});
        }
    }
    else {
        camHUD.y = originalY;
    }
}