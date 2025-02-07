if (PlayState.instance.difficulty == "WxL") {
var canTweenNotes:Bool = true;
var extraTween:Array<FlxTween> = [];
var eventTweens:Array<FlxTween> = [];
if (extraTween != null)
{
    for (tween in extraTween)
    {
        tween.active = false;
    }
}
if (eventTweens != null)
    {
        for (tween in eventTweens)
        {
            tween.active = false;
        }
    }
function create(){
    introLength = 0;
}
function postCreate() {
    doIconBop = false;
    healthBarBG.visible = false;
	healthBar.visible = false;
	accuracyTxt.visible = false;
	missesTxt.visible = false;
	scoreTxt.visible = false;
    health = 2;
}
function stepHit(curStep:Int) {
    
    //if (canTweenNotes){
    //    if (curStep > 65 && curStep < 192) {
    //            for (note in playerStrums) {
    //                FlxTween.tween(note, {y: note.y - 15}, (0.1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.backOut, type: 4});
    //                //canTweenNotes = false;
    //                //FlxTween.tween(note, {y: note.y - 15}, (0.3 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.backOut, onComplete: function(twn:FlxTween){
    //                //    FlxTween.tween(note, {y: note.y + 15}, (0.3 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.sineInOut, onComplete: function(twn:FlxTween){
    //                //        canTweenNotes = true;
    //                //    }});
    //                //}});
    //            }
    //    }
    //    else if (curStep > 192) {
    //        if (curStep % 4 == 1){
    //            FlxTween.tween(camHUD, {y: camHUD.y - 35}, (0.3 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.backOut,  onComplete: function(twn:FlxTween){
    //                FlxTween.tween(camHUD, {y: camHUD.y + 35}, (0.1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quintOut});
    //            }});
    //        }
    //    }
    //}
    //if (curStep > 65) {
    //    for (i in 0...4) {
    //        //playerStrums.members[1].angle = 90
    //        //FlxTween.tween(playerStrums.members[i], {angle: playerStrums.members[i].angle + 25}, (0.05 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoInOut});
    //    }
    //}
}
function onDadHit(event:NoteHitEvent) {
    if (health > 0.1)
        health = health - 0.015;
}
function beatHit(curBeat:Int) {
    if (healthBar.percent > 80) {
        (FlxTween.angle(iconP2, -40, -20, (0.8 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.backOut}));
    }
}
function postUpdate() {
    iconP1.setPosition(FlxG.width - 150, 10);
    iconP2.setPosition(10, 10);
}
}