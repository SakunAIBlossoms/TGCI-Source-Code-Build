import funkin.backend.system.framerate.Framerate;
import funkin.backend.utils.WindowUtils;
var rings = 00;
var ringcount;
var customScoreTxt;
function create() {
	customHUDEnabled = false;
	introLength = 0;
	usecustomshowsongsprite = true;
}
function postCreate() {
	customResizeWindow(800,600);
	customResizeCameras(0,-110,1.4,1.4,800,600,false);
    iconP1.visible = false;
    iconP2.visible = false;
    healthBar.visible = false;
    healthBarBG.visible = false;
	titleNES = new FlxSprite().loadGraphic(Paths.image('stages/Somari/title'));
	titleNES.width = titleNES.width / 4;
	titleNES.loadGraphic(Paths.image('stages/Somari/title'), true, Math.floor(titleNES.width), Math.floor(titleNES.height));
	titleNES.scale.set(2, 2);
	titleNES.antialiasing = false;
	titleNES.visible = false;
	titleNES.cameras = [camHUD];
	titleNES.updateHitbox();
	titleNES.screenCenter(0x11);
	titleNES.x = titleNES.x - 182;
	titleNES.animation.add("show", [3, 2, 1, 0], 12, false);
	titleNES.animation.add("hide", [0, 1, 2, 3], 12, false);
	add(titleNES);
	ringcount = new FlxText(800,617, FlxG.width, '00', 50);
	ringcount.setFormat(Paths.font("mariones.ttf"), 50, FlxColor.WHITE);
	ringcount.antialiasing = false;
	ringcount.cameras = [camHUD];
	insert(strumLines,ringcount);
	customScoreTxt = new FunkinText(20,617,FlxG.width, '000000', 50, false);
	customScoreTxt.setFormat(Paths.font("mariones.ttf"), 50, FlxColor.WHITE);
	customScoreTxt.cameras = [camHUD];
	customScoreTxt.antialiasing = false;
	insert(strumLines,customScoreTxt);
	ringicon = new FunkinSprite(747,623,Paths.image('stages/Somari/image'));
	ringicon.scale.set(8, 8);
	ringicon.updateHitbox();
	ringicon.cameras = [camHUD];
	insert(strumLines,ringicon);
	topBar = new FlxSprite(0,610).makeSolid(camHUD.width, 80, FlxColor.BLACK);
	topBar.cameras = [camHUD];
	insert(strumLines,topBar);
	camGame.pixelPerfectRender = true;
	camHUD.pixelPerfectRender = true;
}
function updateringtext(newtext:Dynamic) {
	ringcount.text = newtext;
}
function onNoteHit(e) {
	customScoreTxt.text = songScore;
	if (e.noteType == "Ring Note") {
		rings += 1;
		FlxG.sound.play(Paths.sound('songs/ZFAEM7/ringhit'));
	}
	if (rings < 10) updateringtext("0"+rings);
	if (rings >= 10) updateringtext(rings);
}
function onPlayerMiss() {
	customScoreTxt.text = songScore;
	if (rings > 0) {
		rings -= 1;
		FlxG.sound.play(Paths.sound('songs/ZFAEM7/ringloss'));
	}
}
function onSongStart() {
	statsTxt.visible = false;
}
function onEvent(e) {
    if (e.event.name == "showsong") {
        params = e.event.params;
        show = params[0];
        if (show) {
            WindowUtils.winTitle = "Friday Night Funkin': This GC's Insanity | " + PlayState.SONG.meta.displayName + params[2] + " | " + params[1];
            showEvent();
        }
        if (!show) hideEvent();
    }
}
function showEvent() {
	titleNES.animation.play("show");
	titleNES.visible=true;
}
function hideEvent() {
	titleNES.animation.play("hide");
	if (titleNES.animation.finished && titleNES.animation.name == "hide") {
		titleNES.destroy();
	}
}
var noteSize:Float = 6;
function onNoteCreation(event) {
	event.cancel();

	var note = event.note;
	if (event.note.noteType == "Ring Note") {
		if (event.note.isSustainNote) {
			note.loadGraphic(Paths.image('game/notes/types/Ring NoteENDS'), true, 7, 6);
			note.animation.add("hold", [event.strumID]);
			note.animation.add("holdend", [4 + event.strumID]);
		}else{
			note.loadGraphic(Paths.image('game/notes/types/Ring Note'), true, 17, 17);
			note.animation.add("scroll", [4 + event.strumID]);
		}
	}
	if (event.note.noteType == null) {
		if (event.note.isSustainNote) {
			note.loadGraphic(Paths.image('game/notes/NES_NOTE_assetsENDS'), true, 7, 6);
			note.animation.add("hold", [event.strumID]);
			note.animation.add("holdend", [4 + event.strumID]);
		}else{
			note.loadGraphic(Paths.image('game/notes/NES_NOTE_assets'), true, 17, 17);
			note.animation.add("scroll", [4 + event.strumID]);
		}
	}
	note.scale.set(noteSize, noteSize);
	note.updateHitbox();
}

function onStrumCreation(event) {
	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/notes/NES_NOTE_assets'), true, 17, 17);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

    strum.scale.set(noteSize, noteSize);
	strum.updateHitbox();
}
function onPlayerHit(e) {
	e.showSplash = false;
}
function update() {
	camZooming = false;
	if (camHUD.zoom > 1) camHUD.zoom = 1;
    if (Framerate.debugMode > 0)
        Framerate.debugMode = 0;
}
function destroy() {
	resetWindowScale();
}