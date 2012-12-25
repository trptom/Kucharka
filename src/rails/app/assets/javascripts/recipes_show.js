var ConnectedArticles = new function() {
    this.init = function() {
        this.urlElement = document.getElementById("connected_articles_url");
        this.recipeId = document.getElementById("connected_items_recipe_id");
    }

    this.parseUrl = function(url) {
        if (!url.match(/\/articles?\/[0-9]+/)) {
            return null;
        }
        var tmp = url.split(/\/articles?\//);
        tmp = tmp[1].split("/")[0].replace(/[^0-9]+$/, "");
        alert(tmp);
        return tmp;
    }

    this.add = function() {
        var id = this.parseUrl(this.urlElement.value);
        var request = "article_id=" + encodeURIComponent(id)

        Ajax.loadPage("/recipes/" + this.recipeId.value + "/add_connected_article?" + request, "GET", null, this.addOnSuccess, this.addOnError, false);
    }

    this.addOnSuccess = function(request) {
        alert(request.responseText);
    }

    this.addOnError = function(request) {
        alert("err> " + request.responseText);
    }
}

$(document).ready(function(){
    ConnectedArticles.init();
});