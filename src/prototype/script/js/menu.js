/**
 * Menu singleton (vic nez jedno menu neni zapotrebi).
 */
var Menu = new function() {
    this.reload = function() {
        alert("loading");
        AJAX.loadPage(new AJAXParams("script/php/", "menu.php", null, this.onAjaxLoadedOk, this.onAjaxLoadedError));
    }

    this.onAjaxLoadedOk = function(request) {
        Frames.MENU.innerHTML = request.responseText;
    }
    
    this.onAjaxLoadedError = function(request) {
        Frames.MENU.innerHTML = "Menu loading error";
    }
}