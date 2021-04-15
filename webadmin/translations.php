<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Update translations for a language
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

$output_filename = "language.html";

if (php_sapi_name()!=='fpm-fcgi') exit('php script must be run from the web interface');

if (!isset($_POST['submitkeeptranslations'])) {
    if (file_exists('.keep_translations.txt')) {
        exec('rm .keep_translations.txt');
    }
}
else {
    if (!file_exists('.keep_translations.txt')) {
        $keep_file = fopen(".keep_translations.txt", "w") or die("Unable to create keep_translations file");
        fwrite($keep_file, "1");
        fclose($keep_file);
    }
}

if (isset($_POST['submittranslationsupstream'])) {
    if(filter_string('language')) {
        $language = htmlspecialchars($_POST['language']);
        $language_file = "translations/".$language.'.txt';

        if (file_exists($language_file)) {
            exec('echo ">>> LibreServer Translations <<<" > submit_translations.txt');
            exec('echo "" >> submit_translations.txt');
            exec('echo "Copy and paste this into an email and send it to bob@libreserver.org" >> submit_translations.txt');
            exec('echo "with a suitable subject line such as \"LibreServer translations\"" >> submit_translations.txt');
            exec('echo "" >> submit_translations.txt');
            exec('echo "Language: "'.$language.' >> submit_translations.txt');
            exec('echo "" >> submit_translations.txt');
            exec('cat '.$language_file.' >> submit_translations.txt');
            $output_filename = "submit_translations.txt";
        }
        else {
            $output_filename = "translations.html";
        }
    }
}

if (isset($_POST['submittranslationsimport'])) {
    if(filter_string('language')) {
        $language = htmlspecialchars($_POST['language']);
        exec('cp translations_import_template.html translations_import.html');
        exec('sed -i "s|TRANSLATELANGUAGE|'.$language.'|g" translations_import.html');
        $output_filename = "translations_import.html";
    }
}

if (isset($_POST['submittranslationshelp'])) {
    $output_filename = "help_translations.html";
}

if (isset($_POST['submittranslations'])) {
    if(filter_string('language')) {
        $language = htmlspecialchars($_POST['language']);
        $english = $_POST['english'];
        $translated = $_POST['translated'];

        $language_file = fopen("translations/".$language.'.txt', "w") or die("Unable to create language file to translations directory");
        foreach( $english as $index => $eng ) {
            fwrite($language_file, htmlspecialchars($eng) . '|' . htmlspecialchars($translated[$index])."\n");
        }

        fclose($language_file);

        $keep_file = fopen(".keep_translations.txt", "w") or die("Unable to create keep_translations file");
        fwrite($keep_file, "1");
        fclose($keep_file);

        $language_file = fopen(".translations.txt", "w") or die("Unable to create translations file");
        fwrite($language_file, $language);
        fclose($language_file);
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
if (endsWith($output_filename,'html')) {
    echo fread($htmlfile,filesize("$output_filename"));
}
else {
    echo nl2br(fread($htmlfile,filesize("$output_filename")));
}
fclose($htmlfile);

?>
