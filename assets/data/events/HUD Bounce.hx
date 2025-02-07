var hudBopIntensity:Int = 0;
var bopShit:Bool = false;



function onEvent(e) {
    if (e.event.name == "HUD Bounce" || e.event.name == "HUD_Bounce") {
        var params:Array = e.event.params;
        bopShit = params[0];
        hudBopIntensity = params[1];
    }
}

function beatHit(curBeat:Int) {
    if (bopShit) {
        if (curBeat % 2 == 0) {
            camHUD.angle = 2*hudBopIntensity;
            FlxTween.angle(camHUD, 0, 0.8, {ease: FlxEase.backOut});
        }
        if (curBeat % 2 == 1) {
            camHUD.angle = 2*-hudBopIntensity;
            FlxTween.angle(camHUD, 0, 0.8, {ease: FlxEase.backOut});
        }
    }
    else {
        camHUD.angle = 0;
    }
}