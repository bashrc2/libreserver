<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Cancels an app during its installation
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

$output_filename = "index.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['installcancelsubmit'])) {

    remainOnScreen('');

    if(file_exists('index_app_installing.html')) {
        exec('cp index_app_installing.html index.html');
        exec('rm index_app_installing.html');
    }
    if(file_exists('installing_progress.html')) {
        exec('rm installing_progress.html');
    }

    $cancel_file = fopen(".cancel_install.txt", "w") or die("Unable to create cancel file");
    fwrite($cancel_file, 'cancel');
    fclose($cancel_file);

    $output_filename = "index.html";
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
