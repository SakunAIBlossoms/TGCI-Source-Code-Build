
import flixel.addons.display.FlxBackdrop;
import flixel.addons.text.FlxTypeText;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.utils.CoolUtil;

var introRose:FunkinSprite;
var rosebloom:FunkinSprite;
var estatica:FlxSprite;
var subtitle:FlxTypeText;
var curStep:Int;
var endScreen = false;

function create() {
    FlxG.mouse.visible = false;
    subCam = new FlxCamera(0,0,FlxG.camera.width,FlxG.camera.height,FlxG.camera.zoom);
    subCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(subCam, false);

    estatica = new FlxSprite();
	estatica.frames = Paths.getSparrowAtlas('menus/estatica_uwu');
	estatica.animation.addByPrefix('idle', "Estatica papu", 15);
	estatica.animation.play('idle');
	estatica.color = FlxColor.RED;
	estatica.alpha = 1;
    estatica.scale.set(2,2);
	estatica.updateHitbox();
    estatica.screenCenter(0x11);
    estatica.antialiasing = false;
	add(estatica);

    pipes = new FlxBackdrop(Paths.image('cutscenes/finalcutscene/pipes'), 0x01);
    pipes.scale.set(6,6);
    pipes.velocity.set(-120,0);
    pipes.updateHitbox();
    pipes.alpha = 0;
    add(pipes);

    floor = new FlxBackdrop(Paths.image('cutscenes/finalcutscene/floor'), 0x01);
    floor.scale.set(6,6);
    floor.velocity.set(-120,0);
    floor.updateHitbox();
    floor.y = FlxG.height - 112;
    floor.alpha = 0;
    add(floor);

    rosebloom = new FunkinSprite(0,0,Paths.image('cutscenes/finalcutscene/rose'));
	rosebloom.animation.addByPrefix('right', "overworld bf walk right", 4, true);
	rosebloom.animation.play('right');
    rosebloom.antialiasing = false;
    rosebloom.scale.set(14,14);
    rosebloom.updateHitbox();
    rosebloom.screenCenter(0x10);
    rosebloom.x -= 400;
    rosebloom.y += 80;
    add(rosebloom);

    topBar = new FlxSprite(0,-30).makeGraphic(FlxG.width * 2,150,FlxColor.BLACK);
    topBar.cameras = [subCam];
    add(topBar);

    subtitle = new FlxTypeText(20,40,FlxG.width, "Well done.", 32);
    subtitle.borderStyle = FlxTextBorderStyle.OUTLINE;
	subtitle.borderSize = 1;
	subtitle.borderColor = 0xFF000000;
    subtitle.color = FlxColor.RED;
    subtitle.cameras = [subCam];
    subtitle.delay = 0.01;
    add(subtitle);
    subtitle.start();

    endbg = new FunkinSprite(0,0,Paths.image('cutscenes/finalcutscene/bg'));
    endbg.angle = 180;
    endbg.antialiasing = false;
    endbg.scale.set(3,3);
    endbg.updateHitbox();
    endbg.screenCenter(0x11);
    endbg.y -= 600;
    endbg.alpha = 0;
    add(endbg);
    endEYE = new FunkinSprite(0,0,Paths.image('cutscenes/finalcutscene/leveleye'));
    endEYE.animation.addByPrefix('idle', "leveleye idle", 11, true);
    endEYE.animation.play('idle');
    endEYE.alpha = 0;
    endEYE.screenCenter(0x11);
    add(endEYE);

    staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3];
    FlxG.camera.addShader(staticshit);
    ntscShader = new CustomShader("NTSCSFilter");
    FlxG.camera.addShader(ntscShader);
    abberation = new CustomShader("Abberation");
    abberation.data.aberrationAmount.value = [0.05];
    FlxG.camera.addShader(abberation);
}
function update() {
    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];
    if (ntscShader != null)
        ntscShader.data.uFrame.value = [Conductor.songPosition];
    if (curStep > 190) {
        FlxG.camera.shake(0.001, 999999999999);
        subCam.shake(0.002, 999999999);
    }
    if (endScreen && FlxG.keys.justPressed.ENTER)
        begin();
    if (FlxG.keys.justPressed.BACKSPACE)
        FlxG.switchState(new MainMenuState());
}
function stepHit(step:Int) {
    runSubtitleCheck(step);
    curStep = step;
    switch(step) {
        case 190:
            staticshit.data.strengthMulti.value = [0.9];
            abberation.data.aberrationAmount.value = [0.2];
            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.6, {ease: FlxEase.circOut});
        case 267:
            FlxTween.tween(FlxG.camera, {zoom: 0.8}, 0.4, {ease: FlxEase.circIn});
        case 270:
            for (sprites in [pipes, floor, rosebloom, estatica, subCam]) {
                sprites.visible = false;
                sprites.destroy();
            }
        case 300:
            endtime();
        case 316:
            CoolUtil.playMusic(Paths.music('warpzone/0'), false, 0.2, true, 60);
    }
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
    subtitle.resetText(newText);
    subtitle.start();
}

function postCreate() {
    FlxTween.tween(rosebloom, {x: 452.5}, 1.6);
    for (sprites in [pipes, floor]) {
        FlxTween.tween(sprites, {alpha: 1}, 1.2, {ease: FlxEase.circIn});
    }
    CoolUtil.playMusic(Paths.sound('overworldCutscene/ultracut'), false, 1, false, 64);
    //FlxG.sound.play(Paths.sound('overworldCutscene/ultracut'));
}

// come and face me little rat your time has come - Ultra M
function endtime() {
    for (i in [endEYE, endbg]) {
        FlxTween.tween(i, {alpha: 1}, 1.2);
        FlxTween.tween(FlxG.camera, {zoom: 1.4}, 1.6, {ease: FlxEase.circOut});
    }
    endScreen = true;
}

function begin() {
    //enter the pipe...
    FlxG.sound.play(Paths.sound('overworldCutscene/enter_the_pipe'));
    FlxTween.tween(FlxG.camera, {zoom: 1.6}, 1.2, {ease: FlxEase.circOut});
    PlayState.loadSong('all-stars', "normal", false, false);
    new FlxTimer().start(3, ()-> {FlxG.switchState(new PlayState());});
}