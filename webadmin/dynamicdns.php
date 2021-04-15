<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Change dynamic DNS settings
//
// License
// =======
//
// Copyright (C) 2018-2019 Bob Mottram <bob@libreserver.org>
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

if (isset($_POST['submitddnshelp'])) {
    $output_filename = "help_dynamicdns.html";
}

if (isset($_POST['submitddnsdomain'])) {
    $output_filename = "change_domain.html";
}

if (isset($_POST['submitdnsovertls'])) {
    $output_filename = "dns_over_tls.html";
}

if (isset($_POST['submitddns'])) {
    if(filter_string('dynamicdns')) {
        $ddns = htmlspecialchars($_POST['dynamicdns']);
        if(filter_string('ddns_username')) {
            $ddns_username = htmlspecialchars($_POST['ddns_username']);
            if(filter_string('ddns_password', 1024)) {
                $ddns_password = $_POST['ddns_password'];
                if(filter_string('ddnscode', 1024)) {
                    $ddns_code = htmlspecialchars($_POST['ddnscode']);

                    $ddns_password_file = fopen(".dynamicdnspassword.txt", "w") or die("Unable to create dynamicdnspassword file");
                    fwrite($ddns_password_file, $ddns_password);
                    fclose($ddns_password_file);

                    $ddns_file = fopen(".dynamicdns.txt", "w") or die("Unable to create dynamicdns file");
                    fwrite($ddns_file, $ddns.','.$ddns_username.','.$ddns_code);
                    fclose($ddns_file);
                }
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
