<?php

//  _    _ _            ___                      
// | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
// | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
// |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
//
// Update Guifinet settings
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

if (isset($_POST['submitnetworkmap'])) {
    if(filter_string('network')) {
        $network = trim(htmlspecialchars($_POST['network']));
        $zone_number = trim(htmlspecialchars($_POST['zone_number']));
        $zone_accepted = true;
        if($zone_number != '') {
            if (!is_numeric($zone_number)) {
                $zone_accepted = false;
            }
        }

        if ($zone_accepted) {
            if(filter_string('longitude',32)) {
                $longitude = trim(htmlspecialchars($_POST['longitude']));
                if (is_numeric($longitude)) {
                    if(filter_string('latitude',32)) {
                        $latitude = trim(htmlspecialchars($_POST['latitude']));
                        if (is_numeric($latitude)) {
                            $network_coords_file = fopen(".network_coords.txt", "w") or die("Unable to create network coords file");
                            fwrite($network_coords_file, $longitude.";".$latitude.";;".$zone_number.";".$domain);
                            fclose($network_coords_file);

                            // change the values so that there isn't a big lag in their update
                            exec('cp settings_guifinet'.$network.'_template.html settings_guifinet'.$network.'.html');
                            exec("sed -i 's|YOURLONGITUDE|".$longitude."|g' settings_guifinet".$network.".html");
                            exec("sed -i 's|YOURLATITUDE|".$latitude."|g' settings_guifinet".$network.".html");
                            if($zone_number != '') {
                                exec("sed -i 's|YOURZONE|".$zone_number."|g' settings_guifinet".$network.".html");
                            }

                            $output_filename = "settings_guifinet".$network.".html";
                            remainOnScreen($output_filename);
                        }
                    }
                }
            }
        }
    }
}

if (isset($_POST['submitzoomin'])) {
    if(filter_string('network')) {
        $network = trim(htmlspecialchars($_POST['network']));
        $zone_number = trim(htmlspecialchars($_POST['zone_number']));
        $zone_accepted = true;
        if($zone_number != '') {
            if (!is_numeric($zone_number)) {
                $zone_accepted = false;
            }
        }

        if ($zone_accepted) {
            if(filter_string('longitude',32)) {
                $longitude = trim(htmlspecialchars($_POST['longitude']));
                if (is_numeric($longitude)) {
                    if(filter_string('latitude',32)) {
                        $latitude = trim(htmlspecialchars($_POST['latitude']));
                        if (is_numeric($latitude)) {
                            $network_coords_file = fopen(".network_coords.txt", "w") or die("Unable to create network coords file");
                            fwrite($network_coords_file, $longitude.";".$latitude.";+;".$zone_number.";".$domain);
                            fclose($network_coords_file);

                            // change the values so that there isn't a big lag in their update
                            exec('cp settings_guifinet'.$network.'_template.html settings_guifinet'.$network.'.html');
                            exec("sed -i 's|YOURLONGITUDE|".$longitude."|g' settings_guifinet".$network.".html");
                            exec("sed -i 's|YOURLATITUDE|".$latitude."|g' settings_guifinet".$network.".html");
                            if($zone_number != '') {
                                exec("sed -i 's|YOURZONE|".$zone_number."|g' settings_guifinet".$network.".html");
                            }

                            $output_filename = "settings_guifinet".$network.".html";
                            remainOnScreen($output_filename);
                        }
                    }
                }
            }
        }
    }
}

if (isset($_POST['submitzoomout'])) {
    if(filter_string('network')) {
        $network = trim(htmlspecialchars($_POST['network']));
        $zone_number = trim(htmlspecialchars($_POST['zone_number']));
        $zone_accepted = true;
        if($zone_number != '') {
            if (!is_numeric($zone_number)) {
                $zone_accepted = false;
            }
        }

        if ($zone_accepted) {
            if(filter_string('longitude',32)) {
                $longitude = trim(htmlspecialchars($_POST['longitude']));
                if (is_numeric($longitude)) {
                    if(filter_string('latitude',32)) {
                        $latitude = trim(htmlspecialchars($_POST['latitude']));
                        if (is_numeric($latitude)) {
                            $network_coords_file = fopen(".network_coords.txt", "w") or die("Unable to create network coords file");
                            fwrite($network_coords_file, $longitude.";".$latitude.";-;".$zone_number.";".$domain);
                            fclose($network_coords_file);

                            // change the values so that there isn't a big lag in their update
                            exec('cp settings_guifinet'.$network.'_template.html settings_guifinet'.$network.'.html');
                            exec("sed -i 's|YOURLONGITUDE|".$longitude."|g' settings_guifinet".$network.".html");
                            exec("sed -i 's|YOURLATITUDE|".$latitude."|g' settings_guifinet".$network.".html");
                            if($zone_number != '') {
                                exec("sed -i 's|YOURZONE|".$zone_number."|g' settings_guifinet".$network.".html");
                            }

                            $output_filename = "settings_guifinet".$network.".html";
                            remainOnScreen($output_filename);
                        }
                    }
                }
            }
        }
    }
}

$htmlfile = fopen("$output_filename", "r") or die("Unable to open $output_filename");
echo fread($htmlfile,filesize("$output_filename"));
fclose($htmlfile);

?>
