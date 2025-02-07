//  {IMPORTS}
import funkin.menus.MainMenuState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText.FlxTextBorderStyle;
import flixel.text.FlxText.FlxTextFormat;
import flixel.effects.FlxFlicker;
//  {VARIABLES}
var verBoxes:FlxTypedGroup<FlxSprite>;
var verSprites:FlxTypedGroup<FlxSprite>;
var pageBar:FlxSprite;
var bg:FlxSprite;
var noteText:FlxText;
var descText:FlxText;
var mousey:Float = 0;
var ogTexty:Float = 0;
var wheely:Float = 0;
var isdrag:Bool = false;
var iswheel:Bool = false;
var canScroll:Bool = false;
var staticShader, ntsc:CustomShader = null;

function create() {

    patchInfo = Json.parse(Assets.getText(Paths.json("config/patchnotes/patchNotes")));

    FlxG.mouse.visible = true;

    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/patchnotes/Patch/patch0'));
    bg.antialiasing = true;
    bg.updateHitbox();
    bg.screenCenter(0x11);
    add(bg);

    pageBar = new FlxSprite().makeGraphic(20, 720, FlxColor.WHITE);
	pageBar.alpha = 0.7;
	pageBar.x += 1270;
	pageBar.visible = false;
	add(pageBar);

    noteText = new FlxText(500, 30, 700, "Example Text", 28);
	noteText.setFormat(Paths.font("ModernDOS.ttf"), 36, FlxColor.WHITE, "LEFT", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	add(noteText); 
	noteText.visible = false;
	noteText.text = '';

    verSprites = new FlxTypedGroup();
	add(verSprites);

	verBoxes = new FlxTypedGroup();
	add(verBoxes);

    var patchIndex = -1;

    for(patch in patchInfo.patchs){
        patchIndex++;
        var verSquare = new FlxSprite(10, 20).loadGraphic(Paths.image('menus/patchnotes/Patch/patch1'));
        verSquare.antialiasing = true;
        verSquare.updateHitbox();
        verSquare.y += (verSquare.height * patchIndex) + 20;
        verSquare.ID = patchIndex;
        verSprites.add(verSquare);

        var format = new FlxTextFormat(FlxColor.RED, false, false, FlxColor.RED);
        format.leading = 10;

        var verText:FlxText = new FlxText(0, 680, 1280, "2.0.0\n01/01/2024", 16);
        verText.setFormat(Paths.font("mariones.ttf"), 24, FlxColor.RED, "LEFT");
        verText.scrollFactor.set(0.2, 0.2);
        verText.ID = patchIndex;
        verText.setPosition(verSquare.x + 30, verSquare.y + 40);
        verText.text = patch.version1 + '\n' + patch.version2 + '\n ';
        add(verText);

        verText.addFormat(format);

        var box = new FlxSprite().makeGraphic(Std.int(verSquare.width), Std.int(verSquare.height), FlxColor.WHITE);
        box.ID = patchIndex;
        box.alpha = 0;
        box.setPosition(verSquare.x, verSquare.y);
        verBoxes.add(box);

        var bgB = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bgB.alpha = 1;
		bgB.scrollFactor.set();
		add(bgB);

        FlxTween.tween(bgB, {alpha: 0}, 0.5);
    }
    blackSprite = new FlxSprite().makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
    blackSprite.alpha = 0.05;
    FlxFlicker.flicker(blackSprite, 999999999999);
    add(blackSprite);
    
    staticshit = new CustomShader("TGStatic");
	staticshit.data.strengthMulti.value = [0.5];
	staticshit.data.imtoolazytonamethis.value = [0.3];  
    
    ntsc = new CustomShader("NTSCSFilter");
    if (!FlxG.save.data.noshaders) {
        FlxG.camera.addShader(staticshit);
        FlxG.camera.addShader(ntsc);
    }
}

function update() {
    FlxG.camera.shake(0.00025, 999999999999);

    if (ntsc != null)
        ntsc.data.uFrame.value = [Conductor.songPosition];
    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];
    verBoxes.forEach(function(box:FlxSprite)
    {
        if(FlxG.mouse.overlaps(box)){
            verSprites.forEach(function(sprite:FlxSprite)
                {
                    if(sprite.ID == box.ID) sprite.color = 0xFF0000;
                });
            if(FlxG.mouse.justPressed) changePatchNotes(box.ID);
        }else{
            verSprites.forEach(function(sprite:FlxSprite)
                {
                    if(sprite.ID == box.ID) sprite.color = 0x690000;
                });
        }
    });

    if (controls.BACK) {
        CoolUtil.playMenuSFX(2, 10);
        FlxG.switchState(new MainMenuState());
    }
}

function changePatchNotes(ver:Int) {
    //FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
    noteText.text = Assets.getText(Paths.txt('config/patchnotes/' + patchInfo.patchs[ver].file));
    noteText.visible = true;
    noteText.y = 30;
    pageBar.visible = true;
    
    if(noteText.height > FlxG.height){
        if(noteText.height > 1390){
            pageBar.setGraphicSize(Std.int(pageBar.width), 50);
        }else{
            pageBar.setGraphicSize(Std.int(pageBar.width), Std.int(pageBar.height - (noteText.height - 720)));
            pageBar.y = 0;
            trace(pageBar.height - (noteText.height - 720));
        }
        pageBar.updateHitbox();
        canScroll = true;
    }else{
        pageBar.visible = false;
        canScroll = false;
    }
}