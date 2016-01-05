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

# Check if a backup has been performed
if [ "$(ls $main/backup/jolla)" -o "$(ls $main/backup/native)" -o "$(ls $main/backup/apk)" -o "$(ls $main/backup/dyncal)" -o "$(ls $main/backup/dynclock)" ]; then

# List backuped Jolla icons
ls $main/backup/jolla > $main/tmp/bk_jolla
# List Jolla icons
ls $dir_jolla > $main/tmp/sys_jolla
#Check if there are common icons
comm -1 -2 $main/tmp/bk_jolla $main/tmp/sys_jolla > $main/tmp/cp_jolla
if [ -s "$main/tmp/cp_jolla" ]; then
	# Restore Jolla icons
	for file in $(<$main/tmp/cp_jolla); do cp "$main/backup/jolla/$file" $dir_jolla; done
fi

# List backuped native icons
ls $main/backup/native > $main/tmp/bk_native
# List native icons
ls $dir_native > $main/tmp/sys_native
#Check if there are common icons
comm -1 -2 $main/tmp/bk_native $main/tmp/sys_native > $main/tmp/cp_native
if [ -s "$main/tmp/cp_native" ]; then
	# Restore native icons
	for file in $(<$main/tmp/cp_native); do cp "$main/backup/native/$file" $dir_native; done
fi

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# List backuped Android icons
	ls $main/backup/apk > $main/tmp/bk_apk
	# List Android icons
	ls $dir_apk > $main/tmp/sys_apk
	#Check if there are common icons
	comm -1 -2 $main/tmp/bk_apk $main/tmp/sys_apk > $main/tmp/cp_apk
	if [ -s "$main/tmp/cp_apk" ]; then
		# Restore Android icons
		for file in $(<$main/tmp/cp_apk); do cp "$main/backup/apk/$file" $dir_apk; done
	fi
fi

# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	if [ "$(ls $main/backup/dyncal)" ]; then
		cp $main/backup/dyncal/*.* /usr/share/harbour-dyncal/icons/
	fi
fi

# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	if [ "$(ls $main/backup/dynclock)" ]; then
		cp $main/backup/dynclock/*.* /usr/share/harbour-dynclock/
	fi
fi

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

# Clean tmp directory
rm $main/tmp/*

# Set no icon pack
rm $main/icon-current
echo default > $main/icon-current

fi

exit 0