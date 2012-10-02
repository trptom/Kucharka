<?php
    class Configuration {
        /*
         * Udaje pro spojeni s DB.
         */
        const DB_SERVER = "<% DB_SERVER %>";
        const DB_NAME = "<% DB_NAME %>";
        const DB_USER = "<% DB_USER %>";
        const DB_PASSWORD = "<% DB_PASSWORD %>";
        
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
