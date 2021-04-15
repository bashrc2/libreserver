<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Proxy outgoing email through another server
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

if (isset($_POST['submitemailhelp'])) {
    $output_filename = "help_email.html";
}

if (isset($_POST['submitDMARC'])) {
    header('Content-Type: text/plain');
    $output_filename = "dmarc.txt";
}

if (isset($_POST['submitemailproxyclear'])) {
    $isp_smtp_domain = '';
    $isp_smtp_port = '';
    $isp_smtp_username = '';
    $isp_smtp_password = '';

    $email_proxy_file = fopen(".emailproxy.txt", "w") or die("Unable to write to emailproxy file");
    fwrite($email_proxy_file, $isp_smtp_domain.",".$isp_smtp_port.",".$isp_smtp_username.",".$isp_smtp_password);
    fclose($email_proxy_file);

    exec('cp email_proxy_template.html email_proxy.html');
    exec('sed -i "s|EMAIL_PROXY_DOMAIN||g" email_proxy.html');
    exec('sed -i "s|EMAIL_PROXY_PORT||g" email_proxy.html');
    exec('sed -i "s|EMAIL_PROXY_USERNAME||g" email_proxy.html');
}

if (isset($_POST['submitemailproxy'])) {
    if(filter_string('isp_smtp_domain')) {
        $isp_smtp_domain = htmlspecialchars($_POST['isp_smtp_domain']);
        if(filter_string('isp_smtp_port')) {
            $isp_smtp_port = htmlspecialchars($_POST['isp_smtp_port']);
            if(filter_string('isp_smtp_username')) {
                $isp_smtp_username = htmlspecialchars($_POST['isp_smtp_username']);
                if(filter_string('isp_smtp_password')) {
                    $isp_smtp_password = htmlspecialchars($_POST['isp_smtp_password']);

                    $email_proxy_file = fopen(".emailproxy.txt", "w") or die("Unable to write to emailproxy file");
                    fwrite($email_proxy_file, $isp_smtp_domain.",".$isp_smtp_port.",".$isp_smtp_username.",".$isp_smtp_password);
                    fclose($email_proxy_file);

                    exec('cp email_proxy_template.html email_proxy.html');
                    exec('sed -i "s|EMAIL_PROXY_DOMAIN|'.$isp_smtp_domain.'|g" email_proxy.html');
                    exec('sed -i "s|EMAIL_PROXY_PORT|'.$isp_smtp_port.'|g" email_proxy.html');
                    exec('sed -i "s|EMAIL_PROXY_USERNAME|'.$isp_smtp_username.'|g" email_proxy.html');
                }
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);
?>
