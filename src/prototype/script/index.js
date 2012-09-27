$(document).ready(function() {
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
    var params = new AJAXParams("", page.url, post, function() {alert("ok")}, function() {alert("error")});
    AJAX.loadPage(params);
}

/*******************************************************************************
 * Inicializace jednotlivych stranek.
 ******************************************************************************/

/**
 * Trida stranky, ktera se pouziva jako parametr funkce navigate.
 */
function Page(url) {
    this.url = url;
}

// Konstanty stranek
var PAGE_HOME = new Page(home);