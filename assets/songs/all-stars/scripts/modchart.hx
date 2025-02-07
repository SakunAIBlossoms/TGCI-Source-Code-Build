/*
All stars is a MASSIVE song with tons of shit
50% of it like bg changes will be held in the STAGE SCRIPT
so go there if your wondering where stage changes are
the other half of it will be done via in game events that you *can* edit in the chart editor without 
needing to manually edit it in script
the rest of the stuff is done in script
Im hoping to simplify it for you to understand and other team members to be able to easily edit
this includes things related to the strums and some assets
BUT
most of the shit will be done via stepHit's
so please check there if you cannot find it in the stage file or in the events
								- Dataleak
*/

// Imports and variables:

// 		{IMPORTS}
import funkin.backend.utils.WindowUtils;
import funkin.backend.utils.CoolSfx;
import funkin.backend.utils.CoolUtil;
import flixel.effects.FlxFlicker;
import flixel.util.FlxAxes;
// 		{VARIABLES}
//  [IMPORTANT SHIT]
var X = FlxAxes.X;
var Y = FlxAxes.Y;
var CENTER = FlxAxes.XY;
// 	[Sprites]
var cutsceneShit:FlxSprite;
var blackScreen:FlxSprite;

// Song Functions
// I will not explain anything that happens here as it should be relatively self explanatory
// if you wish to know what each function does check https://codename-engine.com/wiki/modding/scripting/script-calls
function create() {
	//blackScreen = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
	//blackScreen.screenCenter(CENTER);
	// the reason I add this before making the other sprite is because of the way flixel handles layers. to sit this behind the sprite i have to add this first
	// update: i can use insert to add but i feel like its cleaner to do it manually :3c
	//add(blackScreen);

	// Intro Cutscene
	cutsceneShit = new FlxSprite().loadGraphic(Paths.image("/stages/allfinal/act1/All_Stars_Intro"));
	cutsceneShit.screenCenter(CENTER);
	cutsceneShit.frames = Paths.getSparrowAtlas("/stages/allfinal/act1/All_Stars_Intro");
	cutsceneShit.animation.addByPrefix("intro", "intro anim", 24, true);
	cutsceneShit.cameras = [camHUD];
	cutsceneShit.animation.play("intro");
	cutsceneShit2 = new FlxSprite().loadGraphic(Paths.image("/stages/allfinal/act1/Act_2_Intro"));
	cutsceneShit2.screenCenter(CENTER);
	cutsceneShit2.frames = Paths.getSparrowAtlas("/stages/allfinal/act1/Act_2_Intro");
	cutsceneShit2.animation.addByPrefix("anim", "Anim1", 24, true);
	cutsceneShit2.animation.addByPrefix("animBG", "EyesBG", 24, true);
	cutsceneShit2.cameras = [camHUD];
	cutsceneShit2.animation.play("anim");
	add(cutsceneShit2);
	cutsceneShit2.visible = false;
	camGame.visible = false;
	camHUD.visible = false;
}

function onSongStart() {
	camHUD.visible = true;
	//playerStrums.members[1].visible = false;
	//toggleHud(false);
	//strumLines.members[2].visible = false;
}

function postCreate() {

}

function postUpdate(elapsed) {

}

function stepHit(curStep:Int) {
	// we use if statements to check every step to see if the curStep is on the number we want, above or below the number or if its a certain percentage of another number.
	// kinda like events but scripted
	// update: changed this to a switchcase
	switch(curStep) {
		case 30:
			cutsceneShit.visible = false;
		case 32:
			camGame.visible = true;
		case 1055:
			strumLines.members[2].visible = false;
			cutsceneShit2.visible = true;
			cutsceneShit2.animation.play("anim");
	}
}

// 	-- {CUSTOM FUNCTIONS} --
// ToggleHud Function -- Created by Dataleak
// Allows you to hide the HUD and show the HUD whenever you wish
// You cannot call this using the HScript call event because it requires strings, this function uses a boolean which will not work.
// do NOT call this before or after the song ends as to not crash the script since this set the visible attribute for the strums to false/true
function toggleHud(enabled:Bool) {
	// writing just the boolean means do this if its true
	if (enabled) {
		for (i in 0...4) {
			cpuStrums.members[i].visible = true;
			playerStrums.members[i].visible = true;
		}
		healthBar.visible = true;
		healthBarBG.visible = true;
		iconP1.visible = true;
		iconP2.visible = true;
		accuracyTxt.visible = true;
		missesTxt.visible = true;
		scoreTxt.visible = true;
	}
	// writing an ! at the beginning means it does this if its false
	else if (!enabled) {
		for (i in 0...4) {
			cpuStrums.members[i].visible = false;
			playerStrums.members[i].visible = false;
		}
		healthBar.visible = false;
		healthBarBG.visible = false;
		iconP1.visible = false;
		iconP2.visible = false;
		accuracyTxt.visible = false;
		missesTxt.visible = false;
		scoreTxt.visible = false;
	}
}

// 	 -- {HSCRIPT CALLS} --
