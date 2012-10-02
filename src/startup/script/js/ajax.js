function AJAXParams(contextPath, url, post, onLoad, onError) {
    this.getCompleteURL = function() {
        return this.contextPath + this.url;
    }

    this.contextPath = contextPath;
    this.url = url;
    this.post = post;
    this.onLoad = onLoad;
    this.onError = onError;
}

var AJAX = new function() {
    this.getTargetFunction = function(target) {
        if (target == null) return null;
        return function(http_request) {
            target.innerHTML = http_request.responseText;
        }
    }

    this.loadPage = function(params) {
        var http_request = this.createRequest();

        if (http_request != null) {
            http_request.onreadystatechange = function() { AJAX.processControl(http_request, params);};
            http_request.open('POST', params.getCompleteURL(), true);
            http_request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            http_request.send(params.post);
            return true;
        }else{
            alert("Chyba při inicializaci načítané stránky.");
            return false;
        }
    }

    this.processControl = function(http_request, params) {
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

    this.createRequest = function() {
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
}