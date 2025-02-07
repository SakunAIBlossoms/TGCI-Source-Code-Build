
var ongoing:Bool = false;
var fakeCam:FlxCamera = new FlxCamera();
function postCreate() {
    fakeCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(fakeCam, false);
    
    dad.alpha = 0;
    camHUD.alpha = 0;

    gradient = new FlxSprite(60, 150).loadGraphic(Paths.image('stages/afmbar/behind/gradient'));
    gradient.scale.set(1.5, 1.5);
    add(gradient);
    gradient.antialiasing = false;

    //bg 1 lol
    sparkles = new FlxSprite(206 - 50, 273 - 50);
    sparkles.frames = Paths.getSparrowAtlas('stages/afmbar/sparkle');
    sparkles.animation.addByPrefix('sparkle','sparkle',30);
    sparkles.animation.play('sparkle', true);
    sparkles.visible = false;
    add(sparkles);
    rainback = new FlxSprite(front.getMidpoint().x - 350, 60);
    rainback.frames = Paths.getSparrowAtlas('stages/afmbar/rain');
    rainback.animation.addByPrefix('rain','rain',30);
    rainback.animation.play('rain', true);
    rainback.scale.set(1.25, 1.25);
    rainback.updateHitbox(); 
    rainback.alpha = 0;
    rainback.blend = "add";
    add(rainback);
    spotlight1 = new FlxSprite(145, -15).loadGraphic(Paths.image('stages/afmbar/spotlight'));
    spotlight1.blend = "add";
    spotlight1.updateHitbox();
    add(spotlight1);
    spotlight1.antialiasing = false;
    spotlight2 = new FlxSprite(464, -15).loadGraphic(Paths.image('stages/afmbar/spotlight'));
    spotlight2.blend = "add";
    spotlight2.updateHitbox();
    spotlight1.alpha = 0;
    spotlight2.alpha = 0.3;
    spotlight2.visible = false;
    add(spotlight2);
    spotlight2.antialiasing = false;
    // this goes on the ABSOLUTE TOP
    rain = new FlxSprite(front.getMidpoint().x - 500, 60);
    rain.frames = Paths.getSparrowAtlas('stages/afmbar/rain');
    rain.animation.addByPrefix('rain','rain',30);
    rain.animation.play('rain', true);
    rain.scale.set(1.5, 1.5);
    rain.updateHitbox();
    rain.alpha = 0;
    rain.blend = "add";
    rain.scrollFactor.set(1.3, 1.3);
    add(rain);

    blackScreen = new FlxSprite(-200, -200).makeSolid(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
	blackScreen.scrollFactor.set();
    insert(members.indexOf(boyfriend)+1, blackScreen);
    add(gf);
    add(dad);
    add(boyfriend);
}
function onSongStart() {
    FlxTween.tween(dad, {alpha: 1}, 5, {ease: FlxEase.cubeIn});
    FlxTween.tween(trees, {alpha: 1}, 5, {ease: FlxEase.cubeIn});
    FlxTween.tween(rainback, {alpha: 0.15}, 5, {ease: FlxEase.cubeIn});
    FlxTween.tween(rain, {alpha: 0.4}, 5, {ease: FlxEase.cubeIn});
    FlxTween.tween(blackScreen, {alpha: 0}, 10, {ease: FlxEase.cubeIn});
    FlxTween.tween(camHUD, {alpha: 1}, 12, {ease: FlxEase.cubeIn});
    camFollow.setPosition(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y - 30);
    ongoing = true;
    FlxTween.tween(FlxG.camera, {zoom: 2.5}, 12.5, {ease: FlxEase.sineInOut, onComplete:
        function (twn:FlxTween)
        {
            FlxTween.cancelTweensOf(FlxG.camera, ['zoom']);
            FlxG.camera.zoom = 3.5;
            defaultCamZoom = 3.5;
            ongoing = false;
            camFollow.setPosition(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);
            FlxG.camera.snapToTarget();
        }
    });
}
function postUpdate(elapsed:Float) {
    if (ongoing) {
        defaultCamZoom = FlxG.camera.zoom;
    }
    fakeCam.scroll.x = FlxG.camera.scroll.x;
    fakeCam.scroll.y = FlxG.camera.scroll.y;
    fakeCam.zoom = FlxG.camera.zoom;
}
function onDadHit(event) {
    if (event.noteType == 'Lime Sing'){
        //var animToPlay:String = singAnimations[Std.int(Math.abs(Math.min(singAnimations.length-1)))];
        //lime.playAnim(animToPlay + note.animSuffix, true);
        //lime.holdTimer = 0;
    }
    if (event.noteType == 'Grace Sing'){
        //var animToPlay:String = singAnimations[Std.int(Math.abs(Math.min(singAnimations.length-1, note.noteData)))];
        //grace.playAnim(animToPlay + note.animSuffix, true);
        //grace.holdTimer = 0;
    }
}
function stepHit(curStep:Int) {
    switch(curStep) {
        case 232:
            sparkles.visible = true;
        case 384:
            FlxG.sound.play(Paths.sound('songs/aftermidnight/spin'), 0.4);
            FlxTween.tween(FlxG.camera.flashSprite, {scaleX: -1}, 0.15, {type: 4, ease: FlxEase.cubeInOut, onComplete: (tw)->{
                if (tw.executions == 2) {
                    for (i in [trees, front, back]){
                        i.visible = false;
                    }
                }
                if (tw.executions == 4) {
                    tw.cancel();
                }
            }});
            camFollow.setPosition(backbg.getMidpoint().x, backbg.getMidpoint().y);
            camGame.snapToTarget();
        case 390:
            boyfriend.setPosition(320,100 + 500);
            boyfriend.cameras = [fakeCam];
            FlxTween.tween(boyfriend, {y: 165}, 1, {ease: FlxEase.quartInOut});
            gf.setPosition(340,100 + 500);
            gf.cameras = [fakeCam];
            FlxTween.tween(gf, {y: 210}, 1, {ease: FlxEase.quartInOut});
            rain.x += 150;
            rainback.x += 150;
            dad.cameras = [fakeCam];
            sparkles.cameras = [fakeCam];
            sparkles.scale.set(1.5, 1.5);
            sparkles.x -= 100;
            dad.setPosition(-110,100 + 500);
            FlxTween.tween(dad, {y: 160}, 1, {ease: FlxEase.quartInOut});
            defaultCamZoom = 1.8;
    }
}