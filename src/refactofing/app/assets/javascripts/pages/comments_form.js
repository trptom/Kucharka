$(document).ready(function() {
    Validator.addValidation("comment_content", Validator.METHOD.TEXT, {
        minLength: 1,
        minLengthErrorMessage: ValidatorMessages.comment.content,
    }, "new_comment_form");
});