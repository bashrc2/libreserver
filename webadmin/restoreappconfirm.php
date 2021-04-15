<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// This receives the yes/no confirmation when restoring
// an app from backup and then begins the restore
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

$output_filename = "apps.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['restoreconfirmsubmit'])) {
    if(filter_string('restoreconfirm')) {
        $confirm = htmlspecialchars($_POST['restoreconfirm']);
        if(filter_string('password')) {
            $password = htmlspecialchars($_POST['password']);

            if($confirm == "1") {
                if(filter_string('app_name')) {
                    $app_name = htmlspecialchars($_POST['app_name']);

                    $restore_app_file = fopen(".restore_app.txt", "w") or die("Unable to append to restore_app file");
                    fwrite($restore_app_file, $app_name.','.$password);
                    fclose($restore_app_file);

                    // create the restore screen for the app
                    exec('cp restore_app_progress_template.html restore_app_progress.html');
                    if(file_exists("restore_app_progress.html")) {
                        $output_filename = "restore_app_progress.html";
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
if(file_exists("restore_app_confirm.html")) {
    exec('rm restore_app_confirm.html');
}

?>
