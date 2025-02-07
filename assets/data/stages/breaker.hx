var coolCamLmao;
var glitchynotesshaders = false;
function create() {
    introLength = 0;
}
function postCreate() {
    glitch = new CustomShader("pingbreaker/glitch");

	for (i => strum in cpuStrums.members) {
		strum.scrollFactor.set(0.1);
        strum.setPosition(0, i * 120);
        strum.angle = -90;
        strum.cameras = [camGame];    
    }

    coolCamLmao = new FlxCamera(0,-130,camGame.width,camGame.height * 2,camGame.zoom);
    coolCamLmao.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(coolCamLmao, false);
    FlxG.cameras.add(camHUD, false);

    for (stupid in [dad, boyfriend, floor, floor1, light])
        stupid.cameras = [coolCamLmao];
}
function onNoteCreation(event) {
        if (glitchynotesshaders)
            event.note.shader = glitch;
}
function changeStage(newStage:String) {
    if (newStage == "normal") {
        for (i => strum in cpuStrums.members) {
            strum.scrollFactor.set(0.1);
            strum.setPosition(0, i * 120);
            strum.angle = -90;
            strum.cameras = [camGame];
        }
    }
    if (newStage == "evil") {
        floor.visible = false;
        floor1.visible = true;
    }
    if (newStage == "underwater") {
        floor.visible = false;
        floor1.visible = false;
        light.visible = false;
        trees.visible = false;
        mt.visible = false;
        sky.visible = false;
        for (i => strum in cpuStrums.members) {
            strum.scrollFactor.set(0.1);
            strum.setPosition(i * 120, 0);
            //strum.setPosition(0, i * 120);
            strum.scale.set(2,2);
            strum.updateHitbox();
            strum.angle = -180;
            strum.cameras = [camGame];    
        }
        for (cameras in [camGame, coolCamLmao]) {
            cameras.zoom = 0.7;
        }
    }
}
function stepHit(curStep:Int) {
    if (curStep == 580) {
        glitchynotesshaders = true;
        dad.shader = glitch;
    }
    if (curStep == 1374) {
        camHUD.alpha = 0;
        coolCamLmao.alpha = 0;
        camGame.alpha = 0;
    }
    if (curStep == 1423) {
        FlxTween.tween(camHUD, {alpha: 1}, 7);
        FlxTween.tween(coolCamLmao, {alpha: 1}, 7);
        FlxTween.tween(camGame, {alpha: 1}, 7);
    }
}
function update() {
    for (chars in [dad, boyfriend]) {
        if (chars.cameras != [coolCamLmao]) {
            chars.cameras = [coolCamLmao];
        }
    }
    if (glitch != null)
        glitch.data.iTime.value = [Conductor.songPosition];

    coolCamLmao.zoom = camGame.zoom;
    coolCamLmao.scroll.x = camGame.scroll.x;
    coolCamLmao.scroll.y = camGame.scroll.y;
}