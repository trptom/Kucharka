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
            if (item.length == 4) {
                var option = document.createElement("option");
                option.text = item[3] + " (" + item[2] + ")";
                option.iId = item[0];
                option.iUnits = item[2];
                option.iName = item[3];
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

    this.getSelectedOption = function() {
        if (this.component.selectedIndex < 0) {
            return null;
        }
        return this.component.options[this.component.selectedIndex];
    }

    this.setSelectedOptionByIId = function(iId) {
        for (var a=0; a<this.component.options.length; a++) {
            if (this.component.options[a].iId == iId) {
                this.component.selectedIndex = a;
                return true;
            }
        }
        return false;
    }
}

var createRecipeIngredience = function(id, name, units, quantity, importance) {
    return new function() {
        this.id = id;
        this.name = name;
        this.units = units;
        this.quantity = quantity;
        this.importance = importance;

        this.hiddenOption = document.createElement("option");
        this.hiddenOption.value = id + "|" + quantity + "|" + importance;
        this.hiddenOption.selected = true;
        this.hiddenOption.instance = this;

        this.selectedComponent = document.createElement("div");
        this.selectedComponent.innerHTML = name + " (" + quantity + " " +units + " / důležitost: " + importance + ")";
        this.selectedComponent.instance = this;
        this.selectedComponent.title = "Kliknutím ingredienci odeberete.";
        this.selectedComponent.onclick = function() {
            Ingrediences.remove(this);
        }
    }
}

var Ingrediences = new function() {
    this.init = function() {
        this.hiddenSelect = document.getElementById("ingrediences_select");
        this.selectedDiv = document.getElementById("ingrediences_selected");
        this.quantityInput = document.getElementById("ingredience_quantity");
        this.importanceInput = document.getElementById("ingredience_importance");
        this.hiddenSpan = document.getElementById("ingrediences_list");

        var tmp = this.hiddenSpan.innerHTML.replace(" ", "").split("\n");
        for (var a=0; a<tmp.length; a++) {
            var ary = tmp[a].split("|");
            if (ary.length == 3) {
                if (IngredienceSelect.setSelectedOptionByIId(parseInt(ary[0]))) {
                    this.quantityInput.value = parseFloat(ary[1]);
                    this.importanceInput.value = parseFloat(ary[2]);
                    this.add();
                }
            }
        }
    }

    this.add = function() {
        var item = IngredienceSelect.getSelectedOption();

        if (item == null) {
            alert("Není vybrána žádná ingredience!");
            return;
        }

        if (!(parseFloat(this.quantityInput.value) > 0)) {
            alert("Množství není číslo > 0");
            return;
        }

        if (!(parseInt(this.importanceInput.value) >= 0)) {
            alert("Množství není celé číslo >= 1");
            return;
        }

        var newItem = createRecipeIngredience(
                item.iId,
                item.iName,
                item.iUnits,
                this.quantityInput.value,
                this.importanceInput.value);

        this.hiddenSelect.options[this.hiddenSelect.options.length] = newItem.hiddenOption;
        this.selectedDiv.appendChild(newItem.selectedComponent);
    }

    this.remove = function(sender) {
        this.hiddenSelect.removeChild(sender.instance.hiddenOption);
        this.selectedDiv.removeChild(sender);
    }
}

$(document).ready(function(){
    IngredienceRequest.init();
    IngredienceSelect.init();
    Ingrediences.init();
});