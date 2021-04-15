<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Update playlist settings for icecast
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

$output_filename = "app_icecast.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submiticecast'])) {
    if(filter_string('icecast_name')) {
        $icecast_name = trim(htmlspecialchars($_POST['icecast_name']));
        if(filter_string('icecast_description')) {
            $icecast_description = trim(htmlspecialchars($_POST['icecast_description']));
            if(filter_string('icecast_genre')) {
                $icecast_genre = trim(htmlspecialchars($_POST['icecast_genre']));

                if(($icecast_name === '') || ($icecast_description === '') || ($icecast_genre === '')) {
                    $output_filename = "icecast_missing_fields.html";
                }
                else {
                    $icecast_file = fopen(".icecast.txt", "w") or die("Unable to write to icecast file");
                    fwrite($icecast_file, $icecast_name.','.$icecast_description.','.$icecast_genre);
                    fclose($icecast_file);

                    $output_filename = "icecast_updating.html";
                }
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
