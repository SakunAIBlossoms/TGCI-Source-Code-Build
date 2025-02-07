import funkin.backend.utils.CoolUtil;
import flixel.effects.FlxFlicker;
var credits = [
    {name: "Taiki", image: "taikiOLD", role: "Artwork, animation, code, covers", description: "???", link: "https://www.youtube.com/channel/UCf9I4UPqpH9OMsQkFCWZHeA"},
    {name: "Yin", image: "yin", role: "Artwork", description: "???", link: "about:blank"},
    {name: "SakunAI", image: "sai", role: "Coder", description: "hai im sakuna", link: "about:blank"},
	{name: "KittySleeper", image: "kitty", role: "Coder", description: "Im Such A Silly Goober!\nfuck you nova...", link: "https://www.youtube.com/@KittySleeper"},
    {name: "Nova Ashwolf", image: "nova", role: "Coder", description: "Hello I am Nova Zephyr Ashwolf!, I am an 18 year old Software Engineer who programs for Friday Night Funkin' mods.", link: "about:blank"},
    {name: "Krisyphuss", image: "kris", role: "I have no idea", description: "???", link: "about:blank"},
    {name: "zseven", image: "zseven", role: "zseven", description: "zseven", link: "about:blank"},
    {name: "Protosszog", image: "proto", role: "Artwork?", description: "???", link: "about:blank"},
    {name: "Razky", image: "razky", role: "Artwork", description: "???", link: "about:blank"}
];

var creditImages = [];

var creditsfinale = false;

var subtitleText:FunkinText;

function create() {
    if (!creditsfinale) {
        window.title = "Friday Night Funkin': This GC's Insanity | Credits";
        CoolUtil.playMusic(Paths.music('credits'), false, 1, true, 102);
    }
    else if (creditsfinale) {
        window.title = "Friday Night Funkin': This GC's Insanity | The End.";
        CoolUtil.playMusic(Paths.music('endcredits'), false, 1, true, 102);
    }
    
    var bg = new FlxSprite().loadGraphic(Paths.image("menus/credits/scroll1"));
    bg.scrollFactor.set();
	add(bg);

	var gridig = new FlxSprite().loadGraphic(Paths.image("menus/credits/gridthing"));
	gridig.alpha = 0.5;
    gridig.scrollFactor.set();
	add(gridig);

    var creditIndex = -1;

    for (credit in credits) {
        creditIndex++;

        var image = new FlxSprite(if (creditIndex % 2 == 0) FlxG.width * 0.05 else FlxG.width * 0.65, 20 + (creditIndex * 450)).loadGraphic(Paths.image("menus/credits/people/" + credit.image));
        if (image.graphic == null)
            image.loadGraphic(Paths.image("menus/credits/people/placeholder"));
        image.color = FlxColor.RED;
        creditImages.push(image);
        add(image);

        var nameText = new FunkinText(475, 200 + (creditIndex * 450), FlxG.width, credit.name, 45);
        add(nameText);

        var descText = new FunkinText(475, 250 + (creditIndex * 450), 450, credit.description, 40);
        add(descText);
    }

    topBar = new FlxSprite().makeGraphic(FlxG.width, 120, FlxColor.BLACK);
    topBar.scrollFactor.set();
    topBar.visible = creditsfinale;
    add(topBar);

    bottomBar = new FlxSprite().makeGraphic(FlxG.width, 120, FlxColor.BLACK);
    bottomBar.y = FlxG.height - 120;
    bottomBar.scrollFactor.set();
    bottomBar.visible = creditsfinale;
    add(bottomBar);


    subtitleText2 = new FunkinText(0,40,0,"",42,true);
    subtitleText2.screenCenter(0x01);
    subtitleText2.scrollFactor.set();
    subtitleText2.color = 0xff1100;
    subtitleText2.borderSize = 2;
    subtitleText2.alignment = "center";
    subtitleText2.visible = creditsfinale;
    add(subtitleText2);


    subtitleText = new FunkinText(0,FlxG.height - 90,0,"",42,true);
    subtitleText.screenCenter(0x01);
    subtitleText.scrollFactor.set();
    subtitleText.color = 0xff1100;
    subtitleText.borderSize = 2;
    subtitleText.visible = creditsfinale;
    add(subtitleText);

    var vignette = new FunkinSprite(0,0,Paths.image("menus/126"));
    vignette.screenCenter(0x11);
    vignette.visible = creditsfinale;
    vignette.scrollFactor.set();
    add(vignette);

    staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3]; 
    ntsc = new CustomShader("NTSCSFilter");
    if (!FlxG.save.data.noshaders) {
        FlxG.camera.addShader(staticshit);
        FlxG.camera.addShader(ntsc);
    }
    blackSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    blackSprite.alpha = 0.05;
    FlxFlicker.flicker(blackSprite, 999999999999);
    add(blackSprite);
    if (!creditsfinale) {
        vignette.destroy();
        subtitleText.destroy();
        subtitleText2.destroy();
        topBar.destroy();
        bottomBar.destroy();
    }
    
}
// literally all the fucking lyrics
function stepHit(curStep:Int) {
    if (creditsfinale) {
        switch(curStep) {
            case 211:
                changeSubs("Oh...");
            case 219:
                changeSubs("How sweet...");
            case 230:
                changeSubs("A bitter defeat...");
            case 247:
                changeSubs("At hands of all of us");
            case 273:
                changeSubs("and all of me");
            case 297:
                changeSubs("and after its over");
            case 307:
                changeSubs("and after the fight");
            case 317:
                changeSubs("and the curtain has closed");
            case 330:
                changeSubs("so when the script is may true");
            case 350:
                changeSubs("complete removal of you");
            case 373:
                changeSubs("is the outcome...");
            case 405:
                changeSubs("is this really the outcome...?");
            case 450:
                changeSubs("");
            case 489:
                changeSubs("but will it be the same?");
            case 522:
                changeSubs("with you gone...");
            case 543:
                changeSubs("");
            case 547:
                changeSubs("It's a MAD MAD world...");
            case 587:
                changeSubs("It's a MAAAAAAD world...");
            case 621:
                changeSubs("");
            case 629:
                changeSubs("It's a MAD MAD world...");
            case 664:
                changeSubs("...");
            case 672:
                changeSubs("without");
            case 681:
                changeSubs("without you");
            case 691:
                changeSubs("");
            case 714:
                changeSubs("The stage is set");
            case 727:
                changeSubs("but our players have all gone home...");
            case 755:
                changeSubs("Our great production");
            case 770:
                changeSubs("OUR WORLD");
            case 778:
                changeSubs("and yet im alone...");
            case 797:
                changeSubs("You've met your maker...");
            case 818:
                changeSubs("I've said my piece...");
            case 852:
                changeSubs("so why wont this feeling cease...?");
            case 892:
                changeSubs("and so it clutches around my soul...");
            case 935:
                changeSubs("I feel the bitter everlasting cold...");
            case 976:
                changeSubs("is this what i wanted?");
                subtitleText.size = 30;
                subtitleText2.size = 30;
            case 1001:
                changeSubs("am i satisfied?");
            case 1021:
                changeSubs("and now im standing tall yet all i want to do");
            case 1054:
                changeSubs("is hide inside");
            case 1075:
                changeSubs("this empty shell");
            case 1096:
                changeSubs("this husk");
            case 1106:
                changeSubs("this world");
            case 1118:
                changeSubs("this empty hell...");
            case 1140:
                changeSubs("I wander through");
            case 1159:
                changeSubs("my song reigns true");
            case 1181:
                changeSubs("the world is mad");
            case 1202:
                changeSubs("and i am too");
            case 1227:
                changeSubs("without");
            case 1232:
                changeSubs("without you...");
            case 1247:
                changeSubs("");
        }
    }
}

function changeSubs(newShit:String) {
    subtitleText.text = "";
    subtitleText.text = newShit;
    subtitleText.screenCenter(0x01);
    subtitleText2.text = "";
    subtitleText2.text = newShit;
    subtitleText2.screenCenter(0x01);
}
function update(elapsed) {
    FlxG.camera.shake(0.00025, 999999999999);
    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];
    if (ntsc != null)
        ntsc.data.uFrame.value = [Conductor.songPosition];
    var creditIndex = -1;

    for (img in creditImages) {
        creditIndex++;

        if (FlxG.mouse.overlaps(img) && !creditsfinale) {
            img.alpha = 1;
            if (FlxG.mouse.justPressed)
                CoolUtil.openURL(credits[creditIndex].link);
        } else {
            img.alpha = 0.85;
        }
    }
    
    if (creditsfinale) {
        FlxG.camera.scroll.y += 0.15;
    }
    if (!creditsfinale) {
        if (FlxG.mouse.wheel > 0 && FlxG.camera.scroll.y > -250) {
            FlxG.camera.scroll.y -= 25;
        }   
        if (FlxG.mouse.wheel < 0 && FlxG.camera.scroll.y < 3650) {
            FlxG.camera.scroll.y += 25;
        } 
    }
	if (controls.BACK && !creditsfinale) FlxG.switchState(new MainMenuState());
}