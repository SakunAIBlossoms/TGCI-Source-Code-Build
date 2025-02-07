import flixel.text.FlxText.FlxTextBorderStyle;
import funkin.game.HealthIcon;
var subtitleText:FunkinText;
var healthIcon:HealthIcon;
var OUTLINE = FlxTextBorderStyle.OUTLINE;
function create() {
    subtitleText = new FunkinText(0, FlxG.height - 150, 0, "", 36, true);
    subtitleText.cameras = [camHUD];
    subtitleText.antialiasing = false;
    add(subtitleText);
    subtitleText.alpha = 0;
}
function onEvent(e) {
    if (e.event.name == "Subtitle") {
        FlxTween.cancelTweensOf(subtitleText);
        // for params[] 0 is visible boolean, 1 is string text, 2 is the window title
        var params:Array = e.event.params;
        if (params[0]) {
            subtitleText.visible = true;
            subtitleText.y = FlxG.height-150;
            subtitleText.alpha = 0;
            subtitleText.text = params[1];
            FlxTween.tween(subtitleText, {y: FlxG.height - 200, alpha: 1}, 0.4, {ease: FlxEase.quartOut});
        }
        if (!params[0])  {
            FlxTween.tween(subtitleText, {y: FlxG.height - 150, alpha: 0}, 0.6, {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween){
                subtitleText.visible = false;
            }});
        }
        subtitleText.screenCenter(0x01);
        if (params[2]) window.title = params[1];
        if (curSong == "all-stars" | "endgame") subtitleText.color = 0xB60000;
    }
}