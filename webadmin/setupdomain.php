<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// For clearnet setup this receives the preferred domain name
// and then begins the install by creating the setup.txt file
// which is detected by the webadmin daemon (libreserver-installer)
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

if (isset($_POST['setupdomain'])) {
    if(filter_string('default_domain_name')) {
        $install_domain = htmlspecialchars($_POST['default_domain_name']);

        if (preg_match('/^[a-z\d_\.\-]{4,128}$/i', $install_domain)) {
            $domain_file = fopen(".temp_domain.txt", "w") or die("Unable to write to domain file");
            fwrite($domain_file, $install_domain);
            fclose($domain_file);
            $output_filename = "setup_port_forward.html";
        }
    }
}

if (isset($_POST['setupdomainhelp'])) {
    $output_filename = "setup_domain_help.html";
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
