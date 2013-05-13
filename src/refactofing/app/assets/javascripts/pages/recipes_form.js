$(document).ready(function() {
    // validace receptu
    Validator.addValidation("recipe_name", Validator.METHOD.TEXT, {
        minLength: 3,
        minLengthErrorMessage: ValidatorMessages.recipe.name,
        maxLength: 50,
        maxLengthErrorMessage: ValidatorMessages.recipe.name
    }, "recipe_form");
    Validator.addValidation("recipe_annotation", Validator.METHOD.TEXT, {
        minLength: 50,
        minLengthErrorMessage: ValidatorMessages.recipe.annotation,
        maxLength: 255,
        maxLengthErrorMessage: ValidatorMessages.recipe.annotation,
        nullAllowed: true,
        emptyAllowed: true
    }, "recipe_form");
    Validator.addValidation("recipe_content", Validator.METHOD.TEXT, {
        minLength: 100,
        minLengthErrorMessage: ValidatorMessages.recipe.content
    }, "recipe_form");
    Validator.addValidation("recipe_level", Validator.METHOD.INTEGER, {
        min: 0,
        minErrorMessage: ValidatorMessages.recipe.level,
        max: 5,
        maxErrorMessage: ValidatorMessages.recipe.level,
        notANumberErrorMessage: ValidatorMessages.recipe.level
    }, "recipe_form");
    Validator.addValidation("recipe_estimated_time", Validator.METHOD.INTEGER, {
        min: 0,
        minErrorMessage: ValidatorMessages.recipe.estimated_time,
        notANumberErrorMessage: ValidatorMessages.recipe.estimated_time
    }, "recipe_form");
});