#!/usr/bin/env python3
#  _    _ _            ___                      
# | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
# | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
# |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
#
# Shows missing packages
#
# License
# =======
#
# Copyright (C) 2014-2021 Bob Mottram <bob@libreserver.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import os
import sys

if __name__=="__main__":
    packages_filename = '/tmp/check_packages.txt'
    os.system("libreserver-packages > " + packages_filename)
    if not os.path.isfile(packages_filename):
        print('No packages found within the current directory')
        sys.exit()

    current_debian_version = 'bullseye (testing)'

    filename = '/tmp/debian.txt'
    with open(packages_filename, "r") as f:
        lines = f.readlines()
        for package in lines:
            package = package.strip()
            cmdStr = "wget -q \"https://packages.debian.org/search?suite=default&section=all&arch=any&searchon=names&keywords=" + package + '\" -O ' + filename
            os.system(cmdStr)
            if os.path.isfile(filename):
                with open(filename, "r") as f2:
                    site = f2.read()
                    if current_debian_version not in site:
                        print(package)
                os.remove(filename)
                
