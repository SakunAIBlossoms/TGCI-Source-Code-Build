import funkin.backend.system.framerate.Framerate;
import flixel.util.FlxAxes;
// {VARIABLES}
//  [IMPORTANT SHIT]
var X = FlxAxes.X;
var Y = FlxAxes.Y;
var CENTER = FlxAxes.XY;
// [Text]
var username:FlxText;
var titleShit:FlxText;
var dislikes:FlxText;
var likes:FlxText;
var share:FlxText;
var comments:FlxText;
var dotdotdot:FlxText;
var subtitleShit:FlxText;
// [Sprites]
var songIconShit:FlxSprite;
// [booleans]
var showIcon:Bool = true;
function create() {
    introLength = 0;
}
function postCreate() {
    iconP1.visible = false;
    iconP2.visible = false;
    healthBar.visible = false;
    healthBarBG.visible = false;
    missesTxt.visible = false;
    accuracyTxt.visible = false;
    scoreTxt.visible = false;
    doIconBop = false;
    iconP1.flipX = true;
    iconP1.scale.set(0.3, 0.3);
    iconP2.scale.set(0.35, 0.35);

    slightFade = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    slightFade.alpha = 0.2;
    slightFade.cameras = [camGame];
    add(slightFade);

    username = new FlxText(FlxG.width - 800, FlxG.height - 70, 0, "@Username", 14);
    username.cameras = [camHUD];
    username.antialiasing = true;
    username.setFormat(Paths.font("arial.ttf"), 15, FlxColor.WHITE, "CENTER");
    add(username);

    titleShit = new FlxText(FlxG.width - 840, FlxG.height - 40, 0, "Title goes here", 10);
    titleShit.cameras = [camHUD];
    titleShit.antialiasing = true;
    titleShit.setFormat("Arial", 15, FlxColor.WHITE, "CENTER");
    add(titleShit);

    likes = new FlxText(FlxG.width - 465, FlxG.height - 340, FlxG.width, "0", 14);   
    likes.cameras = [camHUD];
    likes.antialiasing = true;
    likes.setFormat("Arial", 14, FlxColor.WHITE, "CENTER");
    add(likes);

    dislikes = new FlxText(FlxG.width - 465, FlxG.height - 260, FlxG.width, "0", 14);
    dislikes.cameras = [camHUD];
    dislikes.antialiasing = true;
    dislikes.setFormat("Arial", 14, FlxColor.WHITE, "CENTER");
    add(dislikes);

    comments = new FlxText(FlxG.width - 480, FlxG.height - 190, FlxG.width, "Show", 14);
    comments.cameras = [camHUD];
    comments.antialiasing = true;
    comments.setFormat("Arial", 14, FlxColor.WHITE, "CENTER");
    add(comments);

    share = new FlxText(FlxG.width - 480, FlxG.height - 120, FlxG.width, "Share", 14);
    share.cameras = [camHUD];
    share.antialiasing = true;
    share.setFormat("Arial", 14, FlxColor.WHITE, "CENTER");
    add(share);

    dotdotdot = new FlxText(FlxG.width - 467, FlxG.height - 70, FlxG.width, "...", 25);
    dotdotdot.cameras = [camHUD];
    dotdotdot.angle = 90;
    dotdotdot.antialiasing = true;
    dotdotdot.setFormat("Arial", 30, FlxColor.WHITE, "CENTER");
    add(dotdotdot);

    subtitleShit = new FlxText(0,0,FlxG.width,"",40);
    subtitleShit.cameras = [camHUD];
    subtitleShit.screenCenter(CENTER);
    subtitleShit.setFormat("Arial", 40, FlxColor.WHITE, "CENTER");
    subtitleShit.alpha = 1;
    subtitleShit.visible = true;
    add(subtitleShit);
    iconP1.shader = new CustomShader("circleProfilePicture");
    iconP2.shader = new CustomShader("circleProfilePicture");
}

function changeSubs(daText:String) {
    subtitleShit.text = daText;
}
function stepHit(curStep:Int) {

}
function onSongStart() {
    showCustomHUD("false");
}
function showCustomHUD(toggle:String) {
    if (toggle == "true") {
        for (i in 0...4) {
            playerStrums.members[i].visible = true;
        }
        username.visible = true;
        titleShit.visible = true;
        showIcon = true;
        likes.visible = true;
        dislikes.visible = true;
        share.visible = true;
        dotdotdot.visible = true;
        comments.visible = true;
    }
    else if (toggle == "false") {
        for (i in 0...4) {
            playerStrums.members[i].visible = false;
        }
        username.visible = false;
        titleShit.visible = false;
        showIcon = false;
        likes.visible = false;
        dislikes.visible = false;
        share.visible = false;
        dotdotdot.visible = false;
        comments.visible = false;
    }
}
function update() {
    dislikes.text = Std.string(misses);
    likes.text = Std.string(songScore);
    if (!showIcon) {
        iconP1.visible = false;
        iconP2.visible = false;
    }
    if (curCameraTarget == 1) {
        if (showIcon) {
        iconP1.visible = true;
        iconP2.visible = false;
        }
        username.text = "@therealrosebloom";
        titleShit.text = "My first short! :3";
    }
    if (curCameraTarget == 0) {
        if (showIcon) {
            iconP1.visible = false;
            iconP2.visible = true;
        }
        username.text = "@cannotbeatkys";
        titleShit.text = "this youtuber is horrible....";
    }
    if (Framerate.debugMode > 0)
        Framerate.debugMode = 0;
}
function postUpdate() {
    iconP1.setPosition(FlxG.width - 895, FlxG.height - 135);
    iconP2.setPosition(FlxG.width - 895, FlxG.height - 130);
}