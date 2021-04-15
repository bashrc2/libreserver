<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// This receives the yes/no confirmation when installing
// an app and then begins the install
//
// Apps are installed by adding them to the pending_installs.txt
// file and the webadmin daemon (libreserver-installer) then
// does the actual installation in the background
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

if (isset($_POST['installconfirmsubmit'])) {
    if(filter_string('installconfirm')) {
        $confirm = htmlspecialchars($_POST['installconfirm']);

        if($confirm == "1") {
            $app_name = htmlspecialchars($_POST['app_name']);
            $install_domain = '';
            $freedns_code = '';

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
                if(file_exists("pending_removes.txt")) {
                    // Is this app in the pending_removes list?
                    if(exec('grep '.escapeshellarg("remove_".$app_name).' ./pending_removes.txt')) {
                        if(! exec('grep '.escapeshellarg("remove_".$app_name).'_running ./pending_removes.txt')) {
                            // Not Removing yet so remove from schedule
                            exec('sed -i "/'.escapeshellarg("remove_".$app_name).'/d ./pending_removes.txt');
                        }
                        else {
                            // Removing so don't continue
                            $continue_install=false;
                        }
                    }
                }
            }

            if($continue_install) {
                if(! file_exists("pending_installs.txt")) {
                    $pending_installs = fopen("pending_installs.txt", "w") or die("Unable to create installs file");
                    fclose($pending_installs);
                }

                if(! exec('grep '.escapeshellarg("install_".$app_name).' ./pending_installs.txt')) {
                    if(! file_exists("index_app_installing.html")) {
                        exec('cp index.html index_app_installing.html');
                    }
                    exec('cp app_installing_progress.html index.html');
                    exec('cp app_installing_progress.html installing_progress.html');
                    if(file_exists('icons/'.$app_name.'.png')) {
                        exec('cp icons/'.$app_name.'.png images/installing_app.png');
                    }
                    $pending_installs = fopen("pending_installs.txt", "a") or die("Unable to append to installs file");
                    fwrite($pending_installs, "install_".$app_name.",".$install_domain.",".$freedns_code."\n");
                    fclose($pending_installs);

                    remainOnScreen('');
                    $output_filename = "installing_progress.html";
                }
                else {
                    // The app is already scheduled for installation
                    $output_filename = "app_scheduled.html";
                }
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

// remove confirm screen
if(file_exists("add_app_confirm.html")) {
    exec('rm add_app_confirm.html');
}

?>
