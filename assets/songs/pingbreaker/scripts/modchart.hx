

function create() {
    customHUDEnabled = false;
    usecustomnoteskin = false;
}
function postCreate() {
    
    botplayTxt = new FunkinText(0,0,0,"BOTPLAY",32,true);
    botplayTxt.cameras = [camHUD];
    botplayTxt.screenCenter(0x01);
    botplayTxt.y = 85;
    botplayTxt.x += 260;
    botplayTxt.visible = false;
    add(botplayTxt);
}
function postUpdate() {
    botplayTxt.visible = botplay;
}