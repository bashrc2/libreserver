<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Sets a static IP address
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

if (isset($_POST['submitipcancel'])) {
    remainOnScreen($output_filename);
}

if (isset($_POST['submitip'])) {
    if(filter_string('staticipconfirm')) {
        $confirm = htmlspecialchars($_POST['staticipconfirm']);
        if($confirm == "1") {
            if(filter_string('ip_address')) {
                $ip_address = trim(htmlspecialchars($_POST['ip_address']));
                if (filter_var($ip_address, FILTER_VALIDATE_IP)) {
                    if(filter_string('gateway_ip')) {
                        $gateway_ip = trim(htmlspecialchars($_POST['gateway_ip']));
                        if (filter_var($ip_address, FILTER_VALIDATE_IP)) {
                            $ip_address_file = fopen(".static_ip_address.txt", "w") or die("Unable to create static_ip_address file");
                            fwrite($ip_address_file, $ip_address.",".$gateway_ip);
                            fclose($ip_address_file);
                        }
                    }
                }
            }
        }
        else {
            $ip_address_file = fopen(".ip_address.txt", "w") or die("Unable to create ip_address file");
            fwrite($ip_address_file, "dynamic");
            fclose($ip_address_file);
        }

        remainOnScreen($output_filename);
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
