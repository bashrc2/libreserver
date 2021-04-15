<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// This is used to begin installing an app.
//
// It creates the confirm screen, populates the variables
// in it and then opens it.
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

$output_filename = "apps_add.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submitappinstall'])) {
    if(filter_string('app_name')) {
        $app_name = htmlspecialchars($_POST['app_name']);
        $install_domain = '';
        $freedns_code = '';
        $no_domain='0';

        // Note that this value can be changed by install_web_admin
        $onion_only=false;

        $continue_install=true;

        if(! $onion_only) {
            $no_domain = htmlspecialchars($_POST['no_domain']);
            if ($no_domain === '0') {
                if(filter_string('install_domain')) {
                    $install_domain = htmlspecialchars($_POST['install_domain']);
                    if (strpos($install_domain, '.') === false) {
                        // No domain was provided
                        $continue_install=false;
                    }
                }
                else {
                    // domain name was too long
                    $continue_install=false;
                }
            }
        }

        if($continue_install) {
            // create the confirm screen populated with details for the app
            exec('cp add_app_confirm_template.html add_app_confirm.html');
            if(file_exists("add_app_confirm.html")) {
                exec('sed -i "s|APPNAME|'.$app_name.'|g" add_app_confirm.html');
                exec('sed -i "s|APPDOMAIN|'.$install_domain.'|g" add_app_confirm.html');
                exec('sed -i "s|NODOMAIN|'.$no_domain.'|g" add_app_confirm.html');
                $output_filename = "add_app_confirm.html";
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
