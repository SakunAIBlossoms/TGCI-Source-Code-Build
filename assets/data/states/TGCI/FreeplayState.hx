import funkin.menus.MainMenuState;
import haxe.Json;
import openfl.Assets;

var songText;
var freeplayPortraits = [];

var curSelected = 0;
var freeplaySongList;

function create() {
    CoolUtil.playMenuSong(true);

    freeplaySongList = Json.parse(Assets.getText(Paths.json("config/tgciFreeplay")));

    var estatica = new FlxSprite();
	estatica.frames = Paths.getSparrowAtlas('menus/estatica_uwu');
	estatica.animation.addByPrefix('idle', "Estatica papu", 15);
	estatica.animation.play('idle');
	estatica.color = FlxColor.RED;
	estatica.alpha = 0.7;
	estatica.scrollFactor.set();
	estatica.updateHitbox();
	add(estatica);

    var songIndex = -1;

    for (song in freeplaySongList.songs) {
        songIndex++;
        
        var spr = new FlxSprite().loadGraphic(Paths.image("menus/freeplay/charicon/" + song.icon));
        spr.color = FlxColor.RED;
        spr.screenCenter();
        spr.x += songIndex * 430;
        spr.ID = songIndex;
        freeplayPortraits.push(spr);
        add(spr);
    }

    songText = new FunkinText(0, FlxG.height * 0.85, FlxG.width, "Fortnite", 30);
    songText.alignment = "center";
    songText.color = FlxColor.RED;
    songText.scrollFactor.set();
    add(songText);

    var select = new FlxSprite(0, 20).loadGraphic(Paths.image("menus/freeplay/HUD_Freeplay_1"));
    FlxTween.tween(select, {y: 30}, 1.5, {ease: FlxEase.sineIn, type: 4});
    select.screenCenter(0x01);
    select.color = FlxColor.RED;
    select.scale.set(0.85, 0.85);
    select.scrollFactor.set();
    add(select);

    var fuck = new FlxSprite().loadGraphic(Paths.image("menus/freeplay/HUD_Freeplay_2"));
    fuck.color = FlxColor.RED;
    fuck.alpha = 0.4;
    fuck.screenCenter();
    fuck.scrollFactor.set();
    add(fuck);
}
function update(elapsed) {
	FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.015, (1/30)*240*elapsed);
    for (spr in freeplayPortraits) {
        if (curSelected != spr.ID) {
            spr.alpha = 0.6;
        } else {
            spr.alpha = 1;
            FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, freeplayPortraits[curSelected].getMidpoint().x - 645, 0.095);
        }

        if (FlxG.mouse.overlaps(spr) && FlxG.mouse.justPressed) {
            if (spr.ID == curSelected) {
                PlayState.loadSong(freeplaySongList.songs[curSelected].filename, if (freeplaySongList.songs[curSelected].difficulty == null) "normal" else freeplaySongList.songs[curSelected].difficulty, false, false);
                FlxG.switchState(new PlayState());
            }

            curSelected = spr.ID;
            trace(freeplaySongList.songs[curSelected].desc);
        }

        if (controls.BACK)
        {
            CoolUtil.playMenuSFX(2, 10);
            FlxG.switchState(new MainMenuState());
        }
    }

    songText.text = freeplaySongList.songs[curSelected].displayname;
}