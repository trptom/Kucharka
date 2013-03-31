/*var FridgeIngredience = function(id, units, name, quantity) {
    this.id = id;
    this.units = units;
    this.name = name;
    this.quantity = quantity;

    this.hiddenOption = document.createElement("option");
    this.hiddenOption.value = id + "|" + quantity;
    this.hiddenOption.text = name + "   " + this.hiddenOption.value;
    this.hiddenOption.selected = true;
    this.hiddenOption.instance = this;

    this.selectedOption = document.createElement("option");
    this.selectedOption.text = name + "(" + quantity + " " + units + ")";
    this.selectedOption.instance = this;
}

var Fridge = new function() {
    this.init = function() {
        this.select = document.getElementById("fridge_select");
        this.selected = document.getElementById("fridge_selected");
        this.hidden = document.getElementById("fridge_hidden");
        this.filterInput = document.getElementById("fridge_filter_input");

        // zkopiruju, protoze s polozkama budu hybat
        this.selectValues = new Array();
        for (var a=0; a<this.select.options.length; a++) {
            this.selectValues[a] = this.select.options[a];
        }
    };

    this.addSelected = function() {
        for (var a=0; a<this.select.options.length; a++) {
            if (this.select.options[a].selected) {
                this.add(this.select.options[a]);
            }
        }
    }

    this.add = function(option) {
        var tmp = option.value.split("|");
        var id = tmp[0];
        var units = tmp[1];
        var name = option.innerHTML;
        var quantity;

        for (var a=0; a<this.selected.options.length; a++) {
            if (this.selected.options[a].instance.id == id) {
                alert("Ingredience " + name + " je již přidána a množstvím "
                        + this.selected.options[a].instance.quantity
                        + ".\nPokud chcete zadat nové množství, musíte nejdřív ingredienci odebrat.")
                return;
            }
        }

        do {
            quantity = prompt("Množství ingredience " + name + " (v " + units + ")", "1");
            if (quantity == null) {
                return;
            }
            if (!quantity.match(/^[0-9]+(\.[0-9]+)?$/)) {
                alert("Množství \"" + quantity + "\" není platné celé nebo desetinné číslo!");
                quantity = null;
            }
        } while (quantity == null);

        var inst = new FridgeIngredience(id, units, name, quantity);

        this.selected.appendChild(inst.selectedOption);
        this.hidden.appendChild(inst.hiddenOption);
    }

    this.removeAll = function() {
        var tmp = this.selected.options;
        for (var a=0; a<tmp.length; a++) {
            if (tmp[a].selected) {
                this.remove(tmp[a]);
                a--;
            }
        }
    }

    this.remove = function(option) {
        this.hidden.removeChild(option.instance.hiddenOption);
        this.selected.removeChild(option.instance.selectedOption);
    }

    this.filter = function() {
        while (this.select.childNodes.length > 0) {
            this.select.removeChild(this.select.firstChild);
        }

        for (var a=0; a<this.selectValues.length; a++) {
            if (this.filterInput.value == null ||
                this.filterInput.value == "" ||
                this.selectValues[a].innerHTML.indexOf(this.filterInput.value) >= 0) {
                this.select.appendChild(this.selectValues[a]);
            }
        }
    }

    this.validateSubmit = function() {
        if (this.hidden.options.length == 0) {
            alert("Musí být vybrána alespoň 1 ingredience.");
            return false;
        }
        return true;
    }
}*/

var Fridge = {
    component: {
        listSelect: null,
        selectedSelect: null,
        hiddenField: null,
        searchInput: null,
        button: {
            add: null,
            remove:null,
            submit: null,
            search: null
        }
    },
    ingrediencesOptions: new Array(),
    init: function() {
        Fridge.component.listSelect = document.getElementById("fridge_list");
        Fridge.component.selectedSelect = document.getElementById("fridge_selected");
        Fridge.component.hiddenField = document.getElementById("fridge_hidden");
        Fridge.component.searchInput = document.getElementById("fridge_search");
        Fridge.component.button.add = document.getElementById("fridge_button-add");
        Fridge.component.button.remove = document.getElementById("fridge_button-remove");
        Fridge.component.button.submit = document.getElementById("fridge_button-submit");
        Fridge.component.button.search = document.getElementById("fridge_button-search");

        for (var a=0; a<Fridge.component.listSelect.options.length; a++) {
            Fridge.ingrediencesOptions[Fridge.ingrediencesOptions.length] = Fridge.component.listSelect.options[a];
        }
    },
    addSelected: function() {
        for (var a=0; a<Fridge.component.listSelect.options.length; a++) {
            if (Fridge.component.listSelect.options[a].selected) {
                Fridge.component.listSelect.options[a].selected = false;
                if (!Fridge.isSelected(Fridge.component.listSelect.options[a].value)) {
                    // appending to list of selected
                    var elem = document.createElement("option");
                    elem.text = Fridge.component.listSelect.options[a].text;
                    elem.value = Fridge.component.listSelect.options[a].value;
                    Fridge.component.selectedSelect.appendChild(elem);
                    // appending to form to submit
                    var hidden = document.createElement("input");
                    hidden.type = "hidden";
                    hidden.name = "ingrediences[]";
                    hidden.value = Fridge.component.listSelect.options[a].value;
                    Fridge.component.hiddenField.appendChild(hidden);
                }
            }
        }
    },
    isSelected: function(value) {
        for (var a=0; a<Fridge.component.selectedSelect.options.length; a++) {
            if (Fridge.component.selectedSelect.options[a].value === value) {
                return true;
            }
        }
        return false;
    },
    removeSelected: function() {
        var removeList = new Array();
        for (var a=0; a<Fridge.component.selectedSelect.options.length; a++) {
            if (Fridge.component.selectedSelect.options[a].selected) {
                removeList[removeList.length] = Fridge.component.selectedSelect.options[a];
            }
        }
        for (var index in removeList) {
            Fridge.removeFromHidden(removeList[index].value);
            Fridge.component.selectedSelect.removeChild(removeList[index]);
        }
    },
    removeFromHidden: function(value) {
        for (var a=0; a<Fridge.component.hiddenField.childNodes.length; a++) {
            if (Fridge.component.hiddenField.childNodes[a].value === value) {
                Fridge.component.hiddenField.removeChild(Fridge.component.hiddenField.childNodes[a]);
                return true;
            }
        }
        return false;
    },
    filterIngrediences: function(byValue) {
        byValue = byValue ? byValue : Fridge.component.searchInput.value;
        while (Fridge.component.listSelect.childNodes.length > 0) {
            Fridge.component.listSelect.removeChild(Fridge.component.listSelect.firstChild);
        }
        for (var a=0; a<Fridge.ingrediencesOptions.length; a++) {
            if (!byValue || byValue === "" ||
                    Fridge.ingrediencesOptions[a].innerHTML.indexOf(byValue) >= 0) {
                Fridge.component.listSelect.appendChild(Fridge.ingrediencesOptions[a]);
            } else {
                Fridge.ingrediencesOptions[a].selected = false;
            }
        }
    },
    validate: function() {
        if (Fridge.component.selectedSelect.options.length == 0) {
            alert("Musíte vybrat alespoň jednu ingredienci.");
            return false;
        }
        return true;
    }
}

$(document).ready(function(){
    Fridge.init();
});