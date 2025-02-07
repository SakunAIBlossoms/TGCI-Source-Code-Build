import funkin.backend.utils.WindowUtils;
import flixel.ui.FlxBar.FlxBarFillDirection;
import flixel.ui.FlxBar;
var bottomArea:FlxSprite;
var timeBar:FlxBar;
function postCreate() {
	healthBarBG.visible = false;
	healthBar.visible = false;
	accuracyTxt.visible = false;
	missesTxt.visible = false;
	scoreTxt.visible = false;
	doIconBop = false;
    iconP1.visible = false;
    iconP2.visible = false;
	/*
	timeBar = new FlxBar(0, 0, FlxBarFillDirection.RIGHT_TO_LEFT, FlxG.width - 800, 10, strumLines, "length", 0, 113000, false);
	timeBar.cameras = [camHUD];
	timeBar.screenCenter();
	timeBar.numDivisions = 158000;
	timeBar.flipX = true;
	timeBar.createColoredEmptyBar(0xFFFFFFFF, false);
	timeBar.createColoredFilledBar(0xFFFF0000, false);
	add(timeBar);
    */
    bottomArea = new FlxSprite().makeGraphic(FlxG.width, FlxG.height / 2, FlxColor.BLACK);
    bottomArea.y = FlxG.height - 360;
    bottomArea.cameras = [camHUD];
    insert(strumLines, bottomArea);
    camGame.y = camGame.y * 1.4;
}
function onPostNoteCreation(event) {  
    var note = event.note;
	note.splash = "none";
}
function update() {
	camZooming = false;
	if (misses == 5) {
		health = 0;
	}
}
function postUpdate() {
	//timeBar.value = inst.time;
}