



function postCreate() {
	/*
    ytUI = new BGSprite('mario/Real/ytui', 0, 0, 0, 0);
	ytUI.antialiasing = ClientPrefs.globalAntialiasing;
	ytUI.alpha = 0;
	ytUI.setGraphicSize(Std.int(ytUI.width * 1.52));
	ytUI.updateHitbox();
	ytUI.screenCenter();
	add(ytUI);
	ytbutton = new BGSprite('mario/Real/button', 0, 0, 0, 0, ['button play'], true);
	ytbutton.antialiasing = ClientPrefs.globalAntialiasing;
	ytbutton.alpha = 0;
	ytbutton.animation.addByPrefix('play', 'button play', 1, false);
	ytbutton.animation.addByPrefix('pause', 'button pause', 1, false);
	ytbutton.setGraphicSize(Std.int(ytbutton.width * 1.52));
	ytbutton.updateHitbox();
	ytbutton.screenCenter();
	ytbutton.scale.set(0.8, 0.8);
	add(dadGroup);
	*/
	camBG = new FunkinSprite(1345, 636, Paths.image('stages/Real/facecam bg'));
	camBG.animation.addByPrefix('up', 'facecam bg up', 1, false);
	camBG.animation.addByPrefix('down', 'facecam bg down', 1, false);
	camBG.animation.addByPrefix('left', 'facecam bg left', 1, false);
	camBG.animation.addByPrefix('right', 'facecam bg right', 1, false);
	camBG.animation.play('down');
	camBG.screenCenter(0x11);
	add(camBG);
}