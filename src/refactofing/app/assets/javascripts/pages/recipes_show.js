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
                alert("Hodnocení se nepodeřilo odeslat (AJAX chyba)!");
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
    submit: function() {
        var validationResult = Validator.validate({
            group: "ingredience_request_form",
            errorsElementId: "ingredience-request-form-errors"
        });
        if (validationResult === true) {
            $.ajax({
                url: "/ingrediences/new_request.json",
                type: "GET",
                dataType: "text",
                async: false,
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
    setValidations();
    IngredienceRequest.init();
});

function setValidations() {
    Validator.addValidation("new_subrecipe_url", Validator.METHOD.TEXT, {
        minLength: 1,
        minLengthErrorMessage: "URL musí být vyplněná"
    }, "subrecipe_form");

    Validator.addValidation("new_article_url", Validator.METHOD.TEXT, {
        minLength: 1,
        minLengthErrorMessage: "URL musí být vyplněná"
    }, "article_form");

    Validator.addValidation("ingredience_request_name", Validator.METHOD.TEXT, {
        minLength: 3,
        minLengthErrorMessage: ValidatorMessages.ingredience.name.length,
        maxLength: 50,
        maxLengthErrorMessage: ValidatorMessages.ingredience.name.length
    }, "ingredience_request_form");
    Validator.addValidation("ingredience_request_units", Validator.METHOD.TEXT, {
        minLength: 1,
        minLengthErrorMessage: ValidatorMessages.ingredience.units,
        maxLength: 20,
        maxLengthErrorMessage: ValidatorMessages.ingredience.units
    }, "ingredience_request_form");
    Validator.addValidation("ingredience_request_annotation", Validator.METHOD.TEXT, {
        minLength: 50,
        minLengthErrorMessage: ValidatorMessages.ingredience.annotation,
        maxLength: 255,
        maxLengthErrorMessage: ValidatorMessages.ingredience.annotation,
        emptyAllowed: true,
        nullAllowed: true
    }, "ingredience_request_form");
    Validator.addValidation("ingredience_request_content", Validator.METHOD.TEXT, {
        minLength: 100,
        minLengthErrorMessage: ValidatorMessages.ingredience.content,
        emptyAllowed: true,
        nullAllowed: true
    }, "ingredience_request_form");

    Validator.addValidation("new_ingredience_list", Validator.METHOD.INTEGER, {
        min: 0,
        minErrorMessage: "není vybrána žádná ingredience",
        notANumberErrorMessage: "není vybrána žádná ingredience"
    }, "add_ingredience_form");
    Validator.addValidation("new_ingredience_quantity", Validator.METHOD.DECIMAL, {
        min: 0,
        minErrorMessage: ValidatorMessages.ingredience_recipe_connector.quantity,
        notANumberErrorMessage: ValidatorMessages.ingredience_recipe_connector.quantity
    }, "add_ingredience_form");
    Validator.addValidation("new_ingredience_importance", Validator.METHOD.INTEGER, {
        min: 0,
        minErrorMessage: ValidatorMessages.ingredience_recipe_connector.importance,
        notANumberErrorMessage: ValidatorMessages.ingredience_recipe_connector.importance
    }, "add_ingredience_form");

    Validator.addValidation("new_category_list", Validator.METHOD.INTEGER, {
        min: 0,
        minErrorMessage: "není vybrána žádná kategorie",
        notANumberErrorMessage: "není vybrána žádná kategorie"
    }, "add_category_form");
}