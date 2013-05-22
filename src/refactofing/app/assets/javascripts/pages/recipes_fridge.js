function FridgeExtendedFilterComponent(val, quantity, name) {
    val = val.split("|");
    var id = val[0];
    var units = val[1]

    this.init(id, units, quantity, name);
}

FridgeExtendedFilterComponent.prototype.init = function(id, units, quantity, name) {

    this.input = document.createElement("input");
    this.input.type = "hidden";
    this.input.setAttribute("name", "ingrediences[]");
    this.input.value = quantity ? (id + "|" + quantity) : id+"";

    this.detailSpan = document.createElement("span");
    this.detailSpan.innerHTML = quantity ? name + " (" + quantity + " " + units + ")" : name;
    this.detailSpan.className = "span4";

    this.deleteButton = document.createElement("input");
    this.deleteButton.type = "button";
    this.deleteButton.className = "btn pull-right";
    this.deleteButton.value = "Odstranit";

    this.component = document.createElement("div");
    this.component.className = "fridge-ingredience-line row-fluid";

    this.component.appendChild(this.input);
    this.component.appendChild(this.detailSpan);
    this.component.appendChild(this.deleteButton);

    var _this = this;

    this.component.isIngredience = true;

    this.deleteButton.onmouseover = function() {
        $(_this.component).addClass("highlight");
    }

    this.deleteButton.onmouseout = function() {
        $(_this.component).removeClass("highlight");
    }

    this.component.getId = function() {
        return id;
    }

    this.component.addQuantity = function(quantity_appended) {
        if (quantity_appended === "") {
            return;
        }
        if (typeof quantity_appended != "number") {
            quantity_appended = parseFloat(quantity_appended);
        }
        var tmp = _this.input.value.split("|");
        var newQuantity = tmp[1] ? parseFloat(tmp[1], 10)+quantity_appended : quantity_appended;
        _this.input.value = id + "|" + newQuantity;
        _this.detailSpan.innerHTML = name + " (" + newQuantity + " " + units + ")";
    }

    this.deleteButton.onclick = function() {
        FridgeExtendedFilter.ingrediencesHomeDiv.removeChild(_this.component);
    }
}

var FridgeExtendedFilter = {
    ingrediencesHomeDiv: null,
    newIngredience: {
        filterInput: null,
        nameSelect: {
            component: null,
            allowedGroup: null,
            notAllowedGroup: null
        },
        quantityInput: null,
        unitsSpan: null,
        addButton: null,
        options: {
            allowed: new Array(),
            notAllowed: new Array()
        }
    },
    init: function() {
        this.ingrediencesHomeDiv = document.getElementById("filter-ingrediences-home");
        this.newIngredience.filterInput = document.getElementById("filter-new-ingredience-filter");
        this.newIngredience.nameSelect.component = document.getElementById("filter-new-ingredience-name");
        this.newIngredience.nameSelect.allowedGroup = document.getElementById("filter-new-ingredience-name-allowed");
        this.newIngredience.nameSelect.notAllowedGroup = document.getElementById("filter-new-ingredience-name-not-allowed");
        this.newIngredience.quantityInput = document.getElementById("filter-new-ingredience-quantity");
        this.newIngredience.unitsSpan = document.getElementById("filter-new-ingredience-units");
        this.newIngredience.addButton = document.getElementById("filter-new-ingredience-add");

        var a;
        var tmp;
        tmp = this.newIngredience.nameSelect.allowedGroup.getElementsByTagName("option");
        for (a=0; a<tmp.length; a++) {
            this.newIngredience.options.allowed[this.newIngredience.options.allowed.length] = tmp[a];
        }
        tmp = this.newIngredience.nameSelect.notAllowedGroup.getElementsByTagName("option");
        for (a=0; a<tmp.length; a++) {
            this.newIngredience.options.notAllowed[this.newIngredience.options.notAllowed.length] = tmp[a];
        }

        this.reloadList();
        this.ingredienceChanged();
        this.initPrevious();
    },
    reloadList: function() {
        while (FridgeExtendedFilter.newIngredience.nameSelect.allowedGroup.childNodes.length > 0) {
            FridgeExtendedFilter.newIngredience.nameSelect.allowedGroup.removeChild(FridgeExtendedFilter.newIngredience.nameSelect.allowedGroup.firstChild);
        }
        while (FridgeExtendedFilter.newIngredience.nameSelect.notAllowedGroup.childNodes.length > 0) {
            FridgeExtendedFilter.newIngredience.nameSelect.notAllowedGroup.removeChild(FridgeExtendedFilter.newIngredience.nameSelect.notAllowedGroup.firstChild);
        }
        var a;
        var val = FridgeExtendedFilter.newIngredience.filterInput.value
        for (a=0; a<FridgeExtendedFilter.newIngredience.options.allowed.length; a++) {
            if (val == "" || FridgeExtendedFilter.newIngredience.options.allowed[a].innerHTML.indexOf(val) >= 0) {
                FridgeExtendedFilter.newIngredience.nameSelect.allowedGroup.appendChild(FridgeExtendedFilter.newIngredience.options.allowed[a]);
            }
        }
        for (a=0; a<FridgeExtendedFilter.newIngredience.options.notAllowed.length; a++) {
            if (val == "" || FridgeExtendedFilter.newIngredience.options.notAllowed[a].innerHTML.indexOf(val) >= 0) {
                FridgeExtendedFilter.newIngredience.nameSelect.notAllowedGroup.appendChild(FridgeExtendedFilter.newIngredience.options.notAllowed[a]);
            }
        }
    },
    ingredienceChanged: function() {
        var data = FridgeExtendedFilter.newIngredience.nameSelect.component.value.split("|");
        FridgeExtendedFilter.newIngredience.unitsSpan.innerHTML = data[1];
    },
    addClicked: function() {
        if (FridgeExtendedFilter.newIngredience.quantityInput.value !== "" &&
            !(FridgeExtendedFilter.newIngredience.quantityInput.value > 0)) {
            alert("Množství není desetinné číslo > 0.\n(Zkontrolujte, zda jste jako desetinný oddělovač použil(a) čárku)")
            return;
        }
        var div = FridgeExtendedFilter.getAddedIngredienceDiv(parseInt(FridgeExtendedFilter.newIngredience.nameSelect.component.value.split("|")[0], 10));
        if (div) {
            div.addQuantity(FridgeExtendedFilter.newIngredience.quantityInput.value);
        } else {
            var comp = new FridgeExtendedFilterComponent(
                    FridgeExtendedFilter.newIngredience.nameSelect.component.value,
                    FridgeExtendedFilter.newIngredience.quantityInput.value,
                    FridgeExtendedFilter.newIngredience.nameSelect.component.options[FridgeExtendedFilter.newIngredience.nameSelect.component.selectedIndex].innerHTML);

            FridgeExtendedFilter.ingrediencesHomeDiv.appendChild(comp.component);
        }
    },
    initPrevious: function() {
        var spans = document.getElementById("filter-previous-request").getElementsByTagName("span");

        for (var a=0; a<spans.length; a++) {
            var tmp = spans[a].innerHTML.split("|");
            for (var b=0; b<FridgeExtendedFilter.newIngredience.nameSelect.component.options.length; b++) {
                if (FridgeExtendedFilter.newIngredience.nameSelect.component.options[b].value.indexOf(tmp[0] + "|") == 0) {
                    FridgeExtendedFilter.newIngredience.nameSelect.component.selectedIndex = b;
                    FridgeExtendedFilter.newIngredience.quantityInput.value = tmp[1];
                    FridgeExtendedFilter.addClicked();
                    break;
                }
            }
        }
    },
    getAddedIngredienceDiv: function(id) {
        for (var a=0; a<FridgeExtendedFilter.ingrediencesHomeDiv.childNodes.length; a++) {
            if (FridgeExtendedFilter.ingrediencesHomeDiv.childNodes[a].isIngredience) {
                if (FridgeExtendedFilter.ingrediencesHomeDiv.childNodes[a].getId() == id) {
                    return FridgeExtendedFilter.ingrediencesHomeDiv.childNodes[a];
                }
            }
        }
        return null;
    },
    validateSubmit: function() {
        var count = 0;
        for (var a=0; a<FridgeExtendedFilter.ingrediencesHomeDiv.childNodes.length; a++) {
            if (FridgeExtendedFilter.ingrediencesHomeDiv.childNodes[a].isIngredience) {
                count++;
            }
        }
        return count > 0;
    }
}

$(document).ready(function() {
    FridgeExtendedFilter.init();
});