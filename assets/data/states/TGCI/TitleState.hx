// {IMPORTS}
import funkin.menus.TitleState;
import funkin.menus.MainMenuState;
import funkin.backend.system.framerate.Framerate;
import flixel.effects.FlxFlicker;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;
import funkin.backend.system.Controls;
import funkin.backend.utils.CoolUtil;
import funkin.backend.system.Control;
import openfl.filters.BitmapFilter;
import openfl.filters.ShaderFilter;
import flixel.util.FlxAxes;
import openfl.Lib;
import Sys;

// {VARIABLES}
var curtains:FlxSprite;
var dumbass1:FlxSprite;
var dumbass2:FlxSprite;
var logo:FlxSprite;
var itsafuckingFLOOR:FlxSprite;
var hand:FlxSprite;
var camFollow:FlxObject;
var mouse:FlxSprite;
var blackSprite:FlxSprite;
var _static:FlxSprite;
var bottomGroup:FlxSpriteGroup;
var staticshit:CustomShader;
var ntsc:CustomShader;
var bloom:CustomShader;
var nogore:Bool = FlxG.save.data.removegore;
var handShaders:Array<CustomShader> = [];
var hands:Array<FlxSprite> = [];
var transitioning:Bool = false;
var oldwindowwidth:Int = 1280;
var oldwindowheight:Int = 720;

function create() {
    FlxG.camera.alpha = 0;
    CoolUtil.playMenuSong(true);
    mouse = new FlxSprite().loadGraphic(Paths.image('cursor'));
	FlxG.mouse.load(mouse.pixels, 2);
    FlxG.resizeWindow(800, 600);
    Lib.application.window.fullscreen = false;
    Lib.application.window.resizable = false;
	FlxG.camera.shake(0.000005, 999999999999);
    
    blackSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
	blackSprite.updateHitbox();
	blackSprite.screenCenter();

	_static = new FlxSprite(0,-350);
	_static.frames = Paths.getSparrowAtlas('menus/estatica_uwu');
	_static.animation.addByPrefix('idle', "Estatica papu", 15);
	_static.animation.play('idle');
	_static.alpha = 0.33;
	_static.cameras = [FlxG.camera];
	_static.color = FlxColor.RED;
	_static.screenCenter();
	add(_static);

	bottomGroup = new FlxSpriteGroup();
	bottomGroup.cameras = [FlxG.camera];
	add(bottomGroup);

    itsafuckingFLOOR = new FlxSprite(0, 0).loadGraphic(Paths.image('/menus/title/floor'));
	itsafuckingFLOOR.scale.set(0.95, 0.95);
	itsafuckingFLOOR.updateHitbox();
    itsafuckingFLOOR.antialiasing = FlxG.save.data.antialiasing;
	itsafuckingFLOOR.setPosition(-40.0567375886525, 360); // bros being specific
	bottomGroup.add(itsafuckingFLOOR);


    for (i in 0...2) {
        var hand:FlxSprite = new FlxSprite(96 + (601 * i), 125);
        hand.frames = Paths.getSparrowAtlas("/menus/title/titleAssets");
        hand.animation.addByPrefix("idle", "Spookihand", 24, true);
        hand.animation.play("idle", true);
        hand.antialiasing = FlxG.save.data.antialiasing;
        hand.scale.set(0.75, 0.75);
        hand.updateHitbox();
        bottomGroup.add(hand);
        hand.shader = new CustomShader("NTSCGlitch");
        hand.flipX = i == 1; // WHAT NO WAY!!

        hand.ID = i;
        hands.push(hand);
    }

	dumbass1 = new FlxSprite(303, 312);
	dumbass1.frames = Paths.getSparrowAtlas("/menus/title/titleAssets");
	dumbass1.animation.addByPrefix("idle", "BF", 24, false);
	dumbass1.animation.play("idle", true);
	dumbass1.scale.set(0.75, 0.75);
	dumbass1.updateHitbox();
    dumbass1.antialiasing = FlxG.save.data.antialiasing;
	bottomGroup.add(dumbass1);

	dumbass2 = new FlxSprite(705, 230);
	dumbass2.frames = Paths.getSparrowAtlas("/menus/title/titleAssets");
	dumbass2.animation.addByPrefix("idle", "GF", 24, false);
	dumbass2.animation.play("idle", true);
	dumbass2.scale.set(0.75, 0.75);
    dumbass2.antialiasing = FlxG.save.data.antialiasing;
	dumbass2.updateHitbox();
	bottomGroup.add(dumbass2);

    staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3]; 
    FlxG.camera.addShader(staticshit);

    //bloom = new CustomShader("Bloom");
	//bloom.data.Size.value = [0.2];
    FlxG.camera.zoom = 1.3;

    if (nogore) {
        logo = new FlxSprite(0, 60).loadGraphic(Paths.image('zseven'));
    }
    else {
        logo = new FlxSprite(0, 60).loadGraphic(Paths.image('menus/title/logo'));
    }
	logo.setGraphicSize(Std.int(logo.width * (0.295 * 0.9)));
    logo.antialiasing = FlxG.save.data.antialiasing;
	logo.updateHitbox();
	logo.screenCenter(FlxAxes.x);
    logo.y = 60;
	add(logo);

	enterSprite = new FlxSprite(0, 560);
	enterSprite.frames = Paths.getSparrowAtlas("menus/title/enter");
	enterSprite.animation.addByPrefix("idle", "EnterLoop", 24, false);
	enterSprite.animation.addByPrefix("press", "EnterBegin", 24, false);
	enterSprite.animation.play("idle");
    enterSprite.antialiasing = FlxG.save.data.antialiasing;
	enterSprite.updateHitbox();
	enterSprite.screenCenter(FlxAxes.x);
    enterSprite.y = 560;
	enterSprite.x -= 2;
	add(enterSprite);

	curtain = new FlxSprite().loadGraphic(Paths.image('menus/title/duh'));
	curtain.scale.set(1.289 * 0.9, 1.286 * 0.9);
	curtain.updateHitbox();
	curtain.screenCenter();
	curtain.y = -682.501606766917 * 0.25;
    curtain.antialiasing = FlxG.save.data.antialiasing;
	add(curtain);
    add(blackSprite);
    //ntsc = new CustomShader("NTSCSFilter");
    //FlxG.camera.addShader(ntsc);
    FlxTween.tween(FlxG.camera, {alpha: 1}, 1.4, {ease: FlxEase.backIn});
    (new FlxTimer()).start(Conductor.stepCrochet/1000 * 2, (_) -> {
        FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
        FlxG.sound.music.fadeIn((Conductor.stepCrochet/1000 * 16) * 2, 0, 1.2);

        FlxTween.tween(blackSprite, {alpha: 0}, Conductor.stepCrochet/1000 * 6, {onComplete: (_) -> {
            transitioning = false;

            blackSprite.alpha = 0.05;
            FlxFlicker.flicker(blackSprite, 999999999999);
        }});
        
        FlxTween.tween(curtain, {y: -682.501606766917}, Conductor.stepCrochet/1000 * 4, {ease: FlxEase.circOut, startDelay: (Conductor.stepCrochet/1000) / 8});
        //FlxG.camera.zoom += 0.075;
        FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom - 0.075}, (Conductor.stepCrochet/1000 * 12), {ease: FlxEase.circOut});

        persistentUpdate = true;
    });
}
function postCreate() {
    if (!FlxG.save.data.hasdonefirsttimesetup) FlxG.switchState(new ModState("TGCI/FirstTimeSetup"));
}
function update(elapsed:Float) {
    if (Framerate.debugMode > 0)
        Framerate.debugMode = 0;
    if (FlxG.sound.music != null)
        Conductor.songPosition = FlxG.sound.music.time;
    var currentBeat = (Conductor.songPosition / 1000) * (Conductor.bpm / 60);
    if (ntsc != null)
        ntsc.data.uFrame.value = [Conductor.songPosition];

    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];

    //if (bloom != null && !transitioning) {
    //    bloom.data.Size.value = [0.4 + (0.01 * FlxMath.fastSin(currentBeat * 2))];
    //}

    for (shader in handShaders)
        shader.data.time.value = [Conductor.songPosition];

    if (logo != null) 
        logo.y = 60 + 7.5 * FlxMath.fastCos((currentBeat / 3.) * Math.PI);
    if (FlxG.keys.justPressed.NINE) window.alert("Welcome to my world "+getplayerusername(),"Hello."); 
    if (controls.ACCEPT && !transitioning) {
         
    	transitioning = true;
    
    	//if (titleText != null)
    	//	titleText.animation.play('press');
    	if (FlxG.save.data.gameplayShaders == true) {
    		if (FlxG.save.data.flashingMenu && bloom != null) {
    			bloom.data.Size.value = [18 * 2];
    			bloom.data.dim.value = [0.25];
    			var twn1:NumTween;
    			var twn2:NumTween;
    			twn1 = FlxTween.num(18.0 * 2, 3.0, 1.5, {
    				onUpdate: (_) -> {
    					bloom.data.Size.value = [twn1.value];
    				}
    			});
    			twn2 = FlxTween.num(0.25, 2.0, 1.5, {
    				onUpdate: (_) -> {
    					bloom.data.dim.value = [twn2.value];
    				}
    			});
                
    		}
    	}
        for (obj in [FlxG.camera, curtain, blackSprite])
            FlxTween.cancelTweensOf(obj);

        FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.075}, Conductor.stepCrochet/1000 * 4, {ease: FlxEase.circOut});
        FlxG.sound.play(Paths.sound('menu/confirm'));

        enterSprite.offset.set(127, 85);
        enterSprite.animation.play("press", true);

        enterSprite.animation.finishCallback = (_) -> {enterSprite.visible = false;};

        new FlxTimer().start(Conductor.stepCrochet/1000 * 2, function(tmr:FlxTimer) {
            FlxTween.tween(curtain, {y: curtain.y - 40}, (Conductor.stepCrochet/1000), {
                ease: FlxEase.circInOut,
                onComplete: (_) -> {
                    FlxTween.tween(curtain, {y: 3}, Conductor.stepCrochet/1000 * 4.6, {ease: FlxEase.quintOut, startDelay: 0.03});

                    FlxFlicker.stopFlickering(blackSprite); 
                    blackSprite.alpha = 0; blackSprite.visible = true;

                    FlxTween.tween(blackSprite, {alpha: 1}, Conductor.stepCrochet/1000 * 2, {
                        startDelay: 0.04,
                        onComplete: (_) -> {
                            FlxTween.tween(window, {width: 1280, height: 720}, 0.3*4, {ease:FlxEase.circInOut, onComplete: function(twn:FlxTween){ completeWindowTwn();}});
                            FlxG.camera.visible = false;
                        }
                    });
                    
                }
            });
        });
    }
    if (controls.ACCEPT) {
        
        //FlxG.switchState(new MainMenuState()); 
    }
}

override function stepHit(curStep:Float) {

    if (enterSprite != null && curStep % 8 == 0 && enterSprite.animation.name != "press")
        enterSprite.animation.play("idle", true);

    if (dumbass1 != null && curStep % 4 == 0)
        dumbass1.animation.play("idle", true);

    if (dumbass2 != null && curStep % 4 == 0)
        dumbass2.animation.play("idle", true);

    if (curStep % 4 == 0) {
        for (hand in hands) {
            if (hand != null)
                hand.animation.play("idle");
        }
    }

    if (curStep % 8 == 0) {
        for (shader in handShaders) {
            FlxTween.cancelTweensOf(shader);
            
            FlxTween.num(FlxG.random.float(1, 2), 0.5, (Conductor.stepCrochet / 1000) * 6, {onUpdate: (_:FlxTween) -> {
                shader.setGlitch(cast(_, NumTween).value);
            }});
        }
    }
}
function completeWindowTwn(){
    FlxG.resizeWindow(1280, 720);
    FlxG.mouse.visible = true;
    FlxG.switchState(new MainMenuState());
}
function destroy() {
    FlxG.resizeWindow(1280, 720);
}