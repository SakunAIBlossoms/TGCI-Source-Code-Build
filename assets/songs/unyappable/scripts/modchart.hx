// {IMPORTS}
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import funkin.backend.utils.WindowUtils;
import flixel.addons.display.FlxBackdrop;
// {VARIABLES}
var cursection:Int;
var flyingFuckL:FlxBackdrop;
var flyingFuckR:FlxBackdrop;
var nomiss:Bool = false;
function postCreate() {
	flyingFuckL = new FlxBackdrop();
	flyingFuckL.cameras = [camHUD];
	flyingFuckL.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
	flyingFuckL.animation.addByPrefix('yinyin', "Bird Up", 24);
	flyingFuckL.animation.addByPrefix('slice', "Lakitu", 24);
	flyingFuckL.animation.addByPrefix('KILLYOURSELF', "Rotat e", 24);
	flyingFuckL.animation.play("KILLYOURSELF");
	flyingFuckL.updateHitbox();
	flyingFuckL.scale.set(0.6, 0.6);
	flyingFuckL.screenCenter();
	flyingFuckL.x -= 450;
	flyingFuckL.velocity.set(0, 600);
	flyingFuckL.visible = false;
	add(flyingFuckL);

	flyingFuckR = new FlxBackdrop();
	flyingFuckR.cameras = [camHUD];
	flyingFuckR.frames = Paths.getSparrowAtlas('stages/beatus/YouCannotBeatUS_Fellas_Assets');
	flyingFuckR.animation.addByPrefix('yinyin', "Bird Up", 24);
	flyingFuckR.animation.addByPrefix('slice', "Lakitu", 24);
	flyingFuckR.animation.addByPrefix('KILLYOURSELF', "Rotat e", 24);
	flyingFuckR.animation.play("KILLYOURSELF");
	flyingFuckR.updateHitbox();
	flyingFuckR.scale.set(0.6, 0.6);
	flyingFuckR.x = FlxG.width - flyingFuckR.width + 60;
	flyingFuckR.velocity.set(0, -600);
	flyingFuckR.visible = false;
	add(flyingFuckR);
	flyingFuckR.repeatAxes = FlxAxes.Y;
	flyingFuckL.repeatAxes = FlxAxes.Y;
}
function onSongEnd() {
	resetTitle();
}
function changeHeads(headString:String) {
	var headnum = Std.parseInt(headString);
	switch(headnum) {
		case 0: 
			flyingFuckL.animation.play('KILLYOURSELF');
			flyingFuckR.animation.play('KILLYOURSELF');
		case 1:
			flyingFuckR.animation.play('yinyin');
			flyingFuckL.animation.play('yinyin');
		case 2:
			flyingFuckL.animation.play('slice');
			flyingFuckR.animation.play('slice');
	}
	
}
function flyingFucks() {
	nomiss = !nomiss;
	flyingFuckL.visible = !flyingFuckL.visible;
	flyingFuckR.visible = !flyingFuckR.visible;
}
function resetStrums() {
	for (note in playerStrums.members) {
		FlxTween.tween(note, {x: note.x + 330}, 0.0001, {ease: FlxEase.cubeInOut});
	}
	for (note in cpuStrums.members) {
		FlxTween.tween(note, {x: note.x + 1000}, 0.0001, {ease: FlxEase.quadInOut,
			onComplete: function(tween:FlxTween){
				FlxTween.tween(note, {alpha: 1}, 0.0001, {ease: FlxEase.quadInOut,});
		}});
	}
}

function moveFunniNote(type:String) {
	if (type == "slow") {
		for (note in playerStrums.members) {
			FlxTween.tween(note, {x: note.x - 330}, 1.5, {ease: FlxEase.cubeInOut});
		}
		for (note in cpuStrums.members) {
			FlxTween.tween(note, {alpha: 0}, 0.5, {ease: FlxEase.quadInOut, 
				onComplete: function(tween:FlxTween){
					FlxTween.tween(note, {x: note.x - 1000}, 0.1, {ease: FlxEase.quadInOut});
				}});
		}
	}
	else if (type == "instant") {
		for (note in playerStrums.members) {
			FlxTween.tween(note, {x: note.x - 330}, 0.0001);
		}
		for (note in cpuStrums.members) {
			FlxTween.tween(note, {x: note.x - 1000}, 0.0001);
		}
	}
	
}
function stepHit(curStep:Int) {
	if (curStep == 115) {
	    FlxTween.tween(camHUD, {alpha: 1}, 3, {ease: FlxEase.quadInOut});
	}
}