<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Adds a new user to the system
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

$output_filename = "users.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submitnewuser'])) {
    if(filter_string('username')) {
        $username = htmlspecialchars($_POST['username']);

        if (!preg_match('/^[a-z\d_]{3,32}$/', $username)) {
            $output_filename = "new_user_invalid.html";
        }
        else {
            // Don't rely on php PRNG
            $newpassword = rtrim(exec('diceware'));
            $new_user_file = fopen(".new_user.txt", "w") or die("Unable to write to new_user file");
            fwrite($new_user_file, $username.",".$newpassword);
            fclose($new_user_file);

            exec('cp new_user_confirm_template.html new_user_confirm.html');
            exec('sed -i "s|NEWPASSWORD|'.$newpassword.'|g" new_user_confirm.html');
            $output_filename = "new_user_confirm.html";
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
