var showChars:Bool = true;
function update() {
    if (showChars) {
        if (curCameraTarget == 1) {
            boyfriend.visible = true;
            dad.visible = false;
        }
        else if (curCameraTarget == 0) {
            boyfriend.visible = false;
            dad.visible = true;
        }
    }
    else if (!showChars) {
        boyfriend.visible = false;
        dad.visible = false;
    }
}
function hideChars(toggle:String) {
    if (toggle == "true") {
        showChars = false;
    }
    else if (toggle == "false") {
        showChars = true;
    }
}