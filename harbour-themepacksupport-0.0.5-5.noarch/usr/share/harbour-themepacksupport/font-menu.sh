#!/bin/bash
#
#    Theme pack support for Sailfish OS - Enables theme pack support in Sailfish OS.
#    Copyright (C) 2015  fravaccaro fravaccaro90@gmail.com
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Make sure only root can run the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root. Please gain root privileges and try again." 1>&2
   exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport

while :
do
    clear
    cat<<EOF
 Theme pack support for Sailfish OS
 =================================

 Please enter your choice:
 ---------------------------------
   (A)pply font theme
   (S)ize
   (R)estore
   (B)ack
 ---------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "A"|"a")  cat $main/font.menu
		echo " "
		read -p "Please enter the font pack name or 'q' to exit and press enter: " choice
		case "$choice" in 
		q|Q ) echo "ok"; sleep 1;;
		* ) # Check if a backup has been performed
		if [ "$(ls $main/backup/font)" -o "$(ls $main/backup/font-droid)" ]; then
		$main/font-restore.sh
		$main/font-backup.sh
		$main/font-run.sh $choice
		else
		$main/font-backup.sh
		$main/font-run.sh $choice
		fi
		echo "done!"; sleep 1 ;;
		esac ;;
    "S"|"s")  read -p "Please enter font size multiplier or 'q' to exit and press enter. Default value is 1.0. Suggested size is 1.1 or 1.2: " f1
		case "$f1" in 
		[0-3]* ) su - nemo -c "dconf write /desktop/jolla/theme/font/sizeMultiplier $f1"
		echo "done!"; sleep 1 ;;
		q|Q ) echo "quit"; sleep 1 ;;
		esac
		read -p "Please enter font size threshold (max font size) or 'q' to exit and press enter. Default value is 0. Suggested size is 60: " f2
		case "$f2" in 
		[0-3]* ) su - nemo -c "dconf write /desktop/jolla/theme/font/sizeThreshold $f2"
		echo "done!"; sleep 1 ;;
		q|Q ) echo "quit"; sleep 1 ;;
		esac ;;
    "R"|"r")  echo "This will restore your default font pack. Continue y/N? "
		read -n1 -s choice
		case "$choice" in 
		y|Y ) $main/font-restore.sh
		echo "done!"; sleep 1 ;;
		* ) echo "aborted"; sleep 1 ;;
		esac ;;
     "B"|"b")  exit                      ;;
     * )  echo "invalid option"; sleep 1     ;;
    esac
    sleep 1
done