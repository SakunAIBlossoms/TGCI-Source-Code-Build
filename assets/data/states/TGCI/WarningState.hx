import funkin.menus.BetaWarningState;
import funkin.menus.TitleState;
import funkin.backend.MusicBeatState;
import funkin.backend.scripting.ModState;
import Sys;
var leftState:Bool = false;
var warnImg:FlxSprite;
var transitioning:Bool = false;
function create() {
	FlxG.resizeWindow(1280, 720);
	if (FlxG.save.data.nostartwarn) goToTitle();
	warnImg = new FlxSprite().loadGraphic(Paths.image("warningscreen"));
	warnImg.antialiasing = false;
	warnImg.updateHitbox();
	warnImg.screenCenter();
	warnImg.y = warnImg.y - 700;
	add(warnImg);
	FlxTween.tween(warnImg, {y: warnImg.y + 700}, 1.2, {ease:FlxEase.backOut});
	FlxG.sound.play(Paths.sound('menu/message'), 1);
	warn2Text = new FunkinText(0,0,FlxG.width - 200, "This mod was made on Codename Engine.\n\nCodename Engine is a wip engine that can be unstable at times if it crashes we arent responsible for anything that happens\n\nPlease play responsibly you are in complete control of the mod.", 54, true);
	warn2Text.alignment = "center";
	warn2Text.visible = false;
	warn2Text.alpha = 0;
	warn2Text.screenCenter(0x11);
	add(warn2Text);
}
function update(elapsed:Float) {
	if (controls.ACCEPT && !transitioning && !warn2Text.visible) {
		transitioning = true;
		warn2Text.visible = true;
		FlxG.sound.play(Paths.sound('menu/accept'), 1);
		FlxG.camera.flash(FlxColor.BLACK, 1);
		FlxTween.tween(warnImg, {y: warnImg.y + 700}, 1.5, {ease: FlxEase.backIn, onComplete: function (twn:FlxTween){
			FlxTween.tween(warn2Text, {alpha: 1}, 0.8, {ease: FlxEase.circIn, onComplete: function (twn:FlxTween){
				transitioning = false;
			}});
		}});
	}
	if (controls.ACCEPT && !transitioning && warn2Text.visible) {
		FlxG.sound.play(Paths.sound('riser'), 2);
		FlxTween.tween(FlxG.camera, {zoom: 1.5}, 1.8, {ease: FlxEase.expoInOut,
			onComplete: function(twn:FlxTween) {
				if (FlxG.save.data.hasdonefirsttimesetup) beginwindowtwn();
				else goToTitle();
		}});
		FlxTween.tween(warn2Text, {alpha: 0}, 1.2, {ease: FlxEase.circIn});
	}
}
function goToTitle() {
	MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
	FlxG.switchState(new TitleState());
}
function beginwindowtwn() {
	FlxTween.tween(window, {width: 800, height: 600}, 0.3*4, {ease:FlxEase.circInOut, onComplete: function(twn:FlxTween){ 
		completeWindowTwn();
	}});
}
function completeWindowTwn() {
	FlxG.resizeWindow(800, 600);
    FlxG.resizeGame(800, 600);
	goToTitle();
}