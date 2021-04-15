#  _    _ _            ___                      
# | |  (_) |__ _ _ ___/ __| ___ _ ___ _____ _ _ 
# | |__| | '_ \ '_/ -_)__ \/ -_) '_\ V / -_) '_|
# |____|_|_.__/_| \___|___/\___|_|  \_/\___|_|  
#                                               
# Dockerfile for Gitlab Runner. Save Electricity and Time by saving build time
#
# License
# =======
#
# Copyright (C) 2019 Liam Hurwitz <liam@contra-bit.com>
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
# Set the base image to debian

FROM debian:bullseye

# File Author / Maintainer
MAINTAINER Liam Hurwitz and Bob Mottram

################## BEGIN INSTALLATION ######################

# Update the repository sources list
RUN apt-get update && \
      apt-get -y install sudo

# TODO: How to sudo without tty or askpass
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
##
## Install Essental Build Tools
##
RUN apt-get install git build-essential dialog openssh-client -y

##
## Install LibreServer Tools
##
RUN git clone https://gitlab.com/bashrc2/libreserver.git
RUN git clone https://gitlab.com/bashrc2/libreserver-maker.git
RUN cd libreserver &&\
        git checkout bullseye &&\
        make install

##
## Install Packages for building images
##
RUN apt-get install btrfs-progs debootstrap kpartx parted qemu-user-static qemu-utils sshpass -y

# Export Terminfo so tput can be executed
RUN export TERMINFO=/usr/lib/terminfo

USER root
CMD /bin/bash
