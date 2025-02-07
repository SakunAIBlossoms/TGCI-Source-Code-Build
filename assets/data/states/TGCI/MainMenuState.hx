import funkin.menus.ModSwitchMenu;
import funkin.menus.TitleState;
import funkin.editors.EditorPicker;

import funkin.options.OptionsMenu;
import funkin.backend.utils.WindowUtils;
import funkin.backend.utils.DiscordUtil;

import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;

import openfl.Lib;

var menuSprites:Array<FlxSprite> = [];
var menuStates:Array<FlxState> = [];
function create() {
	FlxG.resizeWindow(1280, 720);
    FlxG.resizeGame(1280, 720);
	FlxG.mouse.visible = true;
	WindowUtils.winTitle = "Friday Night Funkin': This GC's Insanity";
	CoolUtil.playMenuSong(false);

	var bg = new FlxBackdrop(Paths.image('menus/mainmenu/bgs/bg0'));
	bg.velocity.x = -40;
	bg.antialiasing = false;
	bg.screenCenter();
	bg.scale.set(4, 4);
	add(bg);

	var estatica = new FlxSprite();
	estatica.frames = Paths.getSparrowAtlas('menus/estatica_uwu');
	estatica.animation.addByPrefix('idle', "Estatica papu", 15);
	estatica.animation.play('idle');
	estatica.color = FlxColor.RED;
	estatica.alpha = 0.7;
	estatica.scrollFactor.set();
	estatica.updateHitbox();
	add(estatica);

    //top
	makeMenuSpr("MainGame", 200, 140, new ModState("TGCI/StoryMenuState"));
    makeMenuSpr("WarpZone", 500, 140);
	makeMenuSpr("Freeplay", 800, 140, new FreeplayState());

    //bottom
    makeMenuSpr("Options", 220, 450, new OptionsMenu());
    makeMenuSpr("Credits", 650, 450, new ModState("TGCI/CreditState"));

    //etc
    makeMenuSpr("Patch", 690, 10, new ModState("TGCI/patchnotes"));

	playerIcon = new FlxSprite(20,FlxG.height - 180).loadGraphic(getplayerpfp());
	//if (playerIcon.graphic == null) playerIcon.loadGraphic(Paths.image("menus/mainmenu/Person"));
	playerIcon.alpha = 0.7;
	playerIcon.shader = new CustomShader("circleProfilePicture");
	add(playerIcon);

	staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3]; 
	if (!FlxG.save.data.noshaders) {
		FlxG.camera.addShader(staticshit);
    }
    Lib.application.window.resizable = true;
	blackSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    blackSprite.alpha = 0.05;
    FlxFlicker.flicker(blackSprite, 999999999999);
    add(blackSprite);
}
	var fullTimer:Float = 0;
function update(elapsed:Float) {
    fullTimer += elapsed;

	FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.015, (1/30)*240*elapsed);
	FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.015, (1/30)*240*elapsed);

	FlxG.camera.shake(0.00025, 999999999999);

    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];
	
	if (FlxG.mouse.overlaps(playerIcon)) {
		playerIcon.alpha = 1;
		if (FlxG.mouse.justPressed) {
			openSubState(new ModSubState("TGCI/substates/PlayerStats"));
        	persistentUpdate = false;
        	persistentDraw = true;
		}
	}
	else if (!FlxG.mouse.overlaps(playerIcon)) playerIcon.alpha = 0.7;
    if (FlxG.keys.justPressed.SEVEN) {
		openSubState(new EditorPicker());
        persistentUpdate = false;
        persistentDraw = true;
    }

	if (FlxG.keys.justPressed.EIGHT) {
		FlxG.switchState(new ModState(runSaveDataCheck(0)));
    }

	if (controls.BACK)
	{
		beginwindowtwn();
		CoolUtil.playMenuSFX(2, 10);
	}

    for (spr in menuSprites) {
        if (FlxG.mouse.overlaps(spr)) {
            spr.animation.play("select");

            if (FlxG.mouse.justPressed)
                FlxG.switchState(menuStates[spr.ID]);
        } else
            spr.animation.play("idle");
    }
}
function goToTitle() {
	FlxG.switchState(new TitleState());
}
function beginwindowtwn() {
	FlxTween.tween(FlxG.camera, {alpha: 0}, 0.3, {ease:FlxEase.circOut});
	FlxTween.tween(window, {width: 800, height: 600}, 0.3*4, {ease:FlxEase.circInOut, onComplete: function(twn:FlxTween){ 
		completeWindowTwn();
	}});
}
function completeWindowTwn() {
	FlxG.resizeWindow(800, 600);
    FlxG.resizeGame(800, 600);
	goToTitle();
}
function makeMenuSpr(animName:String = "", x:Float = 0, y:Float = 0, state:FlxState = new MainMenuState()) {
	var menuSpr = new FlxSprite(x, y);
	menuSpr.frames = Paths.getSparrowAtlas("menus/mainmenu/MM_Menu_Assets");
	menuSpr.animation.addByPrefix("idle", animName + "Normal");
	menuSpr.animation.addByPrefix("select", animName + "Selected");
	menuSpr.animation.play("idle");
	menuSpr.scrollFactor(1,1);
    menuSpr.updateHitbox();
    menuSpr.ID = menuSprites.length;
	menuSprites.push(menuSpr);
    menuStates.push(state);
	add(menuSpr);
}
function destroy() {
}