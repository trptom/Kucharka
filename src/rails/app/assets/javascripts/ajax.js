var Ajax = new function() {
    /**
    * Načte stránku pomocí AJAXu.
    * @param URL adresa načítané stránky.
    * @param request_type typ pozadavku ("POST"/"GET")
    * @param request pozadavek, odeslaný současně se stránkou.
    * @param successFunc funkce, ktera je volana s parametrem request pri
    * uspesnem nacteni.
    * @param errorFunc funkce, ktera je volana s parametrem request pri chybnem
    * nacteni.
    * @param async true, pokud ma byt nacitani provedeno asynchronne, jinak
    * false. Pokud je uvedena jina hodnota / neni uvedena zadna, defaultni je
    * true.
    */
    this.loadPage = function(URL, request_type, request, successFunc, errorFunc, async) {
        var http_request = this.createRequest();

        if (http_request != null) {
            http_request.onreadystatechange = function() {Ajax.readyStateChanged(http_request, successFunc, errorFunc);};
            http_request.open(request_type, URL, async);
            http_request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            http_request.send(request);
            return true;
        } else {
            alert("Chyba při inicializaci načítané stránky.");
            return false;
        }
    }
    
    this.readyStateChanged = function(http_request, successFunc, errorFunc) {
        if (http_request.readyState == 4) {
            if (http_request.status == 200) {
                successFunc(http_request);
            } else {
                errorFunc(http_request);
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
    
    this.getErrorString = function(request, prefix, suffix) {
        if (request == null) {
            throw "request nesmi byt null";
        }
        
        return ((prefix == null) ? "" : prefix)
                + "AJAX chyba (status: " + request.status + ", state: " + request.readyState + ")"
                + ((suffix == null) ? "" : suffix);
    }
    
    this.DEFAULT_ERR_FUNC = function(request) {
        alert(Ajax.getErrorString(request, null, null));
    }
}