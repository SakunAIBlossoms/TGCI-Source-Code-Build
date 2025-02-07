import funkin.menus.MainMenuState;
import Sys;


var songIcon:FlxSprite;
var dISK:FlxSprite;
var rigghtsidestuff:FlxTypedGroup<FlxText>;
var optionsShit:FlxTypedGroup<FlxSprite>;
var transitioning:Bool = false;
var readingLeftText:Bool = false;
var readingRightText:Bool = false;
var tipShit:String;
var songDesc:String;
var songName:String;
var songIconName:String;

function create(event) {
    event.cancel();
    FlxG.mouse.visible = true;
    songDesc = Assets.getText(Paths.txt("songDesc/desc/" + PlayState.curSong));
    tipShit = Assets.getText(Paths.txt("songInfo/tips/" + PlayState.curSong));
    trace(PlayState.curSong + songDesc + tipShit);
    event.music =Paths.inst(PlayState.curSong, "normal");
    songName = PlayState.curSong;
    freeplaySongList = Json.parse(Assets.getText(Paths.json("config/tgciFreeplay")));

    pauseCam = new FlxCamera(0,0,FlxG.width,FlxG.height,1);
    FlxG.cameras.add(pauseCam, false);

    // dark bg thingy i dont fucking know bro
    bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    bg.alpha = 0.3;
    bg.cameras = [pauseCam];
    add(bg);

    // shader or something fuck you
    staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3];

    // Spinning Disk
    dISK = new FunkinSprite(0,0,Paths.image("game/pause/disk"));
    dISK.screenCenter(0x11);
    dISK.y -= 80;
    dISK.cameras = [pauseCam];
    add(dISK);

    // haha methods amiright? (i fucking hate myself)
    for (i in 0...freeplaySongList.songs.length){ 
        if (songName == freeplaySongList.songs[i].filename){
            songIconName = freeplaySongList.songs[i].icon; 
        }
    }

    // Song Icon that sits ontop the disk
    songIcon = new FunkinSprite(0,0,Paths.image('menus/freeplay/charicon/'+ songIconName));
    if (songIcon.graphic == null) // if its null use a backup so no bugs :innocent:
        songIcon.loadGraphic(Paths.image("menus/freeplay/charicon/Char0"));
    songIcon.scale.set(0.95,0.95);
    songIcon.updateHitbox();
    songIcon.screenCenter(0x11);
    songIcon.y -= 100;
    songIcon.color = FlxColor.RED;
    songIcon.cameras = [pauseCam];
    add(songIcon);

    // i dumb
    bottomBar = new FlxSprite().makeGraphic(FlxG.width, 150, 0xFF0023CC);
    bottomBar.y = FlxG.height - 150;
    bottomBar.cameras = [pauseCam];
    bottomBar.shader = staticshit;
    outline = new FlxSprite().makeGraphic(FlxG.width, 15, FlxColor.BLACK);
    outline.cameras = [pauseCam];
    outline.y = FlxG.height - 160;
    add(outline);
    add(bottomBar);

    // *coughs*
    rigghtsidestuff = new FlxTypedGroup();
    rigghtsidestuff.cameras = [pauseCam];
	add(rigghtsidestuff);

    var rightsideTopTxt = new FunkinText(FlxG.width - 500,25,0,"Song Stats:", 46, true);
    rightsideTopTxt.cameras = [pauseCam];
    rigghtsidestuff.add(rightsideTopTxt);
    var rightsideScoreInformation = new FunkinText(FlxG.width - 500,75,0,"Misses: " + PlayState.misses + "\nScore: " + PlayState.songScore + " \nAccuracy: " + PlayState.accuracy + "%", 34, true);
    rightsideScoreInformation.cameras = [pauseCam];
    rigghtsidestuff.add(rightsideScoreInformation);
    var rightsideTipTitle = new FunkinText(FlxG.width - 360,200,0,"Tip:", 42, true);
    rightsideTipTitle.cameras = [pauseCam];
    rigghtsidestuff.add(rightsideTipTitle);
    var rightsideTipDesc = new FunkinText(FlxG.width - 500,250,0,"test", 26, true);
    rightsideTipDesc.cameras = [pauseCam];
    rigghtsidestuff.add(rightsideTipDesc);

    for (i in 0...rigghtsidestuff.members.length) {
        rigghtsidestuff.members[i].alpha = 0;
        // put it to the left as yin said
        rigghtsidestuff.members[i].x = rigghtsidestuff.members[i].x / 2;
        rigghtsidestuff.members[i].x -= 350;
    }

    // descriptions
    descriptionText = new FunkinText(FlxG.width / 3 + 120,35,0,songDesc, 16, true);
    descriptionText.alpha = 0;
    descriptionText.cameras = [pauseCam];
    add(descriptionText);
    
    // song name shit
    songNameTxt = new FunkinText(0,15,0,PlayState.SONG.meta.displayName, 36, true);
    songNameTxt.screenCenter(0x01);
    songNameTxt.cameras = [pauseCam];
    add(songNameTxt);

    deathTxt = new FunkinText(5,FlxG.height - 200,0,"Deaths: " + PlayState.deathCounter, 34, true);
    deathTxt.cameras = [pauseCam];
    add(deathTxt);

    optionsShit = new FlxTypedGroup();
    optionsShit.cameras = [pauseCam];
	add(optionsShit);

    resume = new FunkinSprite(0,0,Paths.image('game/pause/Mario_pause_Resume'));
    resume.scale.set(0.55,0.55);
    resume.updateHitbox();
    resume.animation.addByPrefix("idle", "credits white");
    resume.animation.addByPrefix("selected", "credits basic");
    resume.animation.play("idle");
    resume.y = bottomBar.y + 10;
    resume.x -= 10;
    resume.cameras = [pauseCam];
    optionsShit.add(resume);

    restart = new FunkinSprite(0,0,Paths.image('game/pause/Mario_pause_Restart'));
    restart.scale.set(0.55,0.55);
    restart.updateHitbox();
    restart.animation.addByPrefix("idle", "freeplay white");
    restart.animation.addByPrefix("selected", "freeplay basic");
    restart.animation.play("idle");
    restart.y = bottomBar.y + 10;
    restart.screenCenter(0x01);
    restart.cameras = [pauseCam];
    optionsShit.add(restart);

    exit = new FunkinSprite(0,0,Paths.image('game/pause/Mario_pause_Exit'));
    exit.scale.set(0.55,0.55);
    exit.updateHitbox();
    exit.animation.addByPrefix("idle", "Exit white");
    exit.animation.addByPrefix("selected", "Exit basic");
    exit.animation.play("idle");
    exit.y = bottomBar.y + 10;
    exit.x = restart.x + 425;
    exit.cameras = [pauseCam];
    optionsShit.add(exit);
    
}


function update() {
    // something something make the stuff transparent
    for (i in 0...optionsShit.members.length) {
        if (readingLeftText || readingRightText)
            optionsShit.members[i].alpha = 0.4;
        else if (!readingLeftText || !readingRightText)
            optionsShit.members[i].alpha = 1;
    }
    if (FlxG.keys.justPressed.ENTER) {
        close();
    }

    if (FlxG.keys.justPressed.LEFT) {
        if (!readingRightText)
            funniTextShit(1);
    }
    if (FlxG.keys.justPressed.RIGHT) {
        if (!readingLeftText)
            funniTextShit(2);
    }
    for (i in 0...optionsShit.members.length) {
        if (FlxG.mouse.overlaps(optionsShit.members[i]) && !readingLeftText && !readingRightText) {
            optionsShit.members[i].animation.play("selected");
            if (FlxG.mouse.justPressed && !readingLeftText && !readingRightText && i == 0) {
                closeThatMenu();
            }
            else if (FlxG.mouse.justPressed && !readingLeftText && !readingRightText && i == 1) {
                FlxG.resetState();
            }
            else if (FlxG.mouse.justPressed && !readingLeftText && !readingRightText && i == 2) {
                PlayState.resetSongInfos();
                CoolUtil.playMenuSong();
				FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
            }
        }
        else if (!FlxG.mouse.overlaps(optionsShit.members[i])) {
            optionsShit.members[i].animation.play("idle");
        }
    }
    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];
    if (!transitioning) {
        dISK.angle += 0.3;
    }
}
function onSelectOption() {
    event.cancel();
}
function closeThatMenu() {
    transitioning = true;
    for (killyourself in [deathTxt, songNameTxt, bg]) {
        FlxTween.tween(killyourself, {alpha: 0}, 1);
    }
    for (bottomBarShit in [bottomBar, outline, resume, restart, exit]) {
        FlxTween.tween(bottomBarShit, {y: bottomBar.y + 150}, 1.1, {ease: FlxEase.quartOut});
    }
    for (hahasongnameshit in [songIcon, dISK]) {
        FlxTween.tween(hahasongnameshit, {y: hahasongnameshit.y - 650}, 1.1, {ease: FlxEase.backIn, onComplete: function(twn:FlxTween) {
            transitioning = false;
            close();
        }});
    }
}
function funniTextShit(value:Int) {
    if (!transitioning) {
        switch(value) {
            case 1:
                if (!readingLeftText) {
                    readingLeftText = true;
                    transitioning = true;
                    for (killyourself in [deathTxt, songNameTxt]) {
                        FlxTween.tween(killyourself, {alpha: 0}, 0.3);
                    }
                    for (hahasongnameshit in [songIcon, dISK]) {
                        FlxTween.tween(hahasongnameshit, {x: hahasongnameshit.x + 380}, 0.8, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween) {
                            transitioning = false;
                        }});
                    }
                    for (i in 0...rigghtsidestuff.members.length) {
                        FlxTween.tween(rigghtsidestuff.members[i], {alpha: 1}, 0.5);
                    }
                    
                }
                else if (readingLeftText) {
                    transitioning = true;
                    for (killyourself in [deathTxt, songNameTxt]) {
                        FlxTween.tween(killyourself, {alpha: 1}, 0.3);
                    }
                    for (hahasongnameshit in [songIcon, dISK]) {
                        FlxTween.tween(hahasongnameshit, {x: hahasongnameshit.x - 380}, 0.8, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween) {
                            transitioning = false;
                        }});
                    }
                    for (i in 0...rigghtsidestuff.members.length) {
                        FlxTween.tween(rigghtsidestuff.members[i], {alpha: 0}, 0.3);
                    }
                    readingLeftText = false;
                }
            case 2:
                if (!readingRightText) {
                    readingRightText = true;
                    transitioning = true;
                    for (killyourself in [deathTxt, songNameTxt]) {
                        FlxTween.tween(killyourself, {alpha: 0}, 0.3);
                    }
                    for (hahasongnameshit in [songIcon, dISK]) {
                        FlxTween.tween(hahasongnameshit, {x: hahasongnameshit.x - 380}, 0.8, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween) {
                            transitioning = false;
                        }});
                    }
                    FlxTween.tween(descriptionText, {alpha: 1}, 0.5);
                    
                }
                else if (readingRightText) {
                    transitioning = true;
                    for (killyourself in [deathTxt, songNameTxt]) {
                        FlxTween.tween(killyourself, {alpha: 1}, 0.3);
                    }
                    for (hahasongnameshit in [songIcon, dISK]) {
                        FlxTween.tween(hahasongnameshit, {x: hahasongnameshit.x + 380}, 0.8, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween) {
                            transitioning = false;
                        }});
                    }
                    FlxTween.tween(descriptionText, {alpha: 0}, 0.3);
                    readingRightText = false;
                }
        }
    }
    for (i in 0...optionsShit.members.length) {
    }
}
function destroy() {
    FlxG.mouse.visible = false;
}