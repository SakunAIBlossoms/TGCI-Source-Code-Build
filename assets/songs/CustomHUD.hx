import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;
import funkin.backend.utils.CoolUtil;

static var healthOverlay:FlxSprite; 
static var timeBar:FlxBar;
static var timeBarBG:FlxSprite;
static var timeTxt:FunkinText;
static var statsTxt:FunkinText;
static var songNameTxt:FlxText;
static var customHUDEnabled = true;
static var usecustomnoteskin = true;
function postCreate() {
    //runSaveDataCheck(1);
	//PauseSubState.script = 'data/scripts/PauseJukeboxSubState';
    healthOverlay = new FlxSprite(healthBarBG.x - 45, healthBarBG.y - 5).loadGraphic(Paths.image("game/healthBarnew"));
    healthOverlay.cameras = [camHUD];
    insert(members.indexOf(iconP1), healthOverlay);
    if (customHUDEnabled) healthBarBG.visible = false;
    timeBar = new FlxBar(0, 15, FlxBarFillDirection.LEFT_TO_RIGHT, 530, 17, camHUD, "time", 0, inst.endTime, false);
    timeBar.createFilledBar(0xFF000000,0xFF0023CC,false);
    timeBar.numDivisions = inst.endTime;
    timeBarBG = new FlxSprite(0, 11).makeGraphic(536, 24, FlxColor.BLACK);
    timeTxt = new FunkinText(0,12,0,"00:00",16,true);
    timeTxt.font = Paths.font("mariones.ttf");
    scoreTxt.visible = missesTxt.visible = accuracyTxt.visible = false;
    statsTxt = new FunkinText(0,FlxG.height - 35,FlxG.width,"Score: 0 | Misses: 0 | Rating: ?",22,true);
    statsTxt.cameras = [camHUD];
    statsTxt.alignment = 'center';
	statsTxt.borderSize = 1.25;
    statsTxt.screenCenter(0x01);
    add(statsTxt);
    for (time in [timeBarBG,timeBar,timeTxt]) {
        time.screenCenter(0x01);
        time.cameras = [camHUD];
        time.alpha = 0;
        add(time);
    }
    if (FlxG.save.data.notimebar) for (i in [timeTxt,timeBar,timeBarBG]) i.destroy();
    if (!customHUDEnabled) {
        for (i in [timeBarBG, timeBar, timeTxt, healthOverlay]) i.visible = false;
    }
}
function updateScoreText() {
    statsTxt.text = "Score: "+songScore+" | Misses: "+misses+" | Rating: " + curRating.rating + " ("+CoolUtil.quantize(accuracy * 100, 100)+"%) - "+runFCCheck();
    statsTxt.screenCenter(0x01);
}
function onPlayerHit() {
    updateScoreText();
}
function onPlayerMiss() {
    updateScoreText();
}
function runFCCheck() {
    if(misses == 0) return 'FC';
	else {
        if (misses < 10) return 'SDCB';
        else return 'Clear';
    }
}
function onSongStart() {
    if (!FlxG.save.data.notimebar) {
        for (time in [timeBarBG,timeBar,timeTxt]) FlxTween.tween(time, {alpha: 1}, 1.2, {ease: FlxEase.circOut});
    }
}
var curTime:Float = 0;
function postUpdate() {
    if (FlxG.save.data.nohealthbar) {
        for (i in [healthBar, healthOverlay, healthBarBG, iconP1, iconP2, statsTxt]) i.visible = false;
    }
    curTime = CoolUtil.timeToStr(inst.time - inst.endTime);
    if (!FlxG.save.data.notimebar) {
        timeTxt.text = curTime.split(".")[0];
        timeBar.value = inst.time;
    }
}
function destroy() {
    if (!customHUDEnabled || !usecustomnoteskin) {
        customHUDEnabled = true;
        usecustomnoteskin = true;
    }
}