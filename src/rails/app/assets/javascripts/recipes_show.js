var ConnectedArticles = new function() {
    this.init = function() {
        this.urlElement = document.getElementById("connected_articles_url");
        this.recipeId = document.getElementById("connected_items_recipe_id");
        this.list = document.getElementById("articles");
        this.emptyEcho = document.getElementById("articles_empty");
    }

    this.parseUrl = function(url) {
        if (!url.match(/\/articles?\/[0-9]+/)) {
            return null;
        }
        var tmp = url.split(/\/articles?\//);
        return tmp[1].split("/")[0].replace(/[^0-9]+$/, "");
    }

    this.add = function() {
        var id = this.parseUrl(this.urlElement.value);
        var request = "article_id=" + encodeURIComponent(id);

        Ajax.loadPage("/recipes/" + this.recipeId.value + "/add_connected_article?" + request,
                "GET",
                null,
                function(request) {ConnectedArticles.addOnSuccess(request, id)},
                this.addOnError,
                false);
    }

    this.addOnSuccess = function(request, id) {
        if (request.responseText.indexOf("true") == 0) {
            var tmp = request.responseText.split("\n")
            var newElement = document.createElement("span");
            newElement.link = document.createElement("a");
            newElement.link.href = "/articles/" + tmp[1];
            newElement.link.innerHTML = tmp[2];
            newElement.button = document.createElement("input");
            newElement.button.type = "button";
            newElement.button.value = "X";
            newElement.button.onclick = function() {
                ConnectedArticles.remove(parseInt(tmp[1]), newElement);
            }

            newElement.appendChild(newElement.link);
            newElement.appendChild(document.createTextNode(" "));
            newElement.appendChild(newElement.button);
            newElement.appendChild(document.createTextNode(" "));
            newElement.appendChild(document.createElement("br"));

            ConnectedArticles.list.appendChild(newElement);
            $(ConnectedArticles.emptyEcho).addClass("hidden");
        } else {
            alert("Chyba při přidávání článku!");
        }
    }

    this.addOnError = function(request) {
        alert("Chyba při přidávání článku (AJAX)!");
    }

    this.remove = function(articleId, element) {
        var request = "article_id=" + encodeURIComponent(articleId);
        
        Ajax.loadPage("/recipes/" + this.recipeId.value + "/remove_connected_article?" + request,
                "GET",
                null,
                function(request) {ConnectedArticles.removeOnSuccess(request, element)},
                this.removeOnError,
                false);
    }

    this.removeOnSuccess = function(request, elementToRemove) {
        if (request.responseText.indexOf("true") == 0) {
            ConnectedArticles.list.removeChild(elementToRemove);
            if (ConnectedArticles.list.getElementsByTagName("span").length == 1) {
                $(ConnectedArticles.emptyEcho).removeClass("hidden");
            }
        } else {
            alert("Chyba při odebírání článku!");
        }
    }

    this.removeOnError = function(request) {
        alert("Chyba při odebírání článku (AJAX)!");
    }
}

$(document).ready(function(){
    ConnectedArticles.init();
});