var IngredienceRequest = new function() {
    this.init = function() {
        this.name = document.getElementById("new_ingredience_name");
        this.units = document.getElementById("new_ingredience_units");
        this.annotation = document.getElementById("new_ingredience_annotation");
        this.content = document.getElementById("new_ingredience_content");
    }

    this.validate = function() {
        var ret = "";
        if (this.name.value == "") {
            ret += "Musíte uvést název ingredience!\n";
        }
        if (this.units.value == "") {
            ret += "Musíte uvést jednotky ingredience!\n";
        }

        return (ret == "") ? true : ret;
    }

    this.submit = function() {
        var validationResult = this.validate();
        if (validationResult === true) {
            var request = "name=" + encodeURIComponent(this.name.value);
            request += "&units=" + encodeURIComponent(this.units.value);
            request += "&annotation=" + encodeURIComponent(this.annotation.value);
            request += "&content=" + encodeURIComponent(this.content.value);
            Ajax.loadPage("/ingrediences/new_request/?" + request, "GET", null, this.onSuccess, this.onError, false);
        } else {
            alert(validationResult);
        }
    }

    this.onSuccess = function(request) {
        if (request.responseText.indexOf("true") == 0) {
            IngredienceRequest.name.value = "";
            IngredienceRequest.units.value = "";
            IngredienceRequest.annotation.value = "";
            IngredienceRequest.content.value = "";
            alert("Požadavek na přídání ingredience odeslán...");
            // aktualizuju seznam
            IngredienceSelect.reload();
        } else {
            var msg = request.responseText.replace(/^false/, "");
            alert("Požadavek na přídání ingredience se nepodeřilo odeslat!" + msg);
        }
    }

    this.onError = function(request) {
        alert("Požadavek na přídání ingredience se nepodeřilo odeslat (AJAX chyba)!");
    }
}

var IngredienceSelect = new function() {
    this.init = function() {
        this.component = document.getElementById("ingredience_select");
        this.component.accepted = document.getElementById("ingrediences_accepted_group");
        this.component.notAccepted = document.getElementById("ingrediences_not_accepted_group");

        this.reload();
    }

    this.reload = function() {
        Ajax.loadPage("/ingrediences/plain_list", "GET", null, this.reloadOnSuccess, this.reloadOnError, false);
    }

    this.reloadOnSuccess = function(request) {
        while (IngredienceSelect.component.notAccepted.childNodes.length > 0) {
            IngredienceSelect.component.notAccepted.removeChild(IngredienceSelect.component.notAccepted.firstChild);
        }
        while (IngredienceSelect.component.accepted.childNodes.length > 0) {
            IngredienceSelect.component.accepted.removeChild(IngredienceSelect.component.accepted.firstChild);
        }

        var tmp = request.responseText.split("\n");
        var count = new Array(0, 0)

        for (var i in tmp) {
            var item = tmp[i].split("|");
            if (item.length == 3) {
                var option = document.createElement("option");
                option.text = item[2];
                option.value = item[0];
                if (item[1] == "0") {
                    IngredienceSelect.component.notAccepted.appendChild(option);
                    count[0]++;
                } else {
                    IngredienceSelect.component.accepted.appendChild(option);
                    count[1]++;
                }
            }
        }

        if (count[0] == 0) {
            IngredienceSelect.component.notAccepted.appendChild(IngredienceSelect.getEmptyOption());
        }
        if (count[1] == 0) {
            IngredienceSelect.component.accepted.appendChild(IngredienceSelect.getEmptyOption());
        }
    }

    this.reloadOnError = function(request) {
        alert("Aktualizace seznamu ingrediencí selhala!");
    }

    this.getEmptyOption = function() {
        var ret = document.createElement("option");
        ret.text = "Žádné";
        ret.disabled = true;
        return ret;
    }
}

var RecipeIngredience = function(id, units, name, quantity) {
    this.id = id;
    this.units = units;
    this.name = name;
    this.quantity = quantity;

    this.hiddenOption = document.createElement("option");
    this.hiddenOption.value = id + "|" + quantity;
    this.hiddenOption.text = name + "   " + this.hiddenOption.value;
    this.hiddenOption.selected = true;
    this.hiddenOption.instance = this;

    this.selectedComponent = document.createElement("option");
    this.selectedComponent.text = name + "(" + quantity + " " + units + ")";
    this.selectedComponent.instance = this;
}

$(document).ready(function(){
    IngredienceRequest.init();
    IngredienceSelect.init();
});