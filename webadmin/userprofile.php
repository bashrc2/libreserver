<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Functions available from the user's profile
// Remove, change password
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

if (isset($_POST['submitnotification'])) {
    $username = htmlspecialchars($_POST['myuser']);
    $notification_type = htmlspecialchars($_POST['notification_type']);
    
    $notification_type_file = fopen(".notification_type.txt", "w") or die("Unable to write to notification type file");
    if (isset($_POST['admin_notify'])) {
       fwrite($notification_type_file, $username.",".$notification_type.",1");
    }
    else {
       fwrite($notification_type_file, $username.",".$notification_type.",0");
    }
    fclose($notification_type_file);
}

if (isset($_POST['submitremoveuser'])) {
    if(filter_string('myuser')) {
        $username = htmlspecialchars($_POST['myuser']);

        $remove_user_file = fopen(".temp_remove_user.txt", "w") or die("Unable to write to domain file");
        fwrite($remove_user_file, $username);
        fclose($remove_user_file);

        if(file_exists("remove_user_confirm_template.html")) {
            exec('cp remove_user_confirm_template.html remove_user_confirm.html');
            exec('sed -i "s|USERNAME|'.$username.'|g" remove_user_confirm.html');
        }

        $output_filename = "remove_user_confirm.html";
    }
}

if (isset($_POST['submitchangepassword'])) {
    if(filter_string('myuser')) {
        $username = htmlspecialchars($_POST['myuser']);

        $newpassword = rtrim(exec("diceware"));
        exec('cp password_confirm_template.html password_confirm.html');
        exec('sed -i "s|USERNAME|'.$username.'|g" password_confirm.html');
        exec('sed -i "s|NEWPASSWORD|'.$newpassword.'|g" password_confirm.html');

        $output_filename = "password_confirm.html";
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
