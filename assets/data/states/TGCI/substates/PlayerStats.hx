import funkin.backend.utils.DiscordUtil;
import flixel.addons.display.FlxBackdrop;
var achievements;
var staticshit;
var ntsc;
var resetscreen = false;
var topbarshaketween;
var achievementtext = [];
function create() {
    achievements = Json.parse(Assets.getText(Paths.json("config/achievements")));
    statscam = new FlxCamera(0,0,FlxG.width,FlxG.height,1);
    statscam.bgColor = FlxColor.BLACK;
    FlxG.cameras.add(statscam, false);

    staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3];
    
    ntsc = new CustomShader("NTSCSFilter");
    if (!FlxG.save.data.noshaders) {
        statscam.addShader(ntsc);
        statscam.addShader(staticshit);
    }

    scrollingBG = new FlxBackdrop(Paths.image('menus/scrollingBG'));
	scrollingBG.velocity.set(40, 60);
	scrollingBG.setGraphicSize(200,200);
	scrollingBG.updateHitbox();
	scrollingBG.screenCenter(0x11);
	scrollingBG.color = FlxColor.RED;
	scrollingBG.alpha = 0.4;
	scrollingBG.antialiasing = false;
    scrollingBG.cameras = [statscam];
	insert(0,scrollingBG);
    

    pfp = new FlxSprite().loadGraphic(getplayerpfp());
    //if (pfp.graphic == null) pfp.loadGraphic(Paths.image("menus/mainmenu/Person"));
    pfp.scale.set(1.3,1.3);
    pfp.updateHitbox();
    pfp.shader = new CustomShader("circleProfilePicture");
    pfp.screenCenter(0x11);
    pfp.x -= 500;
    pfp.y -= 250;
    topBar = new FlxSprite().makeGraphic(FlxG.width,pfp.width + 15, FlxColor.BLACK);
    topBar.alpha = 0.8;

    username = new FunkinText(pfp.x + 250, pfp.y + 25, FlxG.width - pfp.x + 250, getplayerusername(), 48, true);

    for (asset in [topBar, pfp, username]) {
        asset.scrollFactor.set();
        asset.antialiasing = Options.antialiasing;
        asset.cameras = [statscam];
        insert(2,asset);
    }
    var achievementnum = 0;
    for (achievement in achievements.achievements) {
        achievementnum++;
        achievementTitle = new FunkinText(45, pfp.y + pfp.width * achievementnum / 2 + 140, FlxG.width, achievement.name, 34, true);
        achievementDesc = new FunkinText(45, achievementTitle.y + 55, FlxG.width, achievement.desc, 26, true);
        achievementTitle.cameras = [statscam];
        achievementDesc.cameras = [statscam];
        if (!FlxG.save.data.achievements[achievement.saveid]) {achievementTitle.alpha = 0.6; achievementDesc.alpha = 0.6; achievementDesc.text = "???"; achievementTitle.text += " [LOCKED]";}
        insert(1,achievementTitle);
        insert(1,achievementDesc);
        achievementtext.push(achievementTitle);
        achievementtext.push(achievementDesc);
    }
    warntext = new FunkinText(0,0,FlxG.width,null,32,true);
    warntext.visible = false;
    warntext.cameras = [statscam];
    warntext.alignment = "center";
    warntext.screenCenter(0x11);
    add(warntext);
}
function update() {
    if (staticshit != null) staticshit.data.iTime.value = [Conductor.songPosition];
    if (ntsc != null) ntsc.data.uFrame.value = [Conductor.songPosition];
    if (!resetscreen) {
        if (controls.BACK) {
            closeanim();
        }
        if (FlxG.mouse.justPressedMiddle) statscam.scroll.y=0;
        if (FlxG.mouse.wheel > 0) statscam.scroll.y -= 25;
        if (FlxG.keys.pressed.UP) statscam.scroll.y -= 15;
        if (FlxG.mouse.wheel < 0) statscam.scroll.y += 25;
        if (FlxG.keys.pressed.DOWN) statscam.scroll.y += 15;
        if (FlxG.keys.justPressed.R) openresetscreen();
    }
    if (resetscreen) {
        if (controls.BACK) closeresetscreen();
        if (controls.ACCEPT) resetsave();
    }
}
function resetsave() {
    for (achievement in FlxG.save.data.achievements) achievement = false;
    closeresetscreen();
    closeanim();
}
function closeresetscreen() {
    resetscreen = false;
    for (FunkinText in achievementtext) FunkinText.visible = true;
    for (i in [scrollingBG, topBar]) i.visible = true;
    warntext.visible = false;
    FlxTween.cancelTweensOf(pfp);
    FlxTween.cancelTweensOf(username);
}
function openresetscreen() {
    resetscreen = true;
    warntext.text = "Would you like to reset your save?\n\n\nPress ACCEPT to reset\nPress BACK to go back";
    warntext.visible = true;
    warntext.screenCenter(0x11);
    for (FunkinText in achievementtext) FunkinText.visible = false;
    for (i in [scrollingBG, topBar]) i.visible = false;
    FlxTween.shake(pfp, 0.05, Math.POSITIVE_INFINITY, 0x01);
    FlxTween.shake(username, 0.01, Math.POSITIVE_INFINITY, 0x01);
}
function closeanim() {
    for (i in [pfp, topBar, username]) FlxTween.tween(i, {y: i.y - 250}, 0.3, {ease: FlxEase.circIn});
    FlxTween.tween(statscam, {alpha: 0}, 0.9, {ease: FlxEase.expoOut, onComplete: function (twn:FlxTween){
        close();
    }});
}
function destroy() {
    persistentUpdate = true;
    persistentDraw = true;
    statscam.removeShader(staticshit);
    statscam.removeShader(ntsc);
    FlxG.cameras.remove(statscam, true);
}