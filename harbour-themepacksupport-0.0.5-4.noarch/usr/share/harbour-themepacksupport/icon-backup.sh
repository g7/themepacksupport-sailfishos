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
dir_jolla=/usr/share/themes/jolla-ambient/meegotouch/z1.0/icons
dir_native=/usr/share/icons/hicolor/86x86/apps
dir_apk=/var/lib/apkd

# Remove backuped Jolla icons
if [ "$(ls $main/backup/jolla)" ]; then
	rm $main/backup/jolla/*
fi
# Remove backuped native icons
	if [ "$(ls $main/backup/native)" ]; then
rm $main/backup/native/*
fi
# If Android support is installed
if [ -d "$dir_apk" ]; then
	# Remove backuped Android icons
	if [ "$(ls $main/backup/apk)" ]; then
		rm $main/backup/apk/*
	fi
fi
# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	# Remove backuped DynCal icons
	if [ "$(ls $main/backup/dyncal)" ]; then
		rm $main/backup/dyncal/*
	fi
fi
# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	# Remove backuped DynClock icons
	if [ "$(ls $main/backup/dynclock)" ]; then
		rm $main/backup/dynclock/*
	fi
fi

# List Jolla icons
ls $dir_jolla > $main/tmp/jolla
# Copy selected Jolla icons
for file in $(<$main/tmp/jolla); do cp "$dir_jolla/$file" $main/backup/jolla/; done

# List native icons
ls $dir_native > $main/tmp/native
# Copy selected native icons
for file in $(<$main/tmp/native); do cp "$dir_native/$file" $main/backup/native/; done

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# List Android icons
	ls $dir_apk > $main/tmp/apk
	# Copy selected Android icons
	for file in $(<$main/tmp/apk); do cp "$dir_apk/$file" $main/backup/apk/; done
fi

# If DynCal is installed 
if [ -d "/usr/share/harbour-dyncal" ]; then
	cp /usr/share/harbour-dyncal/icons/*.* $main/backup/dyncal/
fi

# If DynClock is installed 
if [ -d "/usr/share/harbour-dynclock" ]; then
	cp /usr/share/harbour-dynclock/*.png $main/backup/dynclock/
fi

# Clean tmp directory
rm $main/tmp/*

exit 0