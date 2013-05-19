$(document).ready(function() {
    // validace receptu
    setValidations();
});

function setValidations() {
    Validator.addValidation("ingredience_name", Validator.METHOD.TEXT, {
        minLength: 3,
        minLengthErrorMessage: ValidatorMessages.ingredience.name.length,
        maxLength: 50,
        maxLengthErrorMessage: ValidatorMessages.ingredience.name.length
    }, "ingredience_form");
    Validator.addValidation("ingredience_annotation", Validator.METHOD.TEXT, {
        minLength: 50,
        minLengthErrorMessage: ValidatorMessages.ingredience.annotation,
        maxLength: 255,
        maxLengthErrorMessage: ValidatorMessages.ingredience.annotation,
        nullAllowed: true,
        emptyAllowed: true
    }, "ingredience_form");
    Validator.addValidation("ingredience_content", Validator.METHOD.TEXT, {
        minLength: 100,
        minLengthErrorMessage: ValidatorMessages.ingredience.content
    }, "ingredience_form");
    Validator.addValidation("ingredience_avaliability", Validator.METHOD.INTEGER, {
        min: 1,
        minLengthErrorMessage: ValidatorMessages.ingredience.avaliability,
        max: 1000,
        maxLengthErrorMessage: ValidatorMessages.ingredience.avaliability,
        notANumberErrorMessage: ValidatorMessages.ingredience.avaliability
    }, "ingredience_form");
    Validator.addValidation("ingredience_units", Validator.METHOD.TEXT, {
        minLength: 1,
        minLengthErrorMessage: ValidatorMessages.ingredience.units,
        maxLength: 20,
        maxLengthErrorMessage: ValidatorMessages.ingredience.units
    }, "ingredience_form");
}