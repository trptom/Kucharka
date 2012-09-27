var LightBox = new function() {
    this.createInstance = function(zIndex, parentElement, contentElement) {
        var lightBox = document.createElement("div");
        parentElement = (parentElement == null) ? document.body : parentElement;
        
        /*
         * INIT
         */

        lightBox.contentElement = contentElement;
        lightBox.className = "lightbox hidden";
        lightBox.style.zIndex = (zIndex != null) ? zIndex : parentElement.style.zIndex;
        
//        lightBox.clientHeight = parentElement.clientHeight;

        /*
         * ACTIONS
         */

        lightBox.onclick = function(e) {
            if (!e) e = window.event;
            if (e.srcElement == this || e.srcElement == this.formatter) {
                this.hide();
            }
        }

        /*
         * CONSTRUCT
         */

        parentElement.appendChild(lightBox);
        lightBox.appendChild(lightBox.contentElement);

        $(lightBox).hide();

        /*
         * FUNCTIONS
         */
        lightBox.show = function() {
            $(this).removeClass("hidden");
            $(this).fadeIn(500);
        }

        lightBox.hide = function() {
            $(this).addClass("hidden");
            $(this).fadeOut(500);
        }
        
        lightBox.visible = function() {
            return this.className.indexOf("hidden") == -1;
        }
        
        return lightBox;
    }
}

