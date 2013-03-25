var Mark = new function() {
    this.init = function() {
        this.recipeId = document.getElementById("recipe_id");
        this.units = document.getElementById("new_ingredience_units");
        this.markSpan = document.getElementById("recipe_mark");
        this.markSpan2 = document.getElementById("recipe_mark_2");
    }

    this.submit = function(value) {
        var request = "value=" + encodeURIComponent(value);
        request += "&recipe=" + encodeURIComponent(this.recipeId.value);
        Ajax.loadPage("/marks/create/?" + request, "GET", null, this.onSuccess, this.onError, false);
    }

    this.onSuccess = function(request) {
        if (request.responseText.indexOf("true") == 0) {
            var tmp = request.responseText.split("\n");
            if (Mark.markSpan != null && tmp.length > 1) { // kdyby nemel prava na zobrazeni, span neexistuje
                Mark.markSpan.innerHTML = tmp[1];
            }
            if (Mark.markSpan2 != null && tmp.length > 2) { // kdyby nemel prava na zobrazeni, span neexistuje
                Mark.markSpan2.innerHTML = tmp[2];
            }
        } else {
            alert("Známku se nepodařilo přidat!");
        }
    }

    this.onError = function(request) {
        alert("Známku se nepodařilo přidat (AJAX chyba)!");
    }
}

$(document).ready(function(){
    Mark.init();
});