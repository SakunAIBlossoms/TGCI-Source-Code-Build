


var nosuicide = FlxG.save.data.nosuicide;    
function create() {
    introLength = 0;
}
function postCreate() {
    for (strum in playerStrums) strum.alpha = 0;
}
function onSongStart() {
    toggleHUD();
}

function triggerShit(timeshit:String) {
    var valueshit:Int = Std.int(timeshit);
    if (Math.isNaN(valueshit))
        valueshit = 0;
    switch (valueshit) {
        case 0:
            FlxG.camera.flash(FlxColor.WHITE, 1);
            if (!nosuicide) {
                //hanging.animation.play('idle');
			    //hanging.alpha = 1;
			    //eventTweens.push(FlxTween.tween(hanging, {alpha: 0}, 2, {ease: FlxEase.quadOut}));
            }
            for (strum in playerStrums) FlxTween.tween(strum, {alpha: 0.75}, 1.2);
            for (chars in [boyfriend,gf]) FlxTween.tween(chars, {alpha: 0.75}, 1.2);
            FlxTween.tween(camGame,{zoom: 0.9}, 1.2, {ease: FlxEase.circOut, onComplete: function(twn:FlxTween){
                defaultCamZoom = 0.9;
            }});
            toggleHUD();
    }
}
function stepHit(curStep:Int) {
    switch(curStep) {
        case 2424:
            for (strum in playerStrums) FlxTween.tween(strum, {alpha: 0}, 3);
            for (chars in [boyfriend,gf]) FlxTween.tween(chars, {alpha: 0}, 3);
    }
}
// call this inside the engines event system
function fadeNotes(type:String, who:String, duration:String) {
    if (type == "in") {
        if (who == "P1") {
            for (i in 0...4) {
                FlxTween.tween(playerStrums.members[i], {alpha: 1}, Std.parseInt(duration));
            }
        }
        else if (who == "P2") {
            for (i in 0...4) {
                FlxTween.tween(cpuStrums.members[i], {alpha: 1}, Std.parseInt(duration));
            }
        }
    }
    else if (type == "out") {
        if (who == "P1") {
            for (i in 0...4) {
                FlxTween.tween(playerStrums.members[i], {alpha: 0}, Std.parseInt(duration));
            }
        }
        else if (who == "P2") {
            for (i in 0...4) {
                FlxTween.tween(cpuStrums.members[i], {alpha: 0}, Std.parseInt(duration));
            }
        }
    }
}

function onPlayerMiss() {
    gf.playAnim("miss");
    trace("make gf do the sadge womp womp face :(");
}