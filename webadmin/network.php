<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Change community network
//
// License
// =======
//
// Copyright (C) 2019 Bob Mottram <bob@libreserver.org>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

include dirname(__FILE__)."/common.php";

$output_filename = "settings.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submitnetworkwaitcancel'])) {
    remainOnScreen($output_filename);
}

if (isset($_POST['submitnetwork'])) {
    if(filter_string('network')) {
        $network = htmlspecialchars($_POST['network']);

        $network_file = fopen(".network.txt", "w") or die("Unable to create network file");
        fwrite($network_file, $network);
        fclose($network_file);

        if (file_exists("settings_".$network.".html")) {
            $output_filename = "settings_".$network.".html";
        }
        else {
            $output_filename = "network_display.html";
            exec('cp network_wait.html '.$output_filename);
        }
        remainOnScreen($output_filename);
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
