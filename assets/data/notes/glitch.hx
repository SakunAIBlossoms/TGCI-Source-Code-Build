function onNoteHit(event) {
    if (event.noteType == "glitch") {
        event.animCancelled = true;
        event.cancel();
    }
} 
function onPlayerMiss(event) {
    if (event.noteType == "glitch") {
        event.animCancelled = true;
        event.cancel();
    }
} 
function onNoteCreation(event) {
    if (event.noteType == "glitch") {
        event.noteSprite = "game/notes/types/glitch";
    }
}