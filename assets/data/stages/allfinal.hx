import openfl.Lib;
var act2WhiteFlash:FlxSprite;
var act1Fog:FlxSprite;
var bfscared:Bool = false;
var healthdrainshit = false;
function create() {
    // ACT 1 SPRITES
    act1Fog = new FlxSprite().loadGraphic(Paths.image('stages/allfinal/act1/act1'));
	act1Fog.cameras = [camHUD];
	act1Fog.visible = false;
    add(act1Fog);
    act2Stat.visible=false;
    act2WhiteFlash = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
	act2WhiteFlash.setGraphicSize(Std.int(act2Stat.width * 10));
	act2WhiteFlash.alpha = 0;
	add(act2WhiteFlash);
    staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3];  
    ntsc = new CustomShader("NTSCSFilter");
    abberation = new CustomShader("Abberation");
    abberation.data.aberrationAmount.value = [0.1];
    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
	blackBarThingie.alpha = 0;
	blackBarThingie.cameras = [camGame];
    add(blackBarThingie);
    introLength = 0;
    //act 3 haha
    act3BGGroup = new FlxTypedGroup();
	add(act3BGGroup);

	act3Stat = new FunkinSprite(-730 - 275, -720 + 440, Paths.image('stages/allfinal/act3/Act3_Static'));
    act3Stat.scrollFactor.set(0.2, 0.2);
	act3Stat.animation.addByPrefix('idle', 'act3stat', 24, true);
	act3Stat.animation.play('idle');
	act3Stat.scale.set(1.3, 1.3);
	act3BGGroup.add(act3Stat);

	act3Hills = new FunkinSprite(-730 - 275 + 300, 450, Paths.image('stages/allfinal/act3/Act3_Hills'));
    act3Hills.scrollFactor.set(0.4, 0.4);
	act3Hills.animation.addByPrefix('idle', 'hills', 24, true);
	act3Hills.animation.play('idle');
	act3Hills.scale.set(1.3, 1.3);
	act3BGGroup.add(act3Hills);
	/*
	act3UltraArm = new BGSprite('mario/allfinal/act3/Act3_Ultra_Arm', -900 - 275, -1215 + 440, 0.8, 0.8);
	act3UltraArm.origin.set(880, 1540);
	act3BGGroup.add(act3UltraArm);

	act3UltraBody = new BGSprite('mario/allfinal/act3/Act3_Ultra_M', -1185, -650 + 600, 0.8, 0.8, ['torso idle 1']);
	act3UltraBody.animation.addByPrefix('idle', 'torso idle 1', 24, false);
	act3UltraBody.animation.addByPrefix('change', 'torso change pose', 24, false);
	act3UltraBody.animation.addByPrefix('idle-alt', 'torso idle 2', 24, false);
	act3UltraBody.scale.set(1.4, 1.4);
	act3BGGroup.add(act3UltraBody);

	act3UltraHead1 = new BGSprite('mario/allfinal/act3/Act3_Ultra_M_Head', -200 - 275, -650 + 440, 0.8, 0.8, ['ultra m static head']);
	act3UltraHead1.animation.addByPrefix('idle', 'ultra m static head', 24, true);
	act3UltraHead1.animation.addByPrefix('sing', 'ultra m lyrics 1', 24, false);
	act3UltraHead1.animation.play('idle');
	act3UltraHead1.scale.set(1.1, 1.1);
	act3BGGroup.add(act3UltraHead1);

	act3UltraHead2 = new BGSprite('mario/allfinal/act3/Act3_Ultra_M_Head2', -200 - 300, -650 + 325, 0.8, 0.8, ['ultra m lyrics 1']);
	act3UltraHead2.animation.addByPrefix('sing', 'ultra m lyrics 2', 24, false);
	act3UltraHead2.animation.addByPrefix('laugh', 'ultra m head laugh', 24, false);
	act3BGGroup.add(act3UltraHead2);

	act3UltraPupils = new BGSprite('mario/allfinal/act3/Act3_Ultra_Pupils', -175, -300 + 405, 0.8, 0.8, ['ultra pupils']);
	act3UltraPupils.animation.addByPrefix('idle', 'ultra pupils', 24, true);
	act3UltraPupils.animation.play('idle');
	act3BGGroup.add(act3UltraPupils);

	act3BFPipe = new BGSprite('mario/allfinal/act3/Act3_bfpipe', 390 - 275, 165 + 440, 1, 1);
	act3BGGroup.add(act3BFPipe);

	act3Spotlight = new BGSprite('mario/allfinal/act3/act3Spotlight', -1550, -300, 1, 1);
	act3Spotlight.scale.set(1.3, 1);
	act3Spotlight.visible = false;

	act3Fog = new BGSprite('mario/allfinal/act3/act3', 0, 0, 1, 1);
	act3Fog.alpha = 0.7;
	act3Fog.cameras = [camOther];
	act3BGGroup.add(act3Fog);
    */
	act3BGGroup.visible = false;

}
function postCreate() {
    
}
function onNoteHit(event) {
}
function onDadHit(event) {
    if (healthdrainshit && health < 0.1) health -= 0.05;
}
function update() {
    if (ntsc != null)
        ntsc.data.uFrame.value = [Conductor.songPosition];
    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];
    iconP1.y = healthBar.y - 70;
    iconP2.y = healthBar.y - 70;
}
function stepHit(curStep:Int) {
    if (curSong == 'endgame') {
        switch(curStep) {
            case 2448: 
                flydownHUD();
                
            case 2515: returnHUD(0);
        }        
    }
    if (curSong == 'all-stars') {
        switch(curStep) {
            case 2224: 
                flydownHUD();
            case 2252:
                for (strum in playerStrums) strum.y += 800;
                for (strum in cpuStrums) strum.y += 800;
                for (healthshit in [healthBar, healthOverlay]) healthshit.y += 200;
                dad.x = -1400;
				dad.y = -1310;
                dad.scrollFactor.set(1, 1);
            case 2272:
                returnHUD(0);
                //FlxTween.tween(dad, {y: dad.y + 900}, 1.6, {ease: FlxEase.quadInOut});
                for (strum in cpuStrums) FlxTween.tween(strum, {y: strum.y - 800}, 1.2, {ease: FlxEase.expoOut});
            case 2395:
                for (strum in playerStrums) FlxTween.tween(strum, {y: strum.y - 800}, 0.7, {ease: FlxEase.expoOut});
                healthdrainshit = true;
            case 2968:
                for (healthshit in [healthBar, healthOverlay]) {
                    healthshit.visible = true;
                    FlxTween.tween(healthshit, {y: healthshit.y - 200}, 0.6, {ease: FlxEase.quartOut});
                }
                for (icons in [iconP1, iconP2])icons.visible = true;
            case 3492:
                camGame.removeShader(staticshit);
                camGame.removeShader(ntsc);
                camGame.removeShader(abberation);
                camHUD.removeShader(ntsc);
        }
    }
}
static function flydownHUD() {
    FlxTween.tween(blackBarThingie, {alpha: 1}, 0.8, {ease: FlxEase.quadInOut});
    FlxTween.tween(camHUD, {alpha: 0}, 3.6, {ease: FlxEase.quadInOut});
    FlxTween.tween(camHUD, {angle: 15}, 3.6, {ease: FlxEase.quadIn});
    FlxTween.tween(camHUD, {y: 500}, 3.6, {ease: FlxEase.quadIn});
    trace("bai bai hud!");
}
static function returnHUD(type:Int) {
    FlxTween.tween(blackBarThingie, {alpha: 0}, 0.4, {ease: FlxEase.quadInOut});
    switch(type) {
        case 0:
            camHUD.alpha = 1;
            camHUD.angle = 0;
            camHUD.y = 0;
        case 1:
            FlxTween.tween(camHUD, {alpha: 1}, 0.6, {ease: FlxEase.quadInOut});
            FlxTween.tween(camHUD, {angle: 0}, 0.6, {ease: FlxEase.backOut});
            FlxTween.tween(camHUD, {y: 0}, 0.6, {ease: FlxEase.backOut});
    }
}
function changeAct(actshit:String) {
    var newAct:Int = Std.int(actshit);
    // update i learnt what for loops are and i wanna cry now
    switch(newAct) {
        case 2:
            for (sprites in [act1Fog,act1Stat,act1Sky,act1Skyline,act1Buildings,act1Floor,act1FG,act1Gradient]) sprites.destroy(); for (newsprites in [act2Stat]) newsprites.visible = true; gf.visible = false;
        case 3:
            for (sprites in [act2Stat]) sprites.visible = false;
            act3BGGroup.visible = false;
            dad.visible = true;
            camGame.addShader(staticshit);
            camGame.addShader(ntsc);
            camHUD.addShader(ntsc);
            camGame.addShader(abberation);
            toggleHUD();
        case 4:
            trace("act 4 lmao (none of this exists im lazy)");
    }
}