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

# Set directory variables
main=/usr/share/harbour-themepacksupport
dir_jolla=/usr/share/fonts
dir_apk=/opt/alien/system/fonts

# Check if a backup has been performed
if [ "$(ls $main/backup/font)" -o "$(ls $main/backup/font-droid)" ]; then

# Delete custom fonts
for file in $(<$main/font); do rm -rf "$dir_jolla/$file"; done
for file in $(<$main/font-droid); do rm rm -rf "$dir_apk/$file"; done
rm $main/font
rm $main/font-droid

# Restore Jolla fonts
cp -R $main/backup/font/sail-sans-pro $dir_jolla/
fc-cache -fv
cp -R $main/backup/font/* $dir_jolla/

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# Restore Android fonts
	cp -R $main/backup/font-droid/* $dir_apk/
fi

# Remove backuped Jolla fonts
if [ "$(ls $main/backup/font)" ]; then
	rm -rf $main/backup/font/*
fi

# Remove backuped Android fonts
if [ "$(ls $main/backup/font-droid)" ]; then
	rm -rf $main/backup/font-droid/*
fi
# Set no font pack
rm $main/font-current
echo default > $main/font-current

fi

exit 0