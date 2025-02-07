import flixel.addons.display.FlxBackdrop;

var sections = [
    {title: "Blood and gore", description: "Are you sensitive to blood and gore?\nThis filter is not perfect and some gore may have gone uncensored\nif you begin feeling nauseous stop playing TGCI", savedata: FlxG.save.data.removegore},
    {title: "Suicide Content", description: "Are you sensitive to any form of suicide related content?\nThis filter is not perfect and some suicide content may have gone uncensored\nif you begin feeling nauseous stop playing TGCI", savedata: FlxG.save.data.nosuicide},
    {title: "Privacy Mode", description: "This mod will use things such as your pc username,\ndiscord username and discord profile picture for some gimmicks.\nDo you want to active privacy mode?", savedata: FlxG.save.data.privacymode},
    {title: "Old UI?", description: "TGCI is based on Mario's madness at its core although\nit does use completely custom menus sometimes.\nSome people may prefer the original Mario's Madness menus\nWould you like to use the original menus?", savedata: FlxG.save.data.oldUI},
    {title: "Disable Shaders?", description: "If your device is unable to handle shaders\nyou can outright disable them.\nWould you like to disable shaders?", savedata: FlxG.save.data.noshaders},
    {title: "Antialiasing", description: "Would you like to enable or disable antialiasing?\n(antialising is what gives sprites a nice smooth look)", savedata: FlxG.save.data.antialiasing},
    {title: "Flashing Lights", description: "Would you like to enable flashing lights?\nNote: This setting is not perfect and\ncan still have flashing lights slip through.\n\nif you begin experiencing symptoms close TGCI immediately\n and seek medical attention.", savedata: FlxG.save.data.flashingMenu},
    {title: "Low memory mode", description: "Would you like to enable low memory mode?\nLow memory mode removes certain background objects\nand menu objects to use less memory and provide a more\noptimised experience", savedata: FlxG.save.data.lowMemoryMode},
    {title: "[IMPORTANT] PC Manipulation", description: "Please read the following carefully.\n\nPC Manipulation is the act of manipulating and\ntaking control of the users pc without the intent to cause permenant damage or harm\nyour files will not be modified.\nWould you like to disable PC Manipulation?\n\nBy continuing you acknowledge that This GC, Funkin' Crew and Codename Devs\nare not responsible for anything that happens with the mechanics on.", savedata: FlxG.save.data.nopcmanipulation},
    {}
];
var title;
var description;
var pressbuttonTxt;
var begin = true;
var end = false;
var resetscreen = false;

function create() {
    trace("loaded");
    if (FlxG.save.data.hasdonefirsttimesetup) FlxG.switchState(new TitleState());
    var bg = new FlxBackdrop(Paths.image('menus/mainmenu/bgs/bg0'));
	bg.velocity.x = -40;
	bg.antialiasing = false;
	bg.screenCenter();
	bg.scale.set(4, 4);
	add(bg);
    var estatica = new FlxSprite();
	estatica.frames = Paths.getSparrowAtlas('menus/estatica_uwu');
	estatica.animation.addByPrefix('idle', "Estatica papu", 15);
	estatica.animation.play('idle');
	estatica.color = FlxColor.RED;
	estatica.alpha = 0.7;
	estatica.scrollFactor.set();
	estatica.updateHitbox();
	add(estatica);
    title = new FunkinText(0,45,0,"First Time Setup",52,true);
    title.alignment = "center";
    title.screenCenter(0x01);
    description = new FunkinText(0,title.y + 120,0,"Welcome to the first time setup\nThis simple menu will help you set up some basic settings before\ndiving head first into TGCI",28,true);
    description.alignment = "center";
    description.screenCenter(0x01);
    pressbuttonTxt = new FunkinText(0,FlxG.height-160,0,"Press Enter", 72, true);
    pressbuttonTxt.screenCenter(0x01);
    for (i in [title, description, pressbuttonTxt]) add(i);
}

function changeText(titletext:String, descriptiontext:String) {
    title.text = titletext;
    description.text = descriptiontext;
    title.screenCenter(0x01);
    description.screenCenter(0x01);
    pressbuttonTxt.text = "Press Y/N";
    pressbuttonTxt.screenCenter(0x01);
}
var sectionIndex = -1;
function update() {
    if (begin && controls.ACCEPT) changesection();
    if (end && controls.ACCEPT) goToTitle();
    if (FlxG.keys.justPressed.Y && !transitioning) {
        if (resetscreen) {sectionIndex = -1; changesection(); resetscreen = false;}
        else
        changesection(true);
    }
    if (FlxG.keys.justPressed.N && !transitioning) {
        if (resetscreen) {sectionIndex -= 1; changesection(); resetscreen = false;}
        else
        changesection(false);
    }
    if (FlxG.keys.justPressed.R && !transitioning) {
        reset();
    }
}
function changesection(?mode:Bool) {
    sectionIndex++;
    trace(sections[sectionIndex]);
    if (begin) begin = false;
    if (mode != null) sections[sectionIndex].savedata = mode;
    FlxTween.tween(FlxG.camera, {alpha:0}, 0.6, {ease: FlxEase.circOut, onComplete: function (twn:FlxTween){
        if (sectionIndex == sections.length-1) {
            end = true;
            changeText("End", "You have reached the end of the first time setup\nif you need to correct any mistakes check the options menu\nPlease press ENTER to continue.");
            pressbuttonTxt.text = "Press Enter";
            pressbuttonTxt.screenCenter(0x01);
        }
        else changeText(sections[sectionIndex].title, sections[sectionIndex].description);
        FlxTween.tween(FlxG.camera, {alpha:1}, 0.4, {ease: FlxEase.circIn, onComplete: function (twn:FlxTween){
            transitioning = false;
        }});
    }});
}
function goToTitle() {
    FlxG.save.data.hasdonefirsttimesetup = true;
	FlxG.switchState(new TitleState());
}
function reset() {
    changeText("Reset?", "Would you like to reset to the beginning?");
    resetscreen = true;
}