<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Receives the list of blocked domains/users
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

// blocked addresses or domains
if (isset($_POST['submitblocking'])) {
    if(filter_string('blockinglist', 99999)) {
        $blockinglist = htmlspecialchars($_POST['blockinglist']);

        $blocking_file = fopen(".blocklist.txt", "w") or die("Unable to create blocklist file");
        fwrite($blocking_file, $blockinglist);
        fclose($blocking_file);
    }
}

// muted words
if (isset($_POST['submitblockingwordscontinue'])) {
    if(filter_string('blockinglistwords', 99999)) {
        $blockinglistwords = htmlspecialchars($_POST['blockinglistwords']);

        $blocking_words_file = fopen(".blocklistwords.txt", "w") or die("Unable to create blocklistwords file");
        fwrite($blocking_words_file, $blockinglistwords);
        fclose($blocking_words_file);
    }
}

if (isset($_POST['submitblockingwords'])) {
    $output_filename = "blocking_words.html";
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
