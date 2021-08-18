<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
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

// Backup password screen for getting the password
// prior to backup or restore

$output_filename = "backup.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submitbackuppassword'])) {
    $pass = trim(htmlspecialchars($_POST['backup_password']));
    if(strlen($pass) > 5) {
        if(strlen($pass) < 1024) {
            $pass_confirm = trim(htmlspecialchars($_POST['backup_password_confirm']));
            if ($pass === $pass_confirm) {
                if (strpos($pass, ' ') === false) {
                    if (preg_match('/^[a-zA-Z0-9_]{8,512}$/', $pass)) {
                        $settings_file = fopen("/tmp/backup_password.txt", "w") or die("Unable to write to backup_password file");
                        fwrite($settings_file, $pass);
                        fclose($settings_file);

                        if(! file_exists(".start_backup")) {
                            exec('touch .start_backup');
                        }
                        exec('cp backup_progress_template.html backup_progress.html');

                        $output_filename = "backup_progress.html";
                        remainOnScreen($output_filename);
                    }
                    else {
                        $output_filename = "invalid_backup_password.html";
                    }
                }
                else {
                    $output_filename = "invalid_backup_password.html";
                }
            }
            else {
                $output_filename = "invalid_password_match.html";
            }
        }
        else {
            $output_filename = "invalid_backup_password.html";
        }
    }
    else {
        $output_filename = "invalid_backup_password.html";
    }
}

if (isset($_POST['submitrestorepassword'])) {
    $pass = trim(htmlspecialchars($_POST['backup_password']));
    if (strlen($pass) > 5) {
        if (strlen($pass) < 1024) {
            if (strpos($pass, ' ') === false) {
                if (preg_match('/^[a-zA-Z0-9_]{8,512}$/', $pass)) {
                    $settings_file = fopen("/tmp/backup_password.txt", "w") or die("Unable to write to backup_password file");
                    fwrite($settings_file, $pass);
                    fclose($settings_file);

                    if(! file_exists(".start_restore")) {
                        exec('touch .start_restore');
                    }
                    exec('cp restore_progress_template.html restore_progress.html');
                    $output_filename = "restore_progress.html";
                    remainOnScreen($output_filename);
                }
                else {
                    $output_filename = "invalid_backup_password.html";
                }
            }
            else {
                $output_filename = "invalid_backup_password.html";
            }
        }
        else {
            $output_filename = "invalid_backup_password.html";
        }
    }
    else {
        $output_filename = "invalid_backup_password.html";
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
