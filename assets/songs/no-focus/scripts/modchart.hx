
function create() {
	customHUDEnabled = false;
}
function onSongStart() {
    healthBar.visible = iconP1.visible = iconP2.visible = statsTxt.visible = false;
}
function stepHit(curStep:Int) {
	switch(curStep) {
		case 1:
			healthBarBG.visible = false;
	}
}
function update() {
    camZooming = false;
	if (camHUD.zoom > 1)
		camHUD.zoom = 1;
}
/*
var noteSize:Float = 1.9;
function onNoteCreation(event) {
	event.cancel();

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/notes/DS_NOTE_assetsENDS'), true, 25, 5);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	}else{
		note.loadGraphic(Paths.image('game/notes/DS_NOTE_assets'), true, 60, 64);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(noteSize, noteSize);
	note.updateHitbox();
}

function onStrumCreation(event) {
	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('game/notes/DS_NOTE_assets'), true, 60, 60);
	strum.animation.add("static", [event.strumID]);
	strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 58, false);
	strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);

	strum.updateHitbox();

    strum.scale.set(noteSize, noteSize);
}

function onPostNoteCreation(event) {  
    var note = event.note;
    //if (FlxG.save.data.Splashes == "splashDiamond")
    //    note.splash = "diamond-paranoia";
    //if (FlxG.save.data.Splashes == "splashPsych")
    //    note.splash = "vanilla-paranoia";
    //if (FlxG.save.data.Splashes == "splashSecret")
    //    note.splash = "secret-paranoia";
    //if (FlxG.save.data.Splashes == "splashCne")
    //    note.splash = "default-paranoia";

    // fixes sustain note's x offset
    if (note.isSustainNote)
        note.frameOffset.x -= note.frameWidth / 4; 
}
*/