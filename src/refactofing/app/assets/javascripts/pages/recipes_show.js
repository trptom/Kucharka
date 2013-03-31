var Recipe = {
    getId: function() {
        return document.getElementById("recipe_id").value;
    }
}

/*******************************************************************************
 * ZNAMKY
 ******************************************************************************/

var RecipeMark = {
    component: {
        totalSpan: null,
        wrapperSpan: null,
        mySpan: null,
        deleteButton: null
    },
    recipeId: 0,
    init: function() {
        RecipeMark.component.totalSpan = document.getElementById("recipe_mark");
        RecipeMark.component.wrapperSpan = document.getElementById("recipe_my_mark_wrapper");
        RecipeMark.component.mySpan = document.getElementById("recipe_my_mark");
        RecipeMark.component.deleteButton = document.getElementById("recipe_delete_mark");
    },
    submit: function(value) {
        $.ajax({
            url: "/marks/create/",
            type: "GET",
            dataType: "json",
            data: "recipe=" + encodeURIComponent(Recipe.getId()) +
                "&value=" + encodeURIComponent(value),
            success: function(response) {
                RecipeMark.component.totalSpan.innerHTML = response["total"];
                if (response["my"] === "") {
                    $(RecipeMark.component.wrapperSpan).addClass("hidden");
                    $(RecipeMark.component.deleteButton).addClass("hidden");
                } else {
                    RecipeMark.component.mySpan.innerHTML = response["my"];
                    $(RecipeMark.component.wrapperSpan).removeClass("hidden");
                    $(RecipeMark.component.deleteButton).removeClass("hidden");
                }
            },
            error: function() {
                alert("Známku se nepodeřilo odeslat (AJAX chyba)!");
            }
        });
    }
}

$(document).ready(function() {
    RecipeMark.init();
});

/*******************************************************************************
 * INGREDIENCE
 ******************************************************************************/

var RecipeIngredience = {
    component: {
        list: {
            all: null,
            accepted: null,
            pending: null
        },
        quantity: null,
        importance: null
    },
    validateForm: function() {
        var msg = "";

        if (!RecipeIngredience.component.quantity.value.match(/^([0-9]+\.)?[0-9]+$/) ||
                parseFloat(RecipeIngredience.component.quantity.value) <= 0) {
            msg += "Množství musí být celé číslo > 0!\n";
        }

        if (!RecipeIngredience.component.importance.value.match(/^[0-9]+$/) ||
                parseInt(RecipeIngredience.importance.quantity.value) <= 0) {
            msg += "Důležitost musí být celé číslo > 0!\n";
        }

        if (msg !== "") {
            alert(msg);
        }

        return msg === "";
    },
    reloadList: function() {
        $.ajax({
            url: "/ingrediences.json",
            type: "GET",
            dataType: "json",
            success: function(response) {
                RecipeIngredience.setItems(response[0], response[1]);
            },
            error: function(response) {
                alert("err: " + response);
            }
        });
    },
    setItems: function(acceptedAry, pendingAry) {
        while (RecipeIngredience.component.list.accepted.childNodes.length > 0) {
            RecipeIngredience.component.list.accepted.removeChild(RecipeIngredience.component.list.accepted.firstChild);
        }
        while (RecipeIngredience.component.list.pending.childNodes.length > 0) {
            RecipeIngredience.component.list.pending.removeChild(RecipeIngredience.component.list.pending.firstChild);
        }
        var index;
        for (index in acceptedAry) {
            var newOption = document.createElement("option");
            newOption.text = acceptedAry[index].name + " (" + acceptedAry[index].units + ")";
            newOption.value = acceptedAry[index].id;
            newOption.title = acceptedAry[index].annotation;
            newOption.units = acceptedAry[index].units;
            RecipeIngredience.component.list.accepted.appendChild(newOption);
        }
        for (index in pendingAry) {
            var newOption = document.createElement("option");
            newOption.text = pendingAry[index].name + " (" + pendingAry[index].units + ")";
            newOption.value = pendingAry[index].id;
            newOption.title = pendingAry[index].annotation;
            newOption.units = pendingAry[index].units;
            RecipeIngredience.component.list.pending.appendChild(newOption);
        }
    },
    init: function() {
        RecipeIngredience.component.list.all = document.getElementById("new_ingredience_list");
        RecipeIngredience.component.list.accepted = document.getElementById("new_ingredience_list_accepted");
        RecipeIngredience.component.list.pending = document.getElementById("new_ingredience_list_pending");
        RecipeIngredience.component.quantity = document.getElementById("new_ingredience_quantity");
        RecipeIngredience.component.importance = document.getElementById("new_ingredience_importance");
    }
}

$(document).ready(function() {
    RecipeIngredience.init();
    RecipeIngredience.reloadList();
});

/*******************************************************************************
 * ZADOST O INGREDIENCI
 ******************************************************************************/

var IngredienceRequest = {
    component: {
        name: null,
        units: null,
        annotation: null,
        content: null
    },
    validateForm: function() {
        var ret = "";
        if (IngredienceRequest.component.name.value === "") {
            ret += "Musíte uvést název ingredience!\n";
        }
        if (IngredienceRequest.component.units.value === "") {
            ret += "Musíte uvést jednotky ingredience!\n";
        }

        return (ret === "") ? true : ret;
    },
    submit: function() {
        var validationResult = IngredienceRequest.validateForm();
        if (validationResult === true) {
            $.ajax({
                url: "/ingrediences/new_request/",
                type: "GET",
                dataType: "text",
                data: "name=" + encodeURIComponent(IngredienceRequest.component.name.value) +
                    "&units=" + encodeURIComponent(IngredienceRequest.component.units.value) +
                    "&annotation=" + encodeURIComponent(IngredienceRequest.component.annotation.value) +
                    "&content=" + encodeURIComponent(IngredienceRequest.component.content.value),
                success: function(response) {
                    if (response.indexOf("true") === 0) {
                        IngredienceRequest.component.name.value = "";
                        IngredienceRequest.component.units.value = "";
                        IngredienceRequest.component.annotation.value = "";
                        IngredienceRequest.component.content.value = "";
                        alert("Požadavek na přídání ingredience odeslán...");
                        // aktualizuju seznam
                        RecipeIngredience.reloadList();
                    } else {
                        var msg = response.replace(/^false/, "");
                        alert("Požadavek na přídání ingredience se nepodeřilo odeslat! " + msg);
                    }
                },
                error: function() {
                    alert("Požadavek na přídání ingredience se nepodeřilo odeslat (AJAX chyba)!");
                }
            });
        } else {
            alert(validationResult);
        }
    },
    init: function() {
        IngredienceRequest.component.name = document.getElementById("ingredience_request_name");
        IngredienceRequest.component.units = document.getElementById("ingredience_request_units");
        IngredienceRequest.component.annotation = document.getElementById("ingredience_request_annotation");
        IngredienceRequest.component.content = document.getElementById("ingredience_request_content");
    }
}

$(document).ready(function() {
    IngredienceRequest.init();
});