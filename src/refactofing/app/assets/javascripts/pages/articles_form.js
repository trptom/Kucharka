$(document).ready(function() {
    // validace receptu
    setValidations();
});

function setValidations() {
    Validator.addValidation("article_title", Validator.METHOD.TEXT, {
        minLength: 3,
        minLengthErrorMessage: ValidatorMessages.article.title,
        maxLength: 50,
        maxLengthErrorMessage: ValidatorMessages.article.title
    }, "article_form");
    Validator.addValidation("article_annotation", Validator.METHOD.TEXT, {
        minLength: 50,
        minLengthErrorMessage: ValidatorMessages.article.annotation,
        maxLength: 255,
        maxLengthErrorMessage: ValidatorMessages.article.annotation,
        nullAllowed: true,
        emptyAllowed: true
    }, "article_form");
    Validator.addValidation("article_content", Validator.METHOD.TEXT, {
        minLength: 100,
        minLengthErrorMessage: ValidatorMessages.article.content
    }, "article_form");
}