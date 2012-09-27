<?php
    require 'sessions.php';

    class MenuGroup {
        const ID_PREFIX = "menu-group-";
        const CLASS_NAME = "menu-group";


        public $items = Array();
        public $caption;
        
        public function __construct($caption) {
            $this->caption = $caption;
        }
        
        public function toHTML($id) {
            $ret = "";
            $ret .= "<div id=\"".MenuGroup::ID_PREFIX."$id\" class=\"".MenuGroup::CLASS_NAME."\">\n";
            $ret .= "<div class=\"caption\" onclick=\"$('#".MenuGroup::ID_PREFIX."$id > .content').toggle(1000);\">$this->caption</div>\n";
            $ret .= "<div class=\"content\">\n";
            for ($a=0; $a<sizeof($this->items); $a++) {
                $ret .= $this->items[$a]->toHTML($a+1)."\n";
            }
            $ret .= "</div>\n";
            $ret .= "</div>\n";
            
            return $ret;
        }
        
        public function addItem($item) {
            $this->items[] = $item;
        }
    }
    
    class MenuItem {
        const ID_PREFIX = "menu-item-";
        const CLASS_NAME = "menu-item";
        
        public $caption;
        public $constantName;
        
        public function __construct($caption, $constantName) {
            $this->caption = $caption;
            $this->constantName = $constantName == null ? "null" : $constantName;
        }
        
        public function toHTML($id) {
            $ret = "";
            $ret .= "<div id=\"".MenuItem::ID_PREFIX."$id\" class=\"".MenuItem::CLASS_NAME."\" onclick=\"navigate($this->constantName, null)\">";
            $ret .= "$this->caption";
            $ret .= "</div>";
            
            return $ret;
        }
    }
    
    class Menu {
        const ID = "menu-bar";
        const CLASS_NAME = "menu-bar";
        
        public $groups = Array();
        
        public function toHTML() {
            $ret = "";
            $ret .= "<div id=\"".Menu::ID."\" class=\"".Menu::CLASS_NAME."\">";
            for ($a=0; $a<sizeof($this->groups); $a++) {
                $ret .= $this->groups[$a]->toHTML($a+1)."\n";
            }
            $ret .= "</div>";
            
            return $ret;
        }
        
        public function addGroup($group) {
            $this->groups[] = $group;
        }
    }
    
    $menu = new Menu();
    
    $menu->addGroup(new MenuGroup("Recepty"));
    $menu->groups[0]->addItem(new MenuItem("Home", "PAGE_HOME"));
    $menu->groups[0]->addItem(new MenuItem("Přehled", ""));
    $menu->addGroup(new MenuGroup("Hledání"));
    $menu->groups[1]->addItem(new MenuItem("Podle parametrů", "PAGE_SEARCH_PARAMS"));
    $menu->groups[1]->addItem(new MenuItem("Podle složení", null));
    $menu->addGroup(new MenuGroup("Uživatel"));
    $menu->groups[2]->addItem(new MenuItem("Nastavení", null));
    
    echo $menu->toHTML();
?>