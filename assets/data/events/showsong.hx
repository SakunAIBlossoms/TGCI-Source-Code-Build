import funkin.backend.utils.WindowUtils;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormat;
var songnametxt:FunkinText;
var descriptiontxt:FunkinText;
var show:Bool = false;
var params:Array;
var eventTweens = [];
static var usecustomshowsongsprite:Bool = false;
function postCreate() {
    songnametxt = new FunkinText(0,0,0,PlayState.SONG.meta.displayName, 38, true);
    songnametxt.color = 0xFF0023CC;
    songnametxt.font = Paths.font("mariones.ttf");
    songnametxt.borderSize = 2;
    songnametxt.screenCenter(0x11);
    descriptiontxt = new FunkinText(0,0,0,"",38,true);
    descriptiontxt.font = Paths.font("mariones.ttf");
    descriptiontxt.borderSize = 2;
    descriptiontxt.screenCenter(0x01);
    descriptiontxt.y = songnametxt - 200;
    descriptiontxt.color = 0xFF0023CC;
	var checkwidth:Float = descriptiontxt.width;
	line2 = new FlxSprite(566, songnametxt.y + 57).makeGraphic(FlxG.width/2, 5, 0xFF0023CC);
	line2.screenCenter(0x01);
	line1 = new FlxSprite(line2.x - 5, line2.y - 4).makeGraphic(FlxG.width/2+10, 8, FlxColor.BLACK);
    for (i in [songnametxt, descriptiontxt, line1, line2]) {
        i.cameras = [camHUD];
        add(i);
        i.alpha = 0;
    }
}


function onEvent(e) {
    if (e.event.name == "showsong" && !usecustomshowsongsprite) {
        params = e.event.params;
        show = params[0];
        if (show) {
            WindowUtils.winTitle = "Friday Night Funkin': This GC's Insanity | " + PlayState.SONG.meta.displayName + params[2] + " | " + params[1];
            showEvent();
            changeText(params[2], params[1]);
            trace("\nThe song is: " + PlayState.SONG.meta.displayName + "\non act: " + params[2] + "\nwith the description: " + params[1]);
        }
        if (!show) hideEvent();
    }
}

function changeText(newact, newdescription) {
    if (!usecustomshowsongsprite) {
       songnametxt.text = PlayState.SONG.meta.displayName + " " + params[2];
        descriptiontxt.text = params[1];
        songnametxt.screenCenter(0x01);
        descriptiontxt.screenCenter(0x01); 
    }
    
}

function showEvent() {
    if (!usecustomshowsongsprite) {
        	songnametxt.y = 304.5;
	    descriptiontxt.y = songnametxt.y + 70;
	    line2.y = songnametxt.y + 57;
	    line1.y = line2.y - 2;
	    descriptiontxt.screenCenter(0x01);
	    songnametxt.screenCenter(0x01);
	    eventTweens.push(FlxTween.tween(songnametxt, {alpha: 1, y: songnametxt.y + 30}, 0.5, {ease: FlxEase.cubeOut}));
	    eventTweens.push(FlxTween.tween(descriptiontxt, {alpha: 1, y: descriptiontxt.y + 30}, 0.5, {ease: FlxEase.cubeOut}));
	    eventTweens.push(FlxTween.tween(line1, {alpha: 1, y: line1.y + 30}, 0.5, {ease: FlxEase.cubeOut}));
	    eventTweens.push(FlxTween.tween(line2, {alpha: 1, y: line2.y + 30}, 0.5, {ease: FlxEase.cubeOut}));
    }

}

function hideEvent() {
    if (!usecustomshowsongsprite) {
        eventTweens.push(FlxTween.tween(songnametxt, {alpha: 0, y: songnametxt.y - 30}, 0.5, {ease: FlxEase.cubeOut}));
	    eventTweens.push(FlxTween.tween(descriptiontxt, {alpha: 0, y: descriptiontxt.y - 30}, 0.5, {ease: FlxEase.cubeOut}));
	    eventTweens.push(FlxTween.tween(line1, {alpha: 0, y: line1.y - 30}, 0.5, {ease: FlxEase.cubeOut}));
	    eventTweens.push(FlxTween.tween(line2, {alpha: 0, y: line2.y - 30}, 0.5, {ease: FlxEase.cubeOut}));
    }
}