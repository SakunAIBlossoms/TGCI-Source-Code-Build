import funkin.options.OptionsMenu;
import funkin.backend.system.framerate.Framerate;
import flixel.effects.FlxFlicker;
var staticShader, ntsc:CustomShader = null;
var shaders:Bool = FlxG.save.data.gameplayShaders;
function create() {
    CoolUtil.playMusic(Paths.music('options'), false, 1, true, 102);
}
function postCreate() {
    for (option in main.members)
        if (option.desc == "Modify mod options here")
            main.members.remove(option);
    staticThingy = new FlxSprite(0, 0);
	staticThingy.frames = Paths.getSparrowAtlas('menus/estatica_uwu');
    staticThingy.animation.addByPrefix('idle', "Estatica papu", 15);
	staticThingy.animation.play('idle');
    staticThingy.color = FlxColor.RED;
    staticThingy.screenCenter();
	staticThingy.scrollFactor.set();
    insert(1, staticThingy);
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
function update(elapsed){
    FlxG.camera.shake(0.00025, 999999999999);

    if (ntsc != null)
        ntsc.data.uFrame.value = [Conductor.songPosition];
    if (staticshit != null)
        staticshit.data.iTime.value = [Conductor.songPosition];
}