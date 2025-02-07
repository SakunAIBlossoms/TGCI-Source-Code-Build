import flixel.FlxObject;
var altanimon = false;
function create() {
    introLength = 0;
}
function postCreate() {
    elfin.cameras = [camHUD];
    elfin.setGraphicSize(1280);
	elfin.updateHitbox();
	elfin.screenCenter();
    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
	blackBarThingie.alpha = 1;
    blackBarThingie.cameras = [camHUD];
    blackBarThingie.screenCenter(0x11);
    insert(elfin,blackBarThingie);
    letsago.cameras = [camHUD];
    letsago.screenCenter(0x11);
    centercam = new FlxObject(0,0,10,10);
    centercam.screenCenter(0x11);
    add(centercam);
}
function beatHit(curBeat:Int) {
    switch(curBeat) {
        case 4: 
            FlxTween.tween(elfin, {alpha: 1}, 2);
            //funnylayer0.alpha = 0;
        case 12:
            FlxTween.tween(elfin, {alpha: 0}, 4);
        case 32:
            blackBarThingie.alpha = 0.6;
            elfin.destroy();
        case 142:
            //FlxTween.tween(blackBarThingie, {alpha: 1}, 0.8);
        case 145:
            letsago.alpha = 1;
			letsago.animation.play('go');
        case 150:
            letsago.alpha = 0;
            letsago.destroy();
            //FlxTween.tween(blackBarThingie, {alpha: 0.6}, 0.8);
        case 369:
            // wahooo!
            for (stage in [bg, floor, mesa, castle0]) stage.destroy();
            boyfriend.visible = false;
            dad.screenCenter(0x11);
            camGame.follow(centercam);
    }
}