<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Shuts down or resets the system
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

$output_filename = "settings.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submitreset'])) {
    $reset_file = fopen(".reset.txt", "w") or die("Unable to write to reset file");
    fwrite($reset_file, "reset");
    fclose($reset_file);

    $output_filename = "restarting.html";
}

if (isset($_POST['submitupgradeoperatingsystem'])) {
    $output_filename = "upgrade_os.html";
}

if (isset($_POST['submitupgradeoperatingsystemconfirm'])) {
    $upgrade_file = fopen(".upgradeos.txt", "w") or die("Unable to write to upgradeos file");
    fwrite($upgrade_file, "upgrade");
    fclose($upgrade_file);
    $output_filename = "index.html";
}

if (isset($_POST['submitfactoryreset'])) {
    $output_filename = "factory_reset_confirm.html";
}

if (isset($_POST['submitshutdown'])) {
    $shutdown_file = fopen(".shutdown.txt", "w") or die("Unable to write to shutdown file");
    fwrite($shutdown_file, "shutdown");
    fclose($shutdown_file);

    $output_filename = "shutting_down.html";
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
