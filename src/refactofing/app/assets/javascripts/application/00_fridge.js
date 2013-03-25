var FridgeIngredience = function(id, units, name, quantity) {
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
}

$(document).ready(function(){
    Fridge.init();
});