<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Change language
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

if (isset($_POST['submitlanguage'])) {
    if(filter_string('language')) {
        $language = htmlspecialchars($_POST['language']);

        $language_file = fopen(".language.txt", "w") or die("Unable to create language file");
        fwrite($language_file, $language);
        fclose($language_file);

        $output_filename = "language_waiting.html";
        exec('cp language_wait.html '.$output_filename);
        remainOnScreen($output_filename);
    }
}

if (isset($_POST['submitlanguagewaitcancel'])) {
    $output_filename = "settings.html";
    remainOnScreen($output_filename);
}

if (isset($_POST['submittranslatelanguage'])) {
    if(filter_string('language')) {
        $language = htmlspecialchars($_POST['language']);

        // whether to keep local translations or not
        if (file_exists('.keep_translations.txt')) {
            exec('sed -i "s|submitkeeptranslations\" value=\"0\"|submitkeeptranslations\" value=\"1\" checked|g" translations_template.html');
            if (file_exists('translations.html')) {
                exec('sed -i "s|submitkeeptranslations\" value=\"0\"|submitkeeptranslations\" value=\"1\" checked|g" translations.html');
            }
        }
        else {
            exec('sed -i "s|value=\"1\" checked|value=\"0\"|g" translations_template.html');
            if (file_exists('translations.html')) {
                exec('sed -i "s|value=\"1\" checked|value=\"0\"|g" translations.html');
            }
        }

        // create translations directory
        if (!file_exists("translations")) {
            mkdir("translations");
        }

        // file where translations will be stored
        $translations_file = "translations/".$language.'.txt';

        if (!file_exists($translations_file)) {
            // create the translations file
            exec("grep -h 'translate=".'"'.'yes"'."' EN/*.html | grep ' type=".'"'."submit".'"'."' | grep ' value=".'"'."' | awk -F ' value=".'"'."' '{print ".'$'."2}' | awk -F '".'"'."' '{print ".'$'."1}' > ".$translations_file.".buttons");

            exec("grep -h 'translate=".'"'.'yes"'."' EN/*.html | sed -e 's/<[^>]*>//g' | sed -e 's/^[[:space:]]*//' | sed 's/^[0-9]\+. //' | sed '/^$/d' > ".$translations_file.".text");

            if (file_exists('app_descriptions.txt')) {
                exec("cat app_descriptions.txt ".$translations_file.".buttons ".$translations_file.".text | sort -uf | sed 's/$/|/' > ".$translations_file);
            }
            else {
                exec("cat ".$translations_file.".buttons ".$translations_file.".text | sort -uf | sed 's/$/|/' > ".$translations_file);
            }

            exec('rm '.$translations_file.'.buttons');
            exec('rm '.$translations_file.'.text');
        }

        // perform any merges, if a file cammed [language].merge.txt exists
        // in the translations directory
        if (file_exists('translations/'.$language.'.merge.txt')) {
            exec('cat '.$translations_file." | sed 's/|//g' > ".$translations_file.'.temp3');
            if (file_exists($translations_file.'.temp3')) {
                exec('paste -d "|" '.$translations_file.'.temp3 translations/'.$language.'.merge.txt > '.$translations_file.'.temp4');
                exec('rm '.$translations_file.'.temp3');
                if (file_exists($translations_file.'.temp4')) {
                    exec('mv '.$translations_file.'.temp4 '.$translations_file);
                    exec('rm translations/'.$language.'.merge.txt');
                }
            }
        }

        if (file_exists(".translations.txt")) {
            exec('rm .translations.txt');
        }

        exec("cat ".$translations_file.' | sed '."'".'s@|@" readonly></td><td><input class="translationstring" type="text" translate="no" name="translated[]" value="@'."' > .translations1.txt");

        exec("cat .translations1.txt | sed -e 's@^@<tr><td><input class=".'"translationstring" type="text" translate="no" name="english[]" value="@'."' > .translations2.txt");

        exec("cat .translations2.txt | sed 's@".'$'.'@" /></td></tr>@'."' > .translations.txt");
        exec('rm .translations1.txt .translations2.txt');

        if (file_exists(".translations.txt")) {
            exec('cp translations_template.html translations.html');

            exec("awk '1;/table class=/{exit}' translations_template.html > translations.html");
            exec('cat .translations.txt >> translations.html');
            exec("sed -n -e '/\/table/,".'$'."p' translations_template.html >> translations.html");

            exec('sed -i "s|TRANSLATELANGUAGE|'.$language.'|g" translations.html');
            exec('rm .translations.txt');

            $output_filename = "translations.html";
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
