$(document).ready(function() {
    // validace receptu
    setValidations();
});

function setValidations() {
    Validator.addValidation("ingredience_category_name", Validator.METHOD.TEXT, {
        minLength: 3,
        minLengthErrorMessage: ValidatorMessages.ingredience_category.name,
        maxLength: 50,
        maxLengthErrorMessage: ValidatorMessages.ingredience_category.name
    }, "ingredience_category_form");
    Validator.addValidation("ingredience_category_description", Validator.METHOD.TEXT, {
        minLength: 20,
        minLengthErrorMessage: ValidatorMessages.ingredience_category.description,
        nullAllowed: true,
        emptyAllowed: true
    }, "ingredience_category_form");
}