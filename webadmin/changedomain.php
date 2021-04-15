<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Change the default clearnet domain
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

$output_filename = "dynamicdns.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (isset($_POST['changedomain'])) {
    if(filter_string('default_domain_name')) {
        $change_domain = htmlspecialchars($_POST['default_domain_name']);

        if (preg_match('/^[a-z\d_\.\-]{4,128}$/i', $change_domain)) {
            $domain_file = fopen(".default_domain_temp.txt", "w") or die("Unable to write to default_domain file");
            fwrite($domain_file, $change_domain);
            fclose($domain_file);

            exec('cp change_domain_confirm_template.html change_domain_confirm.html');
            exec('sed -i "s|NEW_DEFAULT_DOMAIN_NAME|'.$change_domain.'|g" change_domain_confirm.html');

            $output_filename = "change_domain_confirm.html";
        }
    }
}

if (isset($_POST['changedomainconfirmsubmit'])) {
    if(filter_string('changedomainconfirm')) {
        $confirm = htmlspecialchars($_POST['changedomainconfirm']);

        if($confirm == "1") {
            exec('mv .default_domain_temp.txt .default_domain.txt');
        }
        else {
            exec('rm .default_domain_temp.txt');
        }

        $output_filename = "index.html";
        remainOnScreen($output_filename);
    }
}

if (isset($_POST['changedomainfail'])) {

    remainOnScreen('');

    if(file_exists('index_domain_changing.html')) {
        exec('cp index_domain_changing.html index.html');
        exec('rm index_domain_changing.html');
    }
    $output_filename = "index.html";
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
