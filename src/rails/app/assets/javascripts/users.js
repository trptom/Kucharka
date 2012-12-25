var UserRights = new function() {
    this.init = function() {
        this.selfRuleset = document.getElementById("self_ruleset");
        this.othersRuleset = document.getElementById("others_ruleset");
        this.selfGroup = document.getElementById("defined_rules_self");
        this.othersGroup = document.getElementById("defined_rules_other");
        this.globalGroup = document.getElementById("defined_rules_global");
    }

    this.update = function(checked, value, type) {
        if (type == 0 || type == 2) {
            if (checked) {
                this.selfRuleset.value = this.selfRuleset.value | value
            } else {
                this.selfRuleset.value = this.selfRuleset.value & (value ^ -1);
            }
        }
        if (type == 1 || type == 2) {
            if (checked) {
                this.othersRuleset.value = this.othersRuleset.value | value
            } else {
                this.othersRuleset.value = this.othersRuleset.value & (value ^ -1);
            }
        }
    }
}

$(document).ready(function() {
    UserRights.init();
});