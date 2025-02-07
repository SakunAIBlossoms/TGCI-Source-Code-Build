import funkin.backend.utils.CoolUtil;
import flixel.math.FlxRect;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;
function create() {
    introLength = 0;
}
function showShit(type:String,hiding:String) {
    if (type == "intro") {
        if (hiding == "true")
            FlxTween.tween(introimage, {y: FlxG.height + 300}, 1.2, {ease: FlxEase.backInOut});
        else if (hiding == "false")
            FlxTween.tween(introimage, {y: FlxG.height / 2 + 170}, 1.2, {ease: FlxEase.backInOut});
    }
    else if (type == "finish") {
        if (hiding == "true") {
            FlxTween.tween(finish, {y: FlxG.height + 300}, 1.2, {ease: FlxEase.backInOut});
        }
        else if (hiding == "false")
            //FlxG.sound.music.volume = 0.3;
            vocals.fadeOut(0.4,0.2);
            FlxG.sound.play(Paths.sound('songs/no-focus/finish'), 1);
            FlxTween.tween(finish, {y: FlxG.height / 2 + 170}, 1.2, {ease: FlxEase.backInOut});
    }
}
function postCreate() {
    bottomCam = new FlxCamera(0,-230,FlxG.width,350);
    bottomCam.bgColor = FlxColor.TRANSPARENT;
    topCam = new FlxCamera(0,-600,FlxG.width,400);
    topCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(topCam, false);
    FlxG.cameras.add(bottomCam, false);
    FlxG.cameras.add(camHUD, false);
    // the animated bg shit idfk
    bgbottom = new FlxBackdrop(Paths.image('stages/piracy/bgbottom'));
	bgbottom.scrollFactor.set(0, 0);
	bgbottom.velocity.set(40, 0);
	bgbottom.setGraphicSize(Std.int(bgbottom.width * 2.5));
	bgbottom.updateHitbox();
	bgbottom.x = 600;
	bgbottom.y = downscroll ? 360 : -120;
	bgbottom.antialiasing = false;
	bgbottom.cameras = [topCam];
    // thingy behind alcrete
    bg1 = new FunkinSprite(55,0,Paths.image("stages/piracy/HallyBG2"));
    bg1.cameras = [bottomCam];
    bg1.scale.set(1.3,1.6);
    // the scrolling bg
    bg2 = new FlxBackdrop(Paths.image("stages/piracy/HallyBG4"));
    bg2.cameras = [bottomCam];
    bg2.scale.set(1.3,1.3);
    bg2.updateHitbox();
    bg2.velocity.set(0, 40);
    bg2.x = 235;
    bg2.y = bottomCam.height - 385;
    // funni bar
    bg3 = new FunkinSprite(55,FlxG.height - 320,Paths.image("stages/piracy/HallyBG1"));
    bg3.cameras = [bottomCam];
    bg3.scale.set(1.3,1.3);
	add(bgbottom);
    insert(bgbottom, bg1);
    insert(bg1, bg2);
    cutthealcrete = new FlxRect(bg1.x+70,bg1.y,bg1.width,dad.height);
    dad.cameras = [bottomCam];
    boyfriend.cameras = [bottomCam];
    dad.scrollFactor.set();
    boyfriend.scrollFactor.set();
    boyfriend.x -=  580;
    boyfriend.y -=  455;
    boyfriend.flipX = false;
    dad.x -= 360;
    dad.y -= 150;
    //dad.clipRect = cutthealcrete;
    introimage = new FunkinSprite(180,FlxG.height + 300,Paths.image("stages/piracy/start"));
    introimage.antialiasing = false;
    introimage.scale.set(2,2);
    introimage.cameras = [camHUD];
    finish = new FunkinSprite(193,FlxG.height + 300,Paths.image("stages/piracy/Finish"));
    finish.antialiasing = false;
    finish.scale.set(2,2);
    finish.cameras = [camHUD];
    add(finish);
    persistentUpdate = true;
    persistentDraw = true;
}
function onSongStart() {
    showShit("intro","false");
}
function beatHit(curBeat:Int) {
    if (curBeat == 10) {
        showShit("intro","true");
    }
}
function update(elapsed) {
    //trace(dad.clipRect);
}