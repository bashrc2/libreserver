<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// This receives the yes/no confirmation on initial setup
// of the system and creates the setup.txt file which is
// then detected by the webadmin daemon (libreserver-installer)
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

$output_filename = "index.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['setupconfirmsubmit'])) {
    if(filter_string('setupconfirm')) {
        $confirm = htmlspecialchars($_POST['setupconfirm']);

        if($confirm == "1") {
            if(file_exists(".temp_setup.txt")) {
                // This gets changed by web_admin_onion_only
                $output_filename = "setup_domain.html";
            }
            if($output_filename == "setup_installing.html") {
                if(file_exists(".temp_setup.txt")) {
                    exec('mv .temp_setup.txt setup.txt');
                    exec('cp setup_installing.html index.html');
                }
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
