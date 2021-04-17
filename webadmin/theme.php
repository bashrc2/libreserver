<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Change the theme
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

if (isset($_POST['submitthemelight'])) {
    $theme_file = fopen(".theme.txt", "w") or die("Unable to write to theme file");
    // light theme
    $screen_background = '#dddddd';
    $foreground_text = '#777';
    $border_around_app_categories = '#aaa';
    $background_of_search_box = '#5499ca';
    $text_of_search_box = '#fdfdfd';
    $links = '#555';
    $visited_links = '#222';
    $text_entry_foreground = 'black';
    $text_entry_background = 'lightblue';
    $icons_red = '113';
    $icons_green = '167';
    $icons_blue = '207';
    fwrite($theme_file, $screen_background.','.$foreground_text.','.$border_around_app_categories.','.$background_of_search_box.','.$text_of_search_box.','.$links.','.$visited_links.','.$text_entry_foreground.','.$text_entry_background.','.$icons_red.','.$icons_green.','.$icons_blue);
    fclose($theme_file);

    $output_filename = "theme_waiting.html";
    exec('cp theme_wait.html '.$output_filename);
    remainOnScreen($output_filename);
}

if (isset($_POST['submitthemedark'])) {
    $theme_file = fopen(".theme.txt", "w") or die("Unable to write to theme file");
    // dark theme
    $screen_background = '#222';
    $foreground_text = '#bbb';
    $border_around_app_categories = '#777';
    $background_of_search_box = '#f9f3f3';
    $text_of_search_box = '#144163';
    $links = '#ccc';
    $visited_links = '#eee';
    $text_entry_foreground = 'black';
    $text_entry_background = 'lightblue';
    $icons_red = '113';
    $icons_green = '167';
    $icons_blue = '207';
    fwrite($theme_file, $screen_background.','.$foreground_text.','.$border_around_app_categories.','.$background_of_search_box.','.$text_of_search_box.','.$links.','.$visited_links.','.$text_entry_foreground.','.$text_entry_background.','.$icons_red.','.$icons_green.','.$icons_blue);
    fclose($theme_file);

    $output_filename = "theme_waiting.html";
    exec('cp theme_wait.html '.$output_filename);
    remainOnScreen($output_filename);
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
