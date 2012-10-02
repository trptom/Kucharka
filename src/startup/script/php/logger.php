<?php
    class Logger {
        const TYPE_ERROR = "ERROR:#990000";
        const TYPE_OK = "OK:#009900";
        const TYPE_WARNING = "WARNING:#999900";
        const TYPE_INFO = "INFO:#000099";
        
        public static function log($msg, $type = null) {
            $parts = split(":", ($type == null) ? Logger::TYPE_INFO : $type);
            echo "<div>".date("Y-m-d h:i:s").": <span style=\"color: $parts[1]\">&lt;$parts[0]&gt; $msg</span></div>";
        }
    }
?>
