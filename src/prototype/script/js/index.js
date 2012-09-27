$(document).ready(function() {
    Frames.init();
    
    Menu.reload();
    
    navigate(PAGE_HOME, null);
    
});

/**
 * Funkce, ktera pomoci ajaxu nacte danou stranku a zobrazi ji v contentu.
 * Zaroven se stara o vse okolo, jako je zamykani obsahu pri nacitani apod.
 * @param page instance tridy Page, optimalni je pouzivat strankove konstanty
 * z tohoto scriptu (napr. PAGE_HOME, ...).
 * @param post post request, poslany spolecne s url.
 */
function navigate(page, post) {
    if (page == null) return;
    
    var params = new AJAXParams(page.context, page.url, post, function(request) {Frames.CONTENT.innerHTML = request.responseText;}, function() {alert("AJAX - content loading error")});
    AJAX.loadPage(params);
}

function  navigateToLightbox(page, post) {
    var params = new AJAXParams(page.context, page.url, post,
            function(request) {
                var ce = document.createElement("div");
                ce.innerHTML = request.responseText;
                LightBox.createInstance(99999, Frames.CONTENT, ce);
            },
            function() {alert("AJAX - content loading error")});
    AJAX.loadPage(params);
}

/*******************************************************************************
 * Inicializace jednotlivych stranek.
 ******************************************************************************/

/**
 * Trida stranky, ktera se pouziva jako parametr funkce navigate.
 */
function Page(context, url) {
    this.context = context;
    this.url = url;
}

// Konstanty stranek
var PAGE_HOME = new Page("page/", "home.php");
var PAGE_SEARCH_PARAMS = new Page("page/", "search-params.php");

/*******************************************************************************
 * Prace s framesetem
 ******************************************************************************/

var Frames = new function() {
    this.init = function() {
        this.HEADER = document.getElementById("header");
        this.MENU = document.getElementById("menu");
        this.CONTENT = document.getElementById("content");
        this.FOOTER = document.getElementById("footer");
    }
}

/*******************************************************************************
 * Globalni funkce
 ******************************************************************************/

/**
 * Odstrani vsechny potomky daneho elementu.
 * @param element prvek, ktery bude vycisten.
 */
function removeAllChilds(element) {
    while (element.childNodes.length > 0) {
        element.removeChild(element.firstChild);
    }
}

/**
 * Zobrazi/skryje element podle toho, jaky je jeho aktualni stav.
 * @param element element, ktery je zkouman a upravovan.
 * @param interval cas v ms, jak dlouho se bude element schovavat/objevovat.
 * Null = 0.
 */
function showHide(element, interval) {
    if (element.className.indexOf("hidden") == -1) {
        $(element).addClass("");
    }
}