// {IMPORTS}
import funkin.menus.MainMenuState;
import flixel.effects.FlxFlicker;
import flixel.FlxObject;
import funkin.game.cutscenes.VideoCutscene;
// {VARIABLES}

// Sprites
var hangedbitches:FlxSprite;
var bg:FlxSprite;
var begin:FlxSprite;
var hahaoptions:FlxSprite;
var selectionhighlight:FlxSprite;
var sexyvignette:FlxSprite;
var flicker:FlxSprite;
var blackBarThingie:FlxSprite;
var alpOp:FlxSprite;
var grpCut:FlxTypedGroup<FlxSprite>;
var opUp:FlxObject;
var opDown:FlxObject;
var vid:VideoSprite;

// Integers
var opNum:Int = 0;

// Text
var songsText:FlxText;
var titleText:FlxText;
var startText:FlxText;
var cutText:FlxText;

// Arrays
var cutscenes:Array<String> = ['Itsame_cutscene', 'ss_cutscene', 'post_ss_cutscene', 'ihy_cutscene', 'overdue_cutscn', 'demise_cutscene_SOUND', 'promocut', 'abandoncut'];

// Booleans
var quieto:Bool = true;
var nosuicide:Bool = FlxG.save.data.nosuicide;

// Tweens
var dumbTween:FlxTween;
var dumbTween2:FlxTween;

// Shaders
var staticshit:CustomShader;

function create() {
    FlxG.camera.zoom = 1;
    // Find an alternative to these that actually works thx
    //MainMenuState.instance.lerpCamZoom = true;
    //MainMenuState.instance.camZoomMulti = 0.94;

    var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);

    bg = new FlxSprite().loadGraphic(Paths.image('menus/storymode/bg1'));
    bg.scale.set(1.15, 1.15);
	bg.updateHitbox();
	bg.screenCenter();
	bg.alpha = 0;
    add(bg);
    

    // they fuckin dead
    if (nosuicide) {
        hangedbitches = new FlxSprite().loadGraphic(Paths.image('menus/storymode/oldbg2'));
    }
    else if (!nosuicide) {
        hangedbitches = new FlxSprite().loadGraphic(Paths.image('menus/storymode/bg2'));
    }
    hangedbitches.updateHitbox();
    hangedbitches.setPosition(750, 0);
    hangedbitches.scrollFactor.set(0.5, 0.5);
    hangedbitches.alpha = 0;
    hangedbitches.origin.set(hangedbitches.width/2, 0);
    hangedbitchesShader = new CustomShader("NTSCGlitch");
    hangedbitchesShader.data.glitchAmount.value = [5];
    if (!FlxG.save.data.noshaders) {
        hangedbitches.shader = hangedbitchesShader;
    }
    add(hangedbitches);
    //dumbTween = FlxTween.num(2.0, 0.8, 4, {ease: FlxEase.expoOut}, (v:Float) -> {MainMenuState.instance.bloom.dim.value = [v];});

    selectionhighlight = new FlxSprite().loadGraphic(Paths.image('menus/storymode/barraselect'));
	selectionhighlight.updateHitbox();
	selectionhighlight.setPosition(-2000, 220);
	selectionhighlight.scrollFactor.set(1.2, 1.2);
	add(selectionhighlight);

    hahaoptions = new FlxSprite().loadGraphic(Paths.image('menus/storymode/text1'));
	hahaoptions.updateHitbox();
	hahaoptions.setPosition(-50, 200);
	hahaoptions.scrollFactor.set(1.2, 1.2);
	hahaoptions.alpha = 0;
	hahaoptions.y += 20;
	add(hahaoptions);

    startText = new FlxText(700, 600, 500, "Press Enter to Begin", 32);
	startText.setFormat(Paths.font("mariones.ttf"), 24, FlxColor.RED, "CENTER");
	startText.scrollFactor.set(1, 1);
	startText.updateHitbox();
	add(startText);

    sexyvignette = new FlxSprite().loadGraphic(Paths.image('menus/storymode/black_vignette'));
	sexyvignette.scrollFactor.set(0, 0);
	sexyvignette.updateHitbox();
	sexyvignette.alpha = 0;
	add(sexyvignette);

    songsText = new FlxText(650, 0, 400, "vs. Delta Z", 32);
    songsText.setFormat(Paths.font("mariones.ttf"), 16, FlxColor.RED, "LEFT");
    songsText.scrollFactor.set(1, 1);
    songsText.updateHitbox();
    add(songsText);

    titleText = new FlxText(920, 0, 400, "Includes\n?????\n?????\n?????", 32);
    titleText.setFormat(Paths.font("mariones.ttf"), 16, FlxColor.RED, "RIGHT");
    titleText.scrollFactor.set(1, 1);
    titleText.updateHitbox();
    add(titleText);

    cutText = new FlxText(800, 0, 400, "CUTSCENES", 32);
	cutText.setFormat(Paths.font("mariones.ttf"), 32, FlxColor.RED, "CENTER");
	cutText.scrollFactor.set(1, 1);
	cutText.updateHitbox();
	cutText.visible = false;
	add(cutText);

    grpCut = new FlxTypedGroup();
	grpCut.visible = false;
	add(grpCut);
    
    for (i in 0...cutscenes.length)
        {
            var imageCut:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/storymode/cutscenes/' + (i + 1)));
            imageCut.updateHitbox();
            imageCut.ID = i;

            //if(cutReq[i])grpCut.add(imageCut);
            grpCut.add(imageCut);
            imageCut.y += 100 + (150 * i);
            imageCut.x += 750; 
            if(i >= 4){
                imageCut.y -= (150 * 4);
                imageCut.x += 250;
            }

        }
    
    staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3]; 
	dumbTween2 = FlxTween.num(0, 0.5, 4, {ease: FlxEase.expoOut}, (v:Float) -> {staticshit.data.strengthMulti.value = [v];});

    glitchShit = new CustomShader("NTSCGlitch");
	glitchShit.data.glitchAmount.value = [0.5];
    if (!FlxG.save.data.noshaders) {
        FlxG.camera.addShader(staticshit);
        FlxG.camera.addShader(glitchShit);
    }

    opUp = new FlxObject(hahaoptions.x, hahaoptions.y + 10, hahaoptions.width, Std.int(hahaoptions.height / 2));
	opUp.scrollFactor.set(1.2, 1.2);
	add(opUp);

	opDown = new FlxObject(hahaoptions.x, hahaoptions.y + 10 + Std.int(hahaoptions.height / 2), hahaoptions.width, Std.int(hahaoptions.height / 2));
	opDown.scrollFactor.set(1.2, 1.2);
	add(opDown);

    flicker = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
    flicker.scrollFactor.set(0, 0);
    flicker.updateHitbox();
    flicker.alpha = 0.1;
    add(flicker);

    alpOp = new FlxSprite().makeGraphic(Std.int(hahaoptions.width), Std.int(hahaoptions.height / 2), FlxColor.BLACK);
	alpOp.updateHitbox();
	alpOp.setPosition(0, hahaoptions.y + Std.int(hahaoptions.height / 2));
	alpOp.scrollFactor.set(1.2, 1.2);
	alpOp.alpha = 0;
	add(alpOp);

    // haha tweens at start go BRRRRR
    FlxFlicker.flicker(flicker, 999999999999);

    FlxTween.tween(hangedbitches, {alpha: 1, y: 50}, 4, {ease: FlxEase.expoOut});
	FlxTween.tween(bg, {alpha: 1}, 4, {ease: FlxEase.expoOut});
    FlxTween.tween(sexyvignette, {alpha: .4}, 4, {ease: FlxEase.expoOut});
    FlxTween.tween(songsText, {alpha: 1}, 4, {ease: FlxEase.expoOut});
    FlxTween.tween(titleText, {alpha: 1}, 4, {ease: FlxEase.expoOut});
    FlxTween.tween(cutText, {alpha: 1}, 4, {ease: FlxEase.expoOut});
    FlxTween.tween(hahaoptions, {alpha: 1, x: 0}, 4, {ease: FlxEase.expoOut});
    FlxTween.tween(selectionhighlight, {x: -100}, 4, {ease: FlxEase.expoOut});
}

// all my funny update shit
var tottalTimer:Float = 0;
function update(elapsed:Float) {
    // update timer lololololol
    tottalTimer += elapsed;

    sexyvignette.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);
    flicker.scale.set(1/FlxG.camera.zoom, 1/FlxG.camera.zoom);
    hangedbitches.angle = 2 * Math.sin(tottalTimer/2);
	hangedbitches.offset.y = 3 * Math.sin(tottalTimer+.67);
    if (controls.BACK && quieto)
	{
        CoolUtil.playMenuSFX(2, 10);
		FlxG.switchState(new MainMenuState());
	}
    if (controls.ACCEPT && quieto)
    {
        selectWeekStinky();
        trace("YOU HIT ENTER!!!!!!");
        //PlayState.loadSong("test", "normal", false, false);
        //FlxG.switchState(new PlayState());
    }
    else if(controls.ACCEPT && inCutscene){
        finishVideo();
        //vid.bitmap.stop();
    }
    
    FlxG.camera.shake(0.00045, 999999999999);
    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];
    if (hangedbitchesShader != null)
        hangedbitchesShader.data.time.value = [Conductor.songPosition];
    }
    if (FlxG.mouse.overlaps(opUp) && quieto)
        {
            if(opNum != 0){
            opNum = 0;
            FlxTween.cancelTweensOf(selectionhighlight);
            selectionhighlight.y = hahaoptions.y + 5;
            alpOp.y = hahaoptions.y + Std.int(hahaoptions.height / 2);
            selectionhighlight.x = -1200;
            FlxTween.tween(selectionhighlight, {x: -100}, 0.5, {ease: FlxEase.expoOut});
            }

            if(FlxG.mouse.justPressed && hangedbitches.visible == false){
                changeOp(0);
            }
            //MainMenuState.instance.WEHOVERING = true;
        }
        

    if (FlxG.mouse.overlaps(opDown) && quieto)
        {
            if(opNum != 1){
            opNum = 1;
            FlxTween.cancelTweensOf(selectionhighlight);
            selectionhighlight.y = hahaoptions.y + Std.int(hahaoptions.height / 2);
            alpOp.y = hahaoptions.y;
            selectionhighlight.x = -1200;
            FlxTween.tween(selectionhighlight, {x: -100}, 0.5, {ease: FlxEase.expoOut});
            }

            if(FlxG.mouse.justPressed && cutText.visible == false){
                changeOp(1);
            }
            //MainMenuState.instance.WEHOVERING = true;
        }

        grpCut.forEach(function(spr:FlxSprite)
			{
				spr.color = 0xFF7C0000;
				if (FlxG.mouse.overlaps(spr))
				{
					spr.color = 0xFFFFFFFF;
				}
	
				if(FlxG.mouse.justPressed && FlxG.mouse.overlaps(spr)){
					quieto = false;
					startVideo(cutscenes[spr.ID]);
				}
			});
// you changed your option holy shit?????
function changeOp(option:Int){
    hangedbitches.visible = false;
    titleText.visible = false;
    songsText.visible = false;
    cutText.visible = false;
    startText.visible = false;
    grpCut.visible = false;
    FlxG.sound.play(Paths.sound('menu/scroll'), 1);
    if(option == 0){
        hangedbitches.visible = true;
        titleText.visible = true;
        songsText.visible = true;
        startText.visible = true;
    }else{
        cutText.visible = true;
        grpCut.visible = true;
    }
}

function startVideo(name:String)
    {
    FlxTween.tween(FlxG.sound.music, {volume: 0}, 1, {ease: FlxEase.circIn});

    add(bg);
    FlxTween.tween(bg, {alpha: 1}, 1);

    new FlxTimer().start(1.2, function(tmr:FlxTimer)
        {
            inCutscene = true;
            //MainMenuState.instance.lerpCamZoom = false;
            FlxG.camera.zoom = 1;
            vid = new VideoCutscene(Paths.video(name));
            
            add(vid);

            FlxG.camera.filtersEnabled = false;
            vid.finishCallback = function()
            {
                finishVideo();
            }
            return;
        }
        );
        
    }


function selectWeekStinky() {
    quieto = false;
    FlxTween.tween(FlxG.camera, {zoom: 1.3}, 2, {ease: FlxEase.circIn});
	FlxTween.tween(FlxG.sound.music, {volume: 0}, 2, {ease: FlxEase.circIn});
    //PlayState.loadWeek(Paths.json("week"), "normal");
    PlayState.loadSong("test", "normal", false, false);
    new FlxTimer().start(3, function(tmr:FlxTimer)
	{
		FlxG.camera.alpha = 0;
        FlxG.switchState(new PlayState());
	});
    
}
public function finishVideo():Void{
    FlxG.camera.filtersEnabled = true;
    vid.destroy();
    new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            remove(bg);
            quieto = true;
        });
    FlxTween.tween(FlxG.sound.music, {volume: 1}, 1, {ease: FlxEase.circIn});
    FlxTween.tween(bg, {alpha: 0}, 1);
}
