<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Enable or disable ssh
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

$output_filename = "settings.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['submitssh'])) {
    if(filter_string('sshconfirm')) {
        $confirm = htmlspecialchars($_POST['sshconfirm']);

        $ssh_file = fopen(".ssh.txt", "w") or die("Unable to create ssh file");
        fwrite($ssh_file, '0,');
        fclose($ssh_file);
        $output_filename = "ssh_disabled.html";

        $publickey = htmlspecialchars($_POST['publickey']);

        if(strlen($publickey) < 32000) {
            if(($confirm == "1") || (strlen($publickey) > 10)) {

                if (substr($publickey, 0, 4) === "ssh-") {
                    $ssh_file = fopen(".ssh.txt", "w") or die("Unable to create ssh file");
                    fwrite($ssh_file, '1,'.$publickey);
                    fclose($ssh_file);

                    $host=gethostname();
                    if (endsWith($host,'.onion')) {
                        exec('sed -i "s|HOSTNAME|libreserver.local|g" ssh_enabled.html');
                    }
                    else {
                        exec('sed -i "s|HOSTNAME|'.$host.'|g" ssh_enabled.html');
                    }

                    if(file_exists("onion_domain_ssh.txt")) {
                        $onion_file = fopen("onion_domain_ssh.txt", "r") or die("Unable to read onion ssh file");
                        $onion_domain = fread($onion_file, filesize("onion_domain_ssh.txt"));
                        fclose($onion_file);
                        exec('sed -i "s|ONION_DOMAIN|'.$onion_domain.'|g" ssh_enabled.html');
                    }

                    $output_filename = "ssh_enabled.html";
                }
                else {
                    $output_filename = "ssh_no_public_key.html";
                }
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
