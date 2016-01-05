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

# Usage ./run.sh [fontpackname]

# Set font pack name variable
fontpack=$1
# Is the variable empty?
if [ -z "$fontpack" ]; then
	exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport
pack=/usr/share/harbour-themepack-$fontpack
dir_jolla=/usr/share/fonts
dir_apk=/opt/alien/system/fonts

# Check if a backup has been performed
if [ "$(ls $main/backup/font)" -o "$(ls $main/backup/font-droid)" ]; then

# Check if there are Jolla fonts
if [ -d "$pack/font" ]; then
	# List fonts
	ls $dir_jolla > $main/tmp/font
	cd $pack/font; ls *.ttf > $main/font
	# Keep Sailfish emojis if installed
	sed -i "/custom/d" $main/tmp/font
	sed -i "/droid/d" $main/tmp/font
	# Delete the other fonts
	for file in $(<$main/tmp/font); do rm -rf "$dir_jolla/$file"; done
	# Copy selected Jolla font pack
	cp $pack/font/*.ttf $dir_jolla/
fi

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# Check if there are Android fonts
	if [ -d "$pack/font-droid" ]; then
		# List fonts
		ls $dir_apk > $main/tmp/font-droid
		cd $pack/font-droid; ls *.ttf > $main/font-droid
		# Keep Android emojis
		sed -i "/AndroidEmoji.ttf/d" $main/tmp/font-droid
		# Delete the other fonts
		for file in $(<$main/tmp/font-droid); do rm -rf "$dir_apk/$file"; done
		# Copy selected Jolla font pack
		cp $pack/font-droid/*.ttf $dir_apk/
	fi
fi

# Clean tmp directory
if [ "$(ls $main/tmp)" ]; then
	rm $main/tmp/*
fi

# Save current font pack
rm $main/font-current
echo $fontpack > $main/font-current

# Warm about backup not performed
else
echo "Run backup first!"
fi
exit 0