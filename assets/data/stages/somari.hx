import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxAxes;
function postCreate() {
    bgstars = new FlxBackdrop(Paths.image('stages/Somari/bgstars'));
	bgstars.frames = Paths.getSparrowAtlas('stages/Somari/bgstars');
	bgstars.animation.addByPrefix('idle', 'bgstars flash', 6, true);
	bgstars.animation.play('idle');
	bgstars.repeatAxes = FlxAxes.x;
	bgstars.scale.set(4,4);
	bgstars.updateHitbox();
	bgstars.scrollFactor.set(0, 0);
	bgstars.velocity.set(-20, 0);
    bgstars.antialiasing = false;
	bgstars.y += 190;
	insert(bg,bgstars);
	building.frames = Paths.getSparrowAtlas('stages/Somari/buildings_papu');
	building.animation.addByPrefix('idle1', "buildings papu color0001", 1, true);
	building.animation.addByPrefix('idle2', "buildings papu color0002", 1, true);
	building.animation.addByPrefix('idle3', "buildings papu color0003", 1, true);
	building.animation.play('idle1');
	lightshit = new FunkinSprite(building.x+20,building.y,Paths.image("stages/Somari/spot"));
	lightshit.animation.addByPrefix('spot0', "spot 0", 1, true);
	lightshit.animation.addByPrefix('spot1', "spot 1", 1, true);
	lightshit.animation.addByPrefix('spot2', "spot 2", 1, true);
	lightshit.animation.addByPrefix('spot3', "spot 3", 1, true);
	lightshit.animation.play('spot0');
	lightshit.antialiasing = false;
	lightshit.scale.set(4,4);
	lightshit.visible = false;
	add(lightshit);
	camGame.followLerp = 1.0;
}
function beatHit(curBeat:Int) {
	gfstagechar.animation.play("idle");
	building.animation.play('idle'+FlxG.random.int(1,3));
}
function update() {
	if (camGame.zoom > 1) camGame.zoom = defaultCamZoom;
}
function stepHit(curStep:Int) {
	switch(curStep) {
		case 896:
			lightshit.visible = true;
			lightshit.animation.play("spot1");
		case 912:
			lightshit.animation.play("spot2");
		case 928:
			lightshit.animation.play("spot1");
		case 945:
			lightshit.animation.play("spot2");
		case 960:
			lightshit.animation.play("spot1");
		case 976:
			lightshit.animation.play("spot2");
		case 992:
			lightshit.animation.play("spot1");
		case 1015:
			lightshit.animation.play("spot3");
		case 1024:
			lightshit.visible = false;
		case 1120:
			lightshit.visible = true;
			lightshit.animation.play("spot1");
		case 1143:
			lightshit.animation.play("spot3");
		case 1152:
			lightshit.visible = false;
		case 1408:
			lightshit.visible = true;
			lightshit.animation.play("spot2");
		case 1472:
			lightshit.animation.play("spot3");
		case 1535:
			lightshit.animation.play("spot0");
	}
}