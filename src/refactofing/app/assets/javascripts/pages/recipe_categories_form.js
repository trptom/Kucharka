$(document).ready(function() {
    // validace receptu
    setValidations();
});

function setValidations() {
    Validator.addValidation("recipe_category_name", Validator.METHOD.TEXT, {
        minLength: 3,
        minLengthErrorMessage: ValidatorMessages.recipe_category.name,
        maxLength: 50,
        maxLengthErrorMessage: ValidatorMessages.recipe_category.name
    }, "recipe_category_form");
    Validator.addValidation("recipe_category_description", Validator.METHOD.TEXT, {
        minLength: 20,
        minLengthErrorMessage: ValidatorMessages.recipe_category.description,
        nullAllowed: true,
        emptyAllowed: true
    }, "recipe_category_form");
}