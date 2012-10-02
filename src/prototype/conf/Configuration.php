<?php
    class Configuration {
        /*
         * Udaje pro spojeni s DB.
         */
        const DB_SERVER = "localhost";
        const DB_NAME = "kucharka";
        const DB_USER = "root";
        const DB_PASSWORD = "";
        
        /*
         * Eventy, ktere se zapisuji do Db k zaznamum, ktere muhou byt spojeny
         * s ruznymi tabulkami.
         */
        const EVENT_RECIPE = 0;
        const EVENT_INGREDIENCE = 1;
        const EVENT_COMMENT = 2;
        const EVENT_USER = 3;
        const EVENT_RANKING = 4;
        const EVENT_COMMENT = 5;
    }
?>
