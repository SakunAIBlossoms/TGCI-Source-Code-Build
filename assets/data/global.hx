// Imports
import funkin.menus.BetaWarningState;
import openfl.system.Capabilities;
import funkin.backend.utils.NdllUtil;
import lime.graphics.Image;
import funkin.backend.utils.WindowUtils;
import openfl.Lib;
import funkin.backend.utils.DiscordUtil;
import Sys;

static var initialized:Bool = false;
// Notification NDLL
static var notifSend = NdllUtil.getFunction("notification", "notification_send", 3);
static var notifDelete = NdllUtil.getFunction("notification", "notification_delete", 0);
// DEFAULT WINDOW POSITIONS
static var winX:Int = FlxG.stage.application.window.display.bounds.width / 6;
static var winY:Int = FlxG.stage.application.window.display.bounds.height / 6;
// MONITOR RESOLUTION
static var fsX:Int = Capabilities.screenResolutionX;
static var fsY:Int = Capabilities.screenResolutionY;
// WINDOW SIZE CHANGE VAR
static var resizex:Int = Capabilities.screenResolutionX / 1.5;
static var resizey:Int = Capabilities.screenResolutionY / 1.5;

// mousey mousey
FlxG.mouse.visible = true;

function update(elapsed:Float) {
	if (FlxG.keys.justPressed.F5) FlxG.resetState();
}
var redirectStates:Map<FlxState, String> = [
    MainMenuState => 'TGCI/MainMenuState',
    FreeplayState => 'TGCI/FreeplayState',
	TitleState => 'TGCI/TitleState',
    StoryMenuState => 'TGCI/StoryMenuState',
    BetaWarningState => 'TGCI/WarningState',
];
function preStateSwitch() {
    FlxG.camera.bgColor = 0xFF000000;
    for (redirectState in redirectStates.keys()) 
        if (Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(getTargetState(redirectState));
}
function getTargetState(state) {
	return redirectStates.get(state);
}
function new() {
    // FlxG.save is your mod's save data
    FlxG.save.data.nopcmanipulation ??= true;
    FlxG.save.data.transparency_value ??= 0;
    FlxG.save.data.bgshit ??= "random"; // bg shit for the main menu LOL!
    FlxG.save.data.removegore ??= false;    // Ik that some people dont like gore (mostly kris because I want them to enjoy the mod without puking)
    FlxG.save.data.nosuicide ??= false; // hide suicide content for people sensitive to said content (I can understand it)
    FlxG.save.data.nostartwarn ??= false; // Hide the warning cause it can get annoying
    FlxG.save.data.noshaders ??= false; // shader toggle for performance reasons
    FlxG.save.data.purespeed ??= false; // Removes camGame to get as much performance as humanly possible (not recommended could cause bugs)
    FlxG.save.data.notimebar ??= false; // Remove the timebar for people who dont like it
    FlxG.save.data.nohealthbar ??= false; // Remove the healthbar for people who dont like it (u cant see ur health anymore lmao)
    FlxG.save.data.oldUI ??= false;
    FlxG.save.data.privacymode ??= false;
    FlxG.save.data.hasdonefirsttimesetup ??= false;
    FlxG.save.data.botplay ??= false;

    // ACTUAL SAVED INFORMATION!!!
    FlxG.save.data.creditsarefinale ??= false;
    FlxG.save.data.slotMachineUnlocked ??= false;

    FlxG.save.data.goodending ??= false;
    FlxG.save.data.badending ??= false;
    FlxG.save.data.horribleending ??= false;
    FlxG.save.data.trueending ??= false;
    // achievments or smthn idfk
    FlxG.save.data.achievements ??= [
        {
            "slotMachineUnlocked": false, // This is 0
            "hasmadedealwithkys": false,
            "beateverysongwithSrank": false
        }
    ];
    // -- Dataleak
    FlxG.useSystemCursor = false;
    FlxG.mouse.load(Image.fromBytes(Assets.getBytes(Paths.image('cursor'))));
    window.setIcon(Image.fromBytes(Assets.getBytes(Paths.image('icon16'))));
    WindowUtils.winTitle = "Friday Night Funkin': This GC's Insanity";
}
function destroy() {
    FlxG.mouse.unload();
    FlxG.mouse.useSystemCursor = true;
}
static function getCenterWindowPoint() {
    return FlxPoint.get(
        Lib.application.window.x + (Lib.application.window.width / 2),
        Lib.application.window.y + (Lib.application.window.height / 2)
    );
}
static function centerWindowOnPoint(?point:FlxPoint) {
    Lib.application.window.x = Std.int(point.x - (Lib.application.window.width / 2));
    Lib.application.window.y = Std.int(point.y - (Lib.application.window.height / 2));
}
static function runSaveDataCheck(thecheck:Int) {
    // 0 for final cutscene, 1 for pause jukebox, More soon.
    switch(thecheck)
    {
        case 0: if (FlxG.save.data.oldUI) return "TGCI/oldfinalCutsceneUltraM"; else return "TGCI/finalCutsceneUltraM";
        //case 1: if (FlxG.save.data.oldUI) return "data/scripts/oldPauseJukeboxSubState"; else return "data/scripts/PauseJukeboxSubState";
    }
}
static function getplayerusername() {
    if (FlxG.save.data.privacymode) return "Rosebloom";
    else
    if (DiscordUtil.user != null) return DiscordUtil.user.globalName; 
    else
    return Sys.environment()["USERNAME"];
}
static function getplayerpfp() {
    if (FlxG.save.data.privacymode || DiscordUtil.user == null) return Paths.image("menus/mainmenu/Person");
    else return DiscordUtil.user.getAvatar(160);
}
static function customResizeWindow(windowwidth:Int,windowheight:Int) {
    window.fullscreen = false;
	window.resizable = false;
	window.resize(windowwidth, windowheight);
}
static function resetWindowScale() {
    Lib.application.window.resizable = true;
	Lib.application.window.resize(1280, 720);
}
static function triggerError() {
    errorText = new FunkinText();
}