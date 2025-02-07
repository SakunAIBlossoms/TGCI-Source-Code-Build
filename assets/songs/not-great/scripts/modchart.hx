function create() {
	enableCameraHacks = false;
}

function postCreate() {

}

function scaryKYSguy() {
	trace("spawn the funny moving guys if it crashes haxe fucking sucks ass");
	//var spookyGuy = new FunkinSprite(0,0,Paths.file('images/stages/beatus/YouCannotBeatUS_Fellas_Assets.png'));
	var spookyGuy = new FlxAnimate(0,0,Paths.png('images/stages/beatus/YouCannotBeatUS_Fellas_Assets.png'));
	spookyGuy.screenCenter();
	//spookyGuy.animateAtlas = FlxAnimate(0,0,Paths.file('images/stages/beatus/YouCannotBeatUS_Fellas_Assets'));
	//trace(spookyGuy.getAnimName());
	add(spookyGuy);
}
function traceshit() {
	trace("traced something");
}
function postUpdate(elapsed) {
	

	//for(s in strumLines) {
	//	for(i in 0...4) {
	//		var n = s.members[i];
	//		n.angle = Math.sin(curBeatFloat + (i * 0.45)) * 35;
	//	}
	//}


	// for(s in strumLines) {
	// 	for(i in 0...4) {
	// 		var n = s.members[i];
	// 		n.y = FlxG.height - 200;
	// 		n.angle = 180;
	// 	}
	// }

	// if (curSection != null)
	//     defaultCamZoom = curSection.mustHitSection ? 0.9 : 0.5;
}