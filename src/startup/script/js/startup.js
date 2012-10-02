$(document).ready(function() {
    linkComponents();
    setOnClickActions();
});

var Components = new function() {
    // prazdne, nalinkovano pri document ready.
}

function linkComponents() {
    Components.PROJECT_URL = document.getElementById("url");
    Components.CHECK_DB = document.getElementById("but-check-db");
    Components.RESET_DB = document.getElementById("but-reset-db");
    Components.GENERATE_CONFIGURATION = document.getElementById("but-generate-conf");
    Components.DB_SERVER = document.getElementById("db-server");
    Components.DB_NAME = document.getElementById("db-name");
    Components.DB_USER = document.getElementById("db-user");
    Components.DB_PASSWORD = document.getElementById("db-password");
    Components.OUTPUT = document.getElementById("output-content");
}

function setOnClickActions() {
    Components.CHECK_DB.onclick = function() {
        if (validateDbVariables()) {
            AJAX.loadPage(new AJAXParams("script/php/", "checkDb.php", getDbPost(), appendResult, function() {alert("AJAX error")}));
        }
    }
    Components.RESET_DB.onclick = function() {
        if (confirm("Opravdu chcete resetovat DB?")) {
            AJAX.loadPage(new AJAXParams("script/php/", "resetDb.php", null, appendResult, function() {alert("AJAX error")}));
        }
    }
}

function appendResult(request) {
    Components.OUTPUT.innerHTML += request.responseText;
}

function validateDbVariables() {
    var err = "";
    if (Components.DB_SERVER.value == "") err += "  Chybný(prázdné) server.\n";
    if (Components.DB_NAME.value == "") err += "  Chybná(prázdná) databáze.\n";
    if (Components.DB_USER.value == "") err += "  Chybný(prázdný) uživatel.\n";
    
    if (err != "") {
        alert("Chyba při validaci DB údajů:\n" + err)
        return false;
    } else {
        return true;
    }
}

function getDbPost() {
    return "dbServer=" + encodeURIComponent(Components.DB_SERVER.value) +
        "&dbName=" + encodeURIComponent(Components.DB_NAME.value) +
        "&dbUser=" + encodeURIComponent(Components.DB_USER.value) +
        "&dbPassword=" + encodeURIComponent(Components.DB_PASSWORD.value);
}