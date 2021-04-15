<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// This receives the yes/no confirmation when removing
// an app and then begins the removal
//
// Apps are removed by adding them to the pending_removes.txt
// file and the webadmin daemon (libreserver-installer) then
// does the actual removal in the background
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

if (isset($_POST['removeconfirmsubmit'])) {
    if(filter_string('removeconfirm')) {
        $confirm = htmlspecialchars($_POST['removeconfirm']);

        if($confirm == "1") {
            if(filter_string('app_name')) {
                $app_name = htmlspecialchars($_POST['app_name']);

                $continue_remove=true;
                if(file_exists("pending_installs.txt")) {
                    // Is this app in the pending_installs list?
                    if(exec('grep '.escapeshellarg("install_".$app_name).' ./pending_installs.txt')) {
                        if(! exec('grep '.escapeshellarg("install_".$app_name).'_running ./pending_installs.txt')) {
                            // Not installing yet so remove from schedule
                            exec('sed -i "/'.escapeshellarg("install_".$app_name).'/d ./pending_installs.txt');
                        }
                        else {
                            // Installing so don't continue
                            $continue_remove=false;
                        }
                    }
                }

                if($continue_remove) {
                    if(! file_exists("pending_removes.txt")) {
                        $pending_removes = fopen("pending_removes.txt", "w") or die("Unable to create removes file");
                        fclose($pending_removes);
                    }

                    if(! exec('grep '.escapeshellarg("remove_".$app_name).' ./pending_removes.txt')) {
                        $pending_removes = fopen("pending_removes.txt", "a") or die("Unable to append to removes file");
                        fwrite($pending_removes, "remove_".$app_name."\n");
                        fclose($pending_removes);
                        $output_filename = "app_remove.html";
                    }
                    else {
                        // The app is already scheduled for removal
                        $output_filename = "app_remove_scheduled.html";
                    }
                }
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

// remove confirm screen
if(file_exists("remove_app_confirm.html")) {
    exec('rm remove_app_confirm.html');
}

?>
