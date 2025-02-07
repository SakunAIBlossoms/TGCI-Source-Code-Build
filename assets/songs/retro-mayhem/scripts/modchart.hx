var eventTweens:Array<FlxTween> = [];
var extraTween:Array<FlxTween> = [];
var hudTween:FlxTween;
var noteAR1:Array<Float> = [];
var noteAR2:Array<Float> = [];
if (extraTween != null) { for (tween in extraTween) tween.active = false; }
if (eventTweens != null) { for (tween in eventTweens) tween.active = true; }

function postCreate() {
    //importScript("data/scripts/modchartManager.hx");
    //setupModifiers();
    //setupEvents();
    //initModchart();
}
function beatHit(curBeat:Int) {
    if (healthBar.percent > 80)
    {
        eventTweens.push(FlxTween.angle(iconP2, -40, -20, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.backOut}));
    }
    else
    {
        iconP2.angle = 0;
    }
    if(curBeat >= 91 && curBeat < 120){
        for (tween in extraTween)
            {
                tween.cancel();
            }
        if(curBeat %2 == 0){
            extraTween.push(FlxTween.tween(camHUD, {angle: -3}, (0.1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoOut, onComplete: function(twn:FlxTween)
                {
                    extraTween.push(FlxTween.tween(camHUD, {angle: 0}, (0.9 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoIn, type: FlxTween.PINGPONG}));
                }}));
        }else{
        extraTween.push(FlxTween.tween(camHUD, {angle: 3}, (0.1 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
            {
                extraTween.push(FlxTween.tween(camHUD, {angle: 0}, (0.9 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.expoIn}));
            }}));
        }
    }
    if(curBeat >= 149 && curBeat < 207){
        for (tween in extraTween)
            {
                tween.cancel();
            }
        if(curBeat %2 == 0){
            extraTween.push(FlxTween.tween(camHUD, {x: -30, y: -30}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                {
                    extraTween.push(FlxTween.tween(camHUD, {x: 0, y: 0}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadIn}));
                }}));
        }else{
        extraTween.push(FlxTween.tween(camHUD, {x: 30, y: -30}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
            {
                extraTween.push(FlxTween.tween(camHUD, {x: 0, y: 0}, (0.5 * (1 / (Conductor.bpm / 60))), {ease: FlxEase.quadIn}));
            }}));
        }
        for(s in strumLines) {
            
        for (i in 0...4){
             var thenote:Int = i;
             var tdur:Float = (0.5 * (1 / (Conductor.bpm / 60)));
             var cpunotes = cpuStrums.members[i];
             var playernotes = playerStrums.members[i];
             noteAR1.push(cpuStrums.members[i].x);
             noteAR2.push(playerStrums.members[i].x);
             if(curBeat %2 == 0){
                extraTween.push(FlxTween.tween(playernotes, {x: noteAR2[i] - 30, y: strumLine.y -30}, tdur, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                    {
                        extraTween.push(FlxTween.tween(playernotes, {x: noteAR2[i], y: strumLine.y}, tdur, {ease: FlxEase.quadIn}));
                    }}));
                }else{
                extraTween.push(FlxTween.tween(playernotes, {x: noteAR2[i] + 30, y: strumLine.y -30}, tdur, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                    {
                        extraTween.push(FlxTween.tween(playernotes, {x: noteAR2[i], y: strumLine.y}, tdur, {ease: FlxEase.quadIn}));
                    }}));
                }
             if(curBeat %2 == 0){
             extraTween.push(FlxTween.tween(cpunotes, {x: noteAR1[i] - 30, y: strumLine.y -30}, tdur, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                 {
                     extraTween.push(FlxTween.tween(cpunotes, {x: noteAR1[i], y: strumLine.y}, tdur, {ease: FlxEase.quadIn}));
                 }}));
             }else{
             extraTween.push(FlxTween.tween(cpunotes, {x: noteAR1[i] + 30, y: strumLine.y -30}, tdur, {ease: FlxEase.quadOut, onComplete: function(twn:FlxTween)
                 {
                     extraTween.push(FlxTween.tween(cpunotes, {x: noteAR1[i], y: strumLine.y}, tdur, {ease: FlxEase.quadIn}));
                 }}));
             }
        }
    }
}
}
function stepHit(curStep:Int) {
    if (curStep == 528) {
        camHUD.angle = 0;
    }
}
function setupModifiers()
{
    // Documentation is in https://github.com/TheZoroForce240/CNE-GPU-Modchart-Framework/blob/main/assets/songs/Bopeebo/scripts/modchart.hx
}

function setupEvents()
{
    // Documentation is in https://github.com/TheZoroForce240/CNE-GPU-Modchart-Framework/blob/main/assets/songs/Bopeebo/scripts/modchart.hx
}

/* Original MMv2 code (has to be ported to the new modcharting framework)
function modchart() {
    var counter:Int = 0;
    numericForInterval(656, 912, 2, function(step){
        
        if(counter == 0){
        for(i in 0...4){
        modManager.queueSet(step, "mini"+ i + "X", -0.5);
        modManager.queueSet(step, "mini"+ i + "Y",  0.5);
        modManager.queueSet(step, "transform"+ i + "Y",  30);
        modManager.queueEase(step, step + 2, "transform" + i + "Y", -30, 'quadOut');
        modManager.queueEase(step, step+2, "mini"+ i + "X", 0, 'circOut');
        modManager.queueEase(step, step+2, "mini"+ i + "Y", 0, 'circOut');
        }
        counter = 1;
        }else{
        for(i in 0...4){
        modManager.queueEase(step, step + 2, "transform" + i + "Y", 0, 'quadIn');
        modManager.queueEase(step, step+2, "mini"+ i + "X", 0.3, 'circIn');
        modManager.queueEase(step, step+2, "mini"+ i + "Y", -0.3, 'circIn');
        }
        counter = 0;
        }
    });
    var counter2:Int = 0;
    numericForInterval(784, 912, 4, function(step){
        for(i in 0...4){
        modManager.queueEase(step, step + 4, "confusion" + i, modManager.randomFloat(-60, 60));
        }

        if(counter2 == 0){
            modManager.queueEase(step, step + 4, "opponentSwap", 0.05);
            counter2 = 1;
        }else{
            modManager.queueEase(step, step + 4, "opponentSwap", -0.05);
            counter2 = 0;
        }
    });
    for(i in 0...4){
    modManager.queueSet(912, "mini"+ i + "X", 0);
    modManager.queueSet(912, "mini"+ i + "Y", 0);
    modManager.queueSet(912, "transform" + i + "Y", 0);
    modManager.queueEase(912, 916, "confusion" + i, 0, 'backOut');
    modManager.queueEase(912, 916, "opponentSwap", 0, 'backOut');
    }
    var number:Int = 0;
    numericForInterval(944, 1168, 32, function(step){
        for(i in 0...8){
            if(number > 40){
                number = 40;
            }
            if(i < 4){
                modManager.queueEase(step + (i * 4), (step + (i * 4)) + 2, "transform" + i + "Y", number * -1, 'expoOut', 1);
                modManager.queueEase((step + (i * 4)) + 2, (step + (i * 4)) + 4, "transform" + i + "Y", 0, 'expoIn', 1);
            }else{
                modManager.queueEase(step + (i * 4), (step + (i * 4)) + 2, "transform" + (i - 4) + "Y", number * -1, 'expoOut', 0);
                modManager.queueEase((step + (i * 4)) + 2, (step + (i * 4)) + 4, "transform" + (i - 4) + "Y", 0, 'expoIn', 0);
            }
            number += 10;
        }
    });
}
*/