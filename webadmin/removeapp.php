<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// This is used to begin removing an app.
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

$output_filename = "apps.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['uninstall'])) {
    if(filter_string('app_name')) {
        $app_name = htmlspecialchars($_POST['app_name']);

        // create the confirm screen populated with details for the app
        exec('cp remove_app_confirm_template.html remove_app_confirm.html');
        if(file_exists("remove_app_confirm.html")) {
            exec('sed -i "s|APPNAME|'.$app_name.'|g" remove_app_confirm.html');
            $output_filename = "remove_app_confirm.html";
        }
    }
}

if (isset($_POST['submitappsettings'])) {
    $app_name = htmlspecialchars($_POST['app_name']);
    $output_filename = "settings_".$app_name.".html";
}

if (isset($_POST['submithelp'])) {
    $app_name = htmlspecialchars($_POST['app_name']);
    $output_filename = "help_".$app_name.".html";
}

if (isset($_POST['submitapprestore'])) {
    $app_name = htmlspecialchars($_POST['app_name']);

    // create the confirm screen populated with details for the app
    exec('cp restore_app_confirm_template.html restore_app_confirm.html');
    if(file_exists("restore_app_confirm.html")) {
        if(file_exists('icons/'.$app_name.'.png')) {
            exec('cp icons/'.$app_name.'.png images/restore_app_progress.png');
            exec('sed -i "s|APPNAME|'.$app_name.'|g" restore_app_confirm.html');
            $output_filename = "restore_app_confirm.html";
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
