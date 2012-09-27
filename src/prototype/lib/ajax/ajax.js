function AJAXParams(contextPath, url, post, onLoad, onError) {
    function getCompleteURL() {
        return this.contextPath + this.url;
    }

    this.contextPath = contextPath;
    this.url = url;
    this.post = post;
    this.onLoad = onLoad;
    this.onError = onError;

    this.getCompleteURL = getCompleteURL;
}

var AJAX = new function() {
    function getTargetFunction(target) {
        if (target == null) return null;
        return function(http_request) {
            target.innerHTML = http_request.responseText;
        }
    }

    function loadPage(params) {
        var http_request = createRequest();

        if (http_request != null) {
            http_request.onreadystatechange = function() {processControl(http_request, params);};
            http_request.open('POST', params.getCompleteURL(), true);
            http_request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            http_request.send(params.post);
            return true;
        }else{
            alert("Chyba při inicializaci načítané stránky.");
            return false;
        }
    }

    function processControl(http_request, params) {
        if (http_request.readyState == 4) {
            if (http_request.status == 200) {
                if (params.onLoad != null) params.onLoad(http_request);
                return true;
            } else {
                if (params.onError == null) {
                    alert('Nastala chyba při načítání stránky (AJAX)!'
                          + 'chyba ('+http_request.status+') ');
                } else {
                    params.onError(http_request);
                }
                return false;
            }
        }
        return null;
    }

    function createRequest() {
        if (window.XMLHttpRequest) {
            return new XMLHttpRequest();
        } else if (window.ActiveXObject) {
            try {
              return new ActiveXObject("Msxml2.XMLHTTP");
            } catch (error) {
              return new ActiveXObject("Microsoft.XMLHTTP");
            }
        }
        return null;
    }

    this.loadPage = loadPage;
    this.getTargetFunction = getTargetFunction;
}