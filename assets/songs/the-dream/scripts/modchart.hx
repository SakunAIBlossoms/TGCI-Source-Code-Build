import funkin.backend.utils.WindowUtils;
function postCreate() {
    usecustomshowsongsprite = true;
    greyscale = new CustomShader("greyscale");
    CRT = new CustomShader("CRT");
    if (!FlxG.save.data.noshaders) {
        camGame.addShader(CRT);
        camHUD.addShader(CRT);
    }
    camHUD.addShader(greyscale);
    camGame.addShader(greyscale);
    endtext = new FunkinSprite(0,0,Paths.image("stages/costume/endtext"));
    endtext.screenCenter(0x11);
    endtext.cameras = [camHUD];
    endtext.alpha = 0;
    add(endtext);
}
function update() {
    if (CRT != null) CRT.iTime = Conductor.songPosition;
}
function stepHit(curStep:Int) {
    switch (curStep) {
        case 1:
            for (strum in playerStrums) strum.visible = false;
            for (strum in cpuStrums) strum.visible = false;
            toggleHUD();
    }
}
function beatHit(curBeat:Int) {
    switch(curBeat) {
        case 32:
            toggleHUD();
            for (strum in playerStrums) strum.visible = true;
            for (strum in cpuStrums) strum.visible = true;
        case 369:
            // wahooo!
            for (strum in cpuStrums) strum.x -= 800;
            FlxTween.tween(playerStrums.members[0], {x: playerStrums.members[0].x - 650}, 1.5, {ease: FlxEase.expoInOut});
            FlxTween.tween(playerStrums.members[1], {x: playerStrums.members[1].x - 650}, 1.5, {ease: FlxEase.expoInOut});
    }
}
function onEvent(e) {
    if (e.event.name == "showsong") {
        params = e.event.params;
        show = params[0];
        if (show) {
            WindowUtils.winTitle = "Friday Night Funkin': This GC's Insanity | " + PlayState.SONG.meta.displayName + params[2] + " | " + params[1];
            showEvent();
            trace("\nThe song is: " + PlayState.SONG.meta.displayName + "\non act: " + params[2] + "\nwith the description: " + params[1]);
        }
        if (!show) hideEvent();
    }
}
function showEvent() {
    endtext.y -= 30;
    FlxTween.tween(endtext, {alpha: 1, y: endtext.y + 30}, 0.5, {ease: FlxEase.cubeOut});
}

function hideEvent() {
    FlxTween.tween(endtext, {alpha: 0, y: endtext.y - 30}, 0.5, {ease: FlxEase.cubeOut});
}