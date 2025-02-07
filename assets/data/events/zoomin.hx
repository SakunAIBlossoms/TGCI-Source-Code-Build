
var ogcamzoom:Float;
function postCreate() {
    ogcamzoom = defaultCamZoom;
}

function onEvent(e) {
    if (e.event.name == "zoomin") {
        var params:Array = e.event.params;
        if (params[1]) defaultCamZoom = ogcamzoom;
        if (!params[1]) defaultCamZoom = params[0];
    }
}