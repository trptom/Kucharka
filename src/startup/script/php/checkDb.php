<?php
    require 'logger.php';
    require 'validator.php';
    
    Logger::log("CheckDB started", Logger::TYPE_INFO);
    
    $cont = true;
    
    $cont == validateDbPost();
    
    if ($cont) {
        if (($db = mysql_connect($_POST["dbServer"], $_POST["dbUser"], $_POST["dbPassword"])) == false) {
            Logger::log("Connection failed", Logger::TYPE_ERROR);
            $cont = false;
        } else {
            Logger::log("Connection succesfull", Logger::TYPE_OK);
        }
    }
    
    if ($cont) {
        if (mysql_select_db($_POST["dbName"], $db) == false) {
            Logger::log("Database selecting failed", Logger::TYPE_ERROR);
            $cont = false;
        } else {
            Logger::log("Database selected", Logger::TYPE_OK);
        }
    }
    
    if ($cont) {
        if (mysql_close($db) == false) {
            Logger::log("Database closing failed", Logger::TYPE_ERROR);
            $cont = false;
        } else {
            Logger::log("Database closed", Logger::TYPE_OK);
        }
    }
    
    Logger::log("CheckDB finished", Logger::TYPE_INFO);
?>
