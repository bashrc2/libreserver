<?php

//  _____               _           _
// |   __|___ ___ ___ _| |___ _____| |_ ___ ___ ___
// |   __|  _| -_| -_| . | . |     | . | . |   | -_|
// |__|  |_| |___|___|___|___|_|_|_|___|___|_|_|___|
//
//                              Freedom in the Cloud
//
// irc settings menu
//
// License
// =======
//
// Copyright (C) 2021 Bob Mottram <bob@freedombone.net>
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

$output_filename = "app_irc.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submitircpassword'])) {
    if(filter_string('irc_password',1024)) {
        $pass = trim(htmlspecialchars($_POST['irc_password']));
	$settings_file = fopen(".appsettings.txt", "w") or die("Unable to write to appsettings file");
        fwrite($settings_file, "irc,password,".$pass);
        fclose($settings_file);
    }
    else {
        $output_filename = "invalid_password.html";
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
