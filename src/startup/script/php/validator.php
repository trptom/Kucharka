<?php
    require_once 'logger.php';

    function validateDbPost() {
        $ret = true;
        
        if (!isset($_POST["dbServer"])) {
            Logger::log ("Database server POST missing.", Logger::TYPE_ERROR);
            $ret = false;
        }
        if (!isset($_POST["dbName"])) {
            Logger::log ("Database name POST missing.", Logger::TYPE_ERROR);
            $ret = false;
        }
        if (!isset($_POST["dbUser"])) {
            Logger::log ("Database user POST missing.", Logger::TYPE_ERROR);
            $ret = false;
        }
        if (!isset($_POST["dbPassword"])) {
            Logger::log ("Database password POST missing.", Logger::TYPE_ERROR);
            $ret = false;
        }
        
        return $ret;
    }
?>
