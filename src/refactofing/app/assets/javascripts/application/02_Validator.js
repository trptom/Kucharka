function Validation(element, method, atts, group) {
    this.element = element;
    this.method = method;
    this.atts = atts;
    this.group = group;
}

Validation.prototype.validate = function(errorsElementId) {
    var value = null;
    if (this.element.value !== undefined) {
        value = this.element.value;
    } else if (this.element.selectedIndex !== undefined) {
        value = this.element.selectedIndex.toString();
    } else if (this.element.innerHTML !== undefined) {
        value = this.element.innerHTML;
    } else {
        return false;
    }

    if (value == null && this.atts.nullAllowed ||
            value == "" && this.atts.emptyAllowed) {
        return true;
    }

    var result = this.method(value, this.atts);

    if (result === true) {
        return true;
    } else {
        Validator.addError(result, errorsElementId)
        return false;
    }
}

var Validator = {
    ERRORS_DIV_ID: "errors-enum",
    DEFAULT_ERROR_MESSAGE: "Formulář obsahuje chyby!",

    validations: [],

    /**
     * Provede validaci nad vsemi pridanymi validatory tohoto objektu podle
     * nastavenych atributu.
     * @param {Object} atts objekt atributu. Muze obsahovat nasledujici
     * vlastnosti:
     * <ul>
     * <li><b>group</b>: skupina nad kterou se ma provest validace.</li>
     * <li><b>showMessage</b>: pokud je true, zobrazi se alert s defaultni
     * zpravou, pokud je nastaven jiny objekt, je zobrazen alert s jeho toString
     * vysledkem.</li>
     * <li><b>errorsElementId</b>: id elementu, do ktereho se pridavaji chybove
     * hlasky. Je posilano jako parametr metody addError/clearErrors.</li>
     * </ul>
     * @return {Boolean} true, pokud byla validace uspecna (zadny z validatoru
     * nehlasi chybu), jinak false.
     */
    validate: function(atts) {
        atts = atts ? atts : {};
        Validator.clearErrors(atts.errorsElementId);
        var returnValue = true;
        for (var index in Validator.validations) {
            if (!atts.group || Validator.validations[index].group === atts.group) {
                if (!Validator.validations[index].validate(atts.errorsElementId)) {
                    returnValue = false;
                }
            }
        }
        if (!returnValue && atts.showMessage) {
            alert(atts.showMessage === true ? Validator.DEFAULT_ERROR_MESSAGE : atts.showMessage);
        }
        return returnValue;
    },
    /**
     * Vymaze vsechny potomky DIV elementu, ktery ma obsahovat chybove hlaseni.
     * To v praxi znamena, ze ze stranky zmizi vsechny predchozi chybove hlasky.
     * @param {String} errorsElementId id elementu, ktery ma byt vycisten.
     * Pokud je null nebo neni uvedeno, cisti se defaultni.
     */
    clearErrors: function(errorsElementId) {
        var errors = document.getElementById(errorsElementId ? errorsElementId : Validator.ERRORS_DIV_ID);
        if (errors) {
            while (errors.childNodes.length > 0) {
                errors.removeChild(errors.firstChild);
            }
        }
    },
    /**
     * Prida chybovou hlasku na stranku do predpripraveneho DIV elementu. Pokud
     * element pro chyby neexistuje, neni vykonana yadna akce.
     * @param {Object|Array} lines obsah chybove hlasky. Muye byt pole nebo
     * objekt. Objekt je preveden na jednoprvkove pole. Vsechny polozky pole
     * jsou pak zobrazeny jako jednotlive radky.
     * @param {String} errorsElementId id elementu, kam ma byt chyba pridana.
     * Pokud je null nebo neni uvedeno, pridava se do defaultniho.
     * @return {Boolean} true, pokud byla chybova hlaska uspesne pridana, jinak
     * false.
     */
    addError: function(lines, errorsElementId) {
        var errors = document.getElementById(errorsElementId ? errorsElementId : Validator.ERRORS_DIV_ID);
        if (errors) {
            var newElem = document.createElement("div");
            newElem.className = "alert alert-error";

            newElem.closeBut = document.createElement("button");
            newElem.closeBut.setAttribute("type", "button");
            newElem.closeBut.setAttribute("class", "close");
            newElem.closeBut.setAttribute("data-dismiss", "alert");
            newElem.closeBut.innerHTML = "&times;";

            newElem.strongLbl = document.createElement("strong");
            newElem.strongLbl.innerHTML = "Chyba!";

            newElem.appendChild(newElem.closeBut);
            newElem.appendChild(newElem.strongLbl);

            if (!$.isArray(lines)) {
                lines = [ lines ];
            }
            for (var index in lines) {
                newElem.appendChild(document.createElement("br"));
                newElem.appendChild(document.createTextNode(lines[index]));
            }

            errors.appendChild(newElem);
            return true;
        }
        return false;
    },
    /**
     * Prida validaci do seznamu validaci tohoto objektu. Pri volani validate()
     * jsou pak prochazeny vsechny takto pridane validace.
     * @param {String|HTMLElement} element HTML element, ktery je validovan.
     * Pokud je zadan string, je nalezen v DOMu element se stejnym ID. Tento
     * element musi obsahovat atribut value, selectedIndex nebo innerHTML, aby
     * mohl byt zvalidovan. Pokud obsahoje vice y techto atributu, je volana
     * validace pouze pro prvni z nich, podle vyse uvedeneho poradi.
     * @param {Validator.METHOD} method metoda validace.
     * @param {Object} atts parametry predavane metode validace. Kazda metoda
     * akceptuje jine atributy, ktere jsou popsany v jejim JavaScript docu.
     * Navic muze pro kazdou metodu obsahovat i atributy nullAllowed
     * a emptyAllowed, ktere povoluji jako platnou hodnotu null resp. prazdny
     * retezec.
     * @param {Object} group skupina, do ktere ma byt validace pridana. Pri
     * volani funkce validate() je pak mozne urcit pouze skupinu, pro kterou ma
     * byt validace provadena. Toto je vhodne zejmena v pripade vice formularu
     * na strance, aby se pri kliknuti na submit nevalidovaly i vsechny ostatni.
     * @return {Boolean} true, pokud se pridavani podarilo, janak false. Pri
     * spatnem pridavani je navic chyba zalogovana do konzole.
     */
    addValidation: function(element, method, atts, group) {
        if (element && method) {
            element = (typeof element === "string") ? document.getElementById(element) : element;
            atts = atts ? atts : [];
            Validator.validations[Validator.validations.length] = new Validation(element, method, atts, group);
            return true;
        } else {
            console.log("illegal validation attributes (element=" + element
                    + ", metod=" + method + ")");
            return false;
        }
    },

    /**
     * Objekt validacnich metod.
     */
    METHOD: {
        /**
         * Validace celociselne hodnoty.
         * @param {String} value
         * @param {Object} atts objekt nastavitelnych atributu. Muze obsahovat
         * nasledujici vlastnosti:
         * <ul>
         * <li><b>radix</b>: soustava, podle ktere se ma value parsovat
         * a nasledne porovnavat s minimem a maximem. Pokud neni uvedeno, je
         * pouzita desitkova soustava.</li>
         * <li><b>min</b>: minimalni hodnota (vcetne). Pokud neni uvedena, neni
         * provadena validace na minimalni hodnotu.</li>
         * <li><b>max</b>: maximalni hodnota (vcetne). Pokud neni uvedena, neni
         * provadena validace na maximalni hodnotu.</li>
         * <li><b>minErrorMessage</b>: chybova hlaska pri nesplneni kriteria
         * minimalni hodnoty. Pokud neni uvedena, je pouzita vychozi hlaska.
         * </li>
         * <li><b>maxErrorMessage</b>: chybova hlaska pri nesplneni kriteria
         * maximalni hodnoty. Pokud neni uvedena, je pouzita vychozi hlaska.
         * </li>
         * <li><b>notANumberErrorMessage</b>: chybova hlaska pokud nejde
         * o cislo. Pokud neni uvedena, je pouzita vychozi hlaska.</li>
         * </ul>
         */
        INTEGER: function(value, atts) {
            var errors = [];
            if ($.isNumeric(value)) {
                value = parseInt(value, atts.radix ? atts.radix : 10);
                if ($.isNumeric(atts.min) && value < atts.min) {
                    errors[errors.length] = atts.minErrorMessage ?
                            atts.minErrorMessage :
                            (value + " není celé číslo >= " + atts.min);
                }
                if ($.isNumeric(atts.max) && value > atts.max) {
                    errors[errors.length] = atts.minErrorMessage ?
                            atts.maxErrorMessage :
                            (value + " není celé číslo <= " + atts.max);
                }
            } else {
                errors[errors.length] = atts.notANumberErrorMessage ?
                        atts.notANumberErrorMessage :
                        (value + " není celé číslo");
            }

            return errors.length > 0 ? errors : true;
        },
        /** TODO */
        DECIMAL: function(value, atts) {
            var errors = [];
            if ($.isNumeric(value)) {
                value = parseFloat(value);
                if ($.isNumeric(atts.min) && value < atts.min) {
                    errors[errors.length] = atts.minErrorMessage ?
                            atts.minErrorMessage :
                            (value + " není číslo >= " + atts.min);
                }
                if ($.isNumeric(atts.max) && value > atts.max) {
                    errors[errors.length] = atts.minErrorMessage ?
                            atts.maxErrorMessage :
                            (value + " není číslo <= " + atts.max);
                }
            } else {
                errors[errors.length] = atts.notANumberErrorMessage ?
                        atts.notANumberErrorMessage :
                        (value + " není číslo");
            }

            return errors.length > 0 ? errors : true;
        },
        /**
         * Validace textove hodnoty.
         * @param {String} value
         * @param {Object} atts objekt nastavitelnych atributu. Muze obsahovat
         * nasledujici vlastnosti:
         * <ul>
         * <li><b>minLength</b>: minimalni delka retezce (vcetne). Pokud neni
         * uvedena, neni provadena validace na minimalni delku.</li>
         * <li><b>maxLength</b>: maximalni delka retezce (vcetne). Pokud neni
         * uvedena, neni provadena validace na maximalni delku.</li>
         * <li><b>minLengthErrorMessage</b>: chybova hlaska pri nesplneni
         * kriteria minimalni delky. Pokud neni uvedena, je pouzita vychozi
         * hlaska.</li>
         * <li><b>maxLengthErrorMessage</b>: chybova hlaska pri nesplneni
         * kriteria maximalni delky. Pokud neni uvedena, je pouzita vychozi
         * hlaska.</li>
         * </ul>
         */
        TEXT: function(value, atts) {
            var errors = [];
            if (atts.minLength && value.length < atts.minLength) {
                errors[errors.length] = atts.minLengthErrorMessage ?
                        atts.minLengthErrorMessage :
                        "délka je menší než " + atts.minLength + " znaků";
            }
            if (atts.maxLength && value.length > atts.maxLength) {
                errors[errors.length] = atts.maxLengthErrorMessage ?
                        atts.maxLengthErrorMessage :
                        "překročena maximální délka " + atts.maxLength + " znaků";
            }
            return errors.length > 0 ? errors : true;
        },
        EMAIL: function(value, atts) {
            return false; // TODO
        }
    }
}