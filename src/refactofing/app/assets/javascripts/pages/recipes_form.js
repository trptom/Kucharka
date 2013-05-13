$(document).ready(function() {
    // validace receptu
    Validator.addValidation("recipe_name", Validator.METHOD.TEXT, {
        minLength: 3,
        minLengthErrorMessage: "špatná délka názvu (3-50)",
        maxLength: 50,
        maxLengthErrorMessage: "špatná délka názvu (3-50)"
    }, "recipe_form");
    Validator.addValidation("recipe_annotation", Validator.METHOD.TEXT, {
        minLength: 50,
        minLengthErrorMessage: "špatná délka stručného popisu (prázdné nebo 50-255 znaků)",
        maxLength: 255,
        maxLengthErrorMessage: "špatná délka stručného popisu (prázdné nebo 50-255 znaků)",
        nullAllowed: true,
        emptyAllowed: true
    }, "recipe_form");
    Validator.addValidation("recipe_content", Validator.METHOD.TEXT, {
        minLength: 100,
        minLengthErrorMessage: "špatná délka obsahu (alespoň 100 znaků)"
    }, "recipe_form");
    Validator.addValidation("recipe_level", Validator.METHOD.INTEGER, {
        min: 0,
        minErrorMessage: "level není celé číslo 0..5",
        max: 5,
        maxErrorMessage: "level není celé číslo 0..5",
        notANumberErrorMessage: "level není celé číslo 0..5"
    }, "recipe_form");
    Validator.addValidation("recipe_estimated_time", Validator.METHOD.INTEGER, {
        min: 0,
        minErrorMessage: "odhadovaný čas není celé číslo > 0",
        notANumberErrorMessage: "odhadovaný čas není celé číslo > 0"
    }, "recipe_form");
});