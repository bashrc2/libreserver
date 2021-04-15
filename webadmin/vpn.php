<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Receives the list of Wireguard public keys
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

$output_filename = "settings.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

// VPN public keys list
if (isset($_POST['submitvpn'])) {
    if(filter_string('remotevpndomain')) {
        $remotevpndomain = trim(htmlspecialchars($_POST['remotevpndomain']));
        if(filter_string('remotevpnpublickey')) {
            $remotevpnpublickey = trim(htmlspecialchars($_POST['remotevpnpublickey']));
            if(filter_string('vpnlist',4096)) {
                $vpnlist = htmlspecialchars($_POST['vpnlist']);

                $vpn_remote_file = fopen(".vpn_remote.txt", "w") or die("Unable to create remote vpn file");
                fwrite($vpn_remote_file, $remotevpndomain.",".$remotevpnpublickey);
                fclose($vpn_remote_file);

                $vpn_file = fopen(".vpn.txt", "w") or die("Unable to create vpn file");
                fwrite($vpn_file, $vpnlist);
                fclose($vpn_file);
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
