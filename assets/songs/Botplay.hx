import funkin.backend.chart.Chart;
static var taikiIcon:FunkinSprite;
static var normalbotplayIconMovement:Bool = true;
static var botplay:Bool = FlxG.save.data.botplay;
static var botplayhealthOverlay:FunkinSprite;
function postCreate() {
	taikiIcon = new FunkinSprite(0,0,Paths.image('game/botplay/taiki' /*+ plus*/ /*add the thing later thx*/));
	taikiIcon.scrollFactor.set();
	taikiIcon.scale.set(0.3, 0.3);
	taikiIcon.updateHitbox();
	taikiIcon.screenCenter(0x01);
	taikiIcon.y += 70;
	taikiIcon.visible = false;
    taikiIcon.cameras = [camHUD];
	add(taikiIcon);
    botplayhealthOverlay = new FunkinSprite(healthOverlay.x,healthOverlay.y,Paths.image('game/botplay/healthBar'));
    botplayhealthOverlay.visible = false;
    botplayhealthOverlay.cameras = [camHUD];
    insert(members.indexOf(iconP1), botplayhealthOverlay);
}
var botplaySine = 0;
function onSongStart() {
    if (FlxG.save.data.nohealthbar || !customHUDEnabled) botplayhealthOverlay.visible = false;
    player.cpu = botplay;
    validscore = !botplay;
    changeui();
}
function postUpdate() {
    if (startingSong) {
        botplayhealthOverlay.visible = healthOverlay.visible;
        botplayhealthOverlay.alpha = healthOverlay.alpha;
        botplayhealthOverlay.x = healthOverlay.x;
        botplayhealthOverlay.y = healthOverlay.y;
    }
    
}
function update(elapsed) {
    if (FlxG.keys.justPressed.NINE) {
        validScore = false;
        if (botplay) {
            player.cpu = false;
            botplay = false;
        }
        else if (!botplay) {
            player.cpu = true;
            botplay = true;
        }
        changeui();
        FlxG.save.data.botplay = botplay;
    }
    if (botplay && normalbotplayIconMovement) {
        botplaySine += 180 * elapsed;
		taikiIcon.angle = ((1 - Math.sin((Math.PI * botplaySine) / 180)) * 20) - 20;
    }
}

function changeui() {
    if (customHUDEnabled) {
        if (botplay) {
            if (timeBar != null) timeBar.createFilledBar(0xFF000000,0xFFff4040,false);
            healthOverlay.visible = false;
            // Change noteskin event created by unplugged_computer
        }
        if (!botplay) {
            if (timeBar != null) timeBar.createFilledBar(0xFF000000,0xFF0023CC,false);
            // Change noteskin event created by unplugged_computer
            healthOverlay.visible = true;
        }
        taikiIcon.visible = botplay;
        botplayhealthOverlay.visible = botplay;
    }
}