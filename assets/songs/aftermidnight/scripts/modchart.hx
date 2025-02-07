import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;
function create() {
    customHUDEnabled = false;
    usecustomnoteskin = false;
    introLength = 0;
}
function postCreate() {
    ourplehpBG = new FunkinSprite(healthBarBG.x,healthBarBG.y,Paths.image("stages/afmbar/ui/healthBar"));
    ourplehpBG.cameras = [camHUD];
    ourplehpBG.screenCenter(0x01);
    
    ourplehp = new FlxBar(ourplehpBG.x+5,ourplehpBG.y+5,FlxBarFillDirection.RIGHT_TO_LEFT,ourplehpBG.width-7,ourplehpBG.height-10);
    ourplehp.setRange(0, 2);
    ourplehp.cameras = [camHUD];
    ourplehp.numDivisions = healthBar.numDivisions;
    if (cpu.characters[0].iconColor == null || player.characters[0].iconColor == null) ourplehp.createFilledBar(FlxColor.RED, FlxColor.LIME);
    else ourplehp.createFilledBar(cpu.characters[0].iconColor, player.characters[0].iconColor);
    insert(members.indexOf(iconP1),ourplehp);
    insert(members.indexOf(iconP1), ourplehpBG);
    ourplehp.value = health;
    iconP2.x = ourplehpBG.x - 120;
    iconP2.y = FlxG.height - 150;
    iconP1.x = ourplehpBG.x + 520;
    iconP1.y = iconP2.y;
    pizza1 = new FunkinSprite(iconP2.x,iconP2.y,Paths.image('stages/afmbar/ui/pizza'));
    pizza1.cameras = [camHUD];
    insert(members.indexOf(iconP1), pizza1);
    pizza2 = new FunkinSprite(iconP1.x,iconP1.y,Paths.image('stages/afmbar/ui/pizza'));
    pizza2.cameras = [camHUD];
    insert(members.indexOf(iconP1), pizza2);
    ourpleScoreTxt = new FunkinText(0,0,0,"Score:\n0",52,true);
    ourpleScoreTxt.font = Paths.font("ourplescore.ttf");
    ourpleScoreTxt.screenCenter(0x01);
    ourpleScoreTxt.y += 50;
    ourpleScoreTxt.cameras = [camHUD];
    ourpleScoreTxt.alignment = 'center';
    add(ourpleScoreTxt);
}
function onSongStart() {
    healthBarBG.visible = statsTxt.visible = healthBar.visible = false;
}
function onNoteHit() {
    ourplehp.value = health;
    ourpleScoreTxt.text = 'Score:\n'+songScore;
}
function onPlayerHit() {
    textBump();
}
function textBump() {
    ourpleScoreTxt.scale.set(1.2,1.2);
}
function onPlayerMiss() {
    ourplehp.value = health;
}
function onNoteCreation(event) {
    event.noteSprite = 'game/notes/ourple';
}
function onStrumCreation(event) {
    event.sprite = 'game/notes/ourple';
}
function postUpdate(elapsed:Float) {
    ourpleScoreTxt.scale.set(FlxMath.lerp(ourpleScoreTxt.scale.x, 1, 0.1),FlxMath.lerp(ourpleScoreTxt.scale.y, 1, 0.1));
    iconP2.x = ourplehpBG.x - 120;
    iconP2.y = FlxG.height - 150;
    iconP1.x = ourplehpBG.x + 520;
    iconP1.y = iconP2.y;
}