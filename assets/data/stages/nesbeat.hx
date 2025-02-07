// {IMPORTS}
import flixel.FlxObject;

// {VARIABLES}
var curChar:Int = 0;
var charshidden:Bool = true;
var nesTweens:Array<FlxTween> = [];
var eventTweens:Array<FlxTween> = [];
var ycbuLightningL:FlxSprite;
var ycbuLightningR:FlxSprite;
var ycbuHeadL:FlxSprite;
var ycbuHeadR:FlxSprite;
var estatica:FlxSprite;
var val:Float = 0;
var endingnes:Bool = false;
var blackinfrontobowser:FlxSprite;
var ycbuWhite:FlxSprite;

var ycbuIconPos1 = new FlxPoint(0, 0);
var ycbuIconPos2 = new FlxPoint(-85, 50);
var ycbuIconPos3 = new FlxPoint(-85, -50);

var jpeg;

function postCreate() {
    // Center stuff
    bars.screenCenter();
    dad.screenCenter();
    boyfriend.screenCenter();
    // Hide all characters
    dad.visible = false;
    boyfriend.visible = false;
    gf.visible = false;
    gf.x += 500;
    // Hide hud
    camHUD.alpha = 0;
    // trigger the tween abomination
    lofiTweensToBeCreepyTo();
    // setup some other shit
    /* TO DO: Convert to FlxSprite
    ycbuLightningL = new FlxSprite('mario/beatus/ycbu_lightning', 0, 0, 1, 1, ['lightning'], true);
	ycbuLightningL.animation.addByPrefix('idle', "lightning", 15, true);
	ycbuLightningL.animation.play('idle', true);
	ycbuLightningL.screenCenter(XY);
	ycbuLightningL.x -= 440;
	ycbuLightningL.antialiasing = ClientPrefs.globalAntialiasing;
	ycbuLightningL.visible = false;
	ycbuLightningL.cameras = [camOther];
	add(ycbuLightningL);

	ycbuLightningR = new BGSprite('mario/beatus/ycbu_lightning', 0, 0, 1, 1, ['lightning'], true);
	ycbuLightningR.animation.addByPrefix('idle', "lightning", 15, true);
	ycbuLightningR.flipY = true;
	ycbuLightningR.animation.play('idle', true);
	ycbuLightningR.screenCenter(XY);
	ycbuLightningR.x += 455;
	ycbuLightningR.antialiasing = ClientPrefs.globalAntialiasing;
	ycbuLightningR.visible = false;
	ycbuLightningR.cameras = [camOther];
	add(ycbuLightningR);
    */
	ycbuCrosshair = new FlxSprite().loadGraphic(Paths.image('stages/beatus/duckCrosshair'));
	ycbuCrosshair.scale.set(28, 28);
	ycbuCrosshair.screenCenter();
	ycbuCrosshair.cameras = [camHUD];
	ycbuCrosshair.visible = false;
	add(ycbuCrosshair);
    estatica = new FlxSprite();
	estatica.frames = Paths.getSparrowAtlas('menus/Mario_static');
	estatica.animation.addByPrefix('idle', "static play", 13);
	estatica.animation.play('idle');
	estatica.antialiasing = false;
	estatica.cameras = [camHUD];
	estatica.alpha = 0;
	estatica.updateHitbox();
	estatica.screenCenter();
	add(estatica);
    // setup stage stuff
    // {ACT 2}
    tree.antialiasing = false;
    grass.antialiasing = false;
    arbust.antialiasing = false;
	thecenter = new FlxObject(0,0,10,10);
	thecenter.screenCenter(0x11);
	add(thecenter);
	camGame.follow(thecenter);
	duckbg = new FlxSprite(0,0).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFF5595DA);
	duckbg.screenCenter(0x11);
	duckbg.alpha = 0;
	insert(tree, duckbg);
	boyfriend.y -= 70;
	//le shaders
	ntsc = new CustomShader("NTSCSFilter");
	camHUD.addShader(ntsc);
	camGame.addShader(ntsc);
}
function onEvent(e) {
	if (e.event.name == "Camera Movement") {
		estatica.alpha = 0.6;
		FlxTween.tween(estatica, {alpha: 0}, 0.2, {ease: FlxEase.circIn});
	}
}
function postUpdate(elapsed) {
	if (ntsc != null)
        ntsc.uFrame = Conductor.songPosition;
    if (charshidden != true) {
        if (curCameraTarget == 1) {
            dad.visible = false;
            boyfriend.visible = true;
            gf.visible = true;
        }
        else if (curCameraTarget == 0) {
            dad.visible = true;
            boyfriend.visible = false;
            gf.visible = false;
        }
    }
    else if (charshidden == true) {
        dad.visible = false;
        boyfriend.visible = false;
        gf.visible = false;
    }
}


// Hscript call to make the characters invisible or visible
function toggleChars(toggle:String) {
    if (toggle == "true") {
        charshidden = true;
    }
    else if (toggle == "false") {
        charshidden = false;
    }
}


// HScript call to change the section
function changecursection(section:String) {
	var num = Std.parseInt(section);
	switch(num) {
		case 0:
			trace("reset stage to act mr KYS");
        	bars.visible = true;
		case 1:
			trace("not done section 1 yet");
        	bars.visible = false;
			for (i in [tree,grass,duckbg]) FlxTween.tween(i, {alpha: 1}, 1.2, {ease: FlxEase.quartInOut});
			dad.y += dad.height;
		case 2:
			trace("not done section 2 yet");
		case 3:
			trace("not done section 3 yet");
	}
}
function stepHit(curStep:Int) {
	if (curStep == 1802) {
		eventTweens.push(FlxTween.tween(dad, {y: dad.y - dad.height}, 2, {ease: FlxEase.backOut}));
	}
}
// tweens around the bg dont touch this shit its disgusting
function lofiTweensToBeCreepyTo():Void
{
	var tempx = bars.x;
	// im going to kill myself - Hazel
	// this tween chain is an abomination
	nesTweens.push(FlxTween.tween(bars, {x: tempx + 420, angle: -35}, 4.0, {
		onComplete: function(tween:FlxTween)
		{
			nesTweens.push(FlxTween.tween(bars, {angle: 20}, 2.0, {
				onComplete: function(tween:FlxTween)
				{
					nesTweens.push(FlxTween.tween(bars, {x: tempx + 400, angle: 30}, 2.0, {
						onComplete: function(tween:FlxTween)
						{
							nesTweens.push(FlxTween.tween(bars, {x: tempx + 420, angle: 0}, 2.0, {
								onComplete: function(tween:FlxTween)
								{
									nesTweens.push(FlxTween.tween(bars, {x: tempx + 520, angle: -15}, 3.0, {
										onComplete: function(tween:FlxTween)
										{
											nesTweens.push(FlxTween.tween(bars, {angle: 10}, 1.5, {
												onComplete: function(tween:FlxTween)
												{
													nesTweens.push(FlxTween.tween(bars, {x: tempx - 50, angle: -40}, 5.5, {
														onComplete: function(tween:FlxTween)
														{
															nesTweens.push(FlxTween.tween(bars, {x: tempx, angle: 0}, 1.5, {
                                                                onComplete: function(tween:FlxTween)
                                                                {
                                                                    lofiTweensToBeCreepyTo();
                                                                }
                                                            }));
														}
													}));
												}
											}));
										}
									}));
								}
							}));
						}
					}));
				}
			}));
		}
	}));
}