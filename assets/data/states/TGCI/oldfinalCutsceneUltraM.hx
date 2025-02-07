
import flixel.addons.display.FlxBackdrop;
import flixel.addons.text.FlxTypeText;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.utils.CoolUtil;

var introRose:FunkinSprite;
var rosebloom:FunkinSprite;
var estatica:FlxSprite;
var curStep:Int;
var endScreen = false;
var beforeCut = true;

function create() {
    FlxG.mouse.visible = false;
    uiCam = new FlxCamera(0,0,FlxG.camera.width,FlxG.camera.height,FlxG.camera.zoom);
    uiCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(uiCam, false);

    bg = new FunkinSprite(0,0,Paths.image('cutscenes/finalcutscene/bg'));
    bg.angle = 90;
    bg.scale.set(4,4);
    bg.updateHitbox();
    bg.screenCenter(0x11);
    bg.x += 500;
    add(bg);

    rosebloom = new FunkinSprite(0,0,Paths.image('cutscenes/finalcutscene/rose'));
    rosebloom.animation.addByPrefix('idle', "overworld bf walk down", 4, true);
	rosebloom.animation.addByPrefix('right', "overworld bf walk right", 4, true);
	rosebloom.animation.play('idle');
    rosebloom.antialiasing = false;
    rosebloom.scale.set(2,2);
    rosebloom.updateHitbox();
    rosebloom.screenCenter(0x11);
    rosebloom.scrollFactor.set();
    add(rosebloom);

    blackBar1 = new FlxSprite().makeGraphic(300,FlxG.height*2,FlxColor.BLACK);
    blackBar1.cameras = [uiCam];
    add(blackBar1);
    
    blackBar2 = new FlxSprite().makeGraphic(300,FlxG.height*2,FlxColor.BLACK);
    blackBar2.x = FlxG.width - 300;
    blackBar2.cameras = [uiCam];
    add(blackBar2);

    overlay = new FunkinSprite(0,0,Paths.image('warpzone/overworld_overlay'));
    overlay.animation.addByPrefix('idle', "overworld overlay idle", 4, true);
	overlay.animation.play('idle');
    overlay.scale.set(3,3);
    overlay.updateHitbox();
    overlay.screenCenter(0x11);
    overlay.cameras = [uiCam];
    add(overlay);
}
function update() {
    if (!beforeCut && !endScreen) 
        FlxG.camera.scroll.x += 0.1;
    if (beforeCut && FlxG.keys.justPressed.RIGHT) 
        beginCut();
    if (endScreen && FlxG.keys.justPressed.ENTER)
        begin();
    if (FlxG.keys.justPressed.BACKSPACE)
        FlxG.switchState(new MainMenuState());
}
function stepHit(step:Int) {
    runSubtitleCheck(step);
    curStep = step;
}
function beginCut() {
    beforeCut = false;
    CoolUtil.playMusic(Paths.sound('overworldCutscene/ultracut'), false, 1, false, 64);
    rosebloom.animation.play('right');
}
function runSubtitleCheck(theCurStep:Int) {
    switch(theCurStep) {
        case 10:
            changeSubs("Very");
        case 13:
            changeSubs("Well done");
    }
}

function changeSubs(newText:String) {
}

function postCreate() {
    //CoolUtil.playMusic(Paths.sound('overworldCutscene/ultracut'), false, 1, false, 64);
}

// come and face me little rat your time has come - Ultra M
function endtime() {
}

function begin() {
    //enter the pipe...
    PlayState.loadSong('all-stars', "normal", false, false);
    new FlxTimer().start(3, ()-> {FlxG.switchState(new PlayState());});
}