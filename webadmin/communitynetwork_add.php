<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Add a Community Network node
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

$output_filename = "settings_communitynetwork.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submitaddremovecancel'])) {
    remainOnScreen($output_filename);
}

if (isset($_POST['submitadd'])) {
    if(filter_string('node_name')) {
        $node_name = trim(htmlspecialchars($_POST['node_name']));
        if($node_name != '') {
            if(filter_string('longitude', 32)) {
                $longitude = trim(htmlspecialchars($_POST['longitude']));
                if (is_numeric($longitude)) {
                    if(filter_string('latitude', 32)) {
                        $latitude = trim(htmlspecialchars($_POST['latitude']));
                        if (is_numeric($latitude)) {
                            if(filter_string('ip_address', 128)) {
                                $ip_address = trim(htmlspecialchars($_POST['ip_address']));
                                ip_address_valid = 1;
                                if ($ip_address != '') {
                                    ip_address_valid = 0;
                                    if (filter_var($ip_address, FILTER_VALIDATE_IP)) {
                                        ip_address_valid = 1;
                                    }
                                }
                                if ($ip_address_valid === 1) {
                                    $network_add_file = fopen(".communitynetwork_add.txt", "w") or die("Unable to create network add file");
                                    fwrite($network_add_file, $node_name.";".$longitude.";".$latitude.";".$ip_address);
                                    fclose($network_add_file);
                                }
                            }
                        }
                    }
                }
            }
        }

        remainOnScreen($output_filename);
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
