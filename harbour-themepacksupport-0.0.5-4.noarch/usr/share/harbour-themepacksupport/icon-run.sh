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

# Usage ./run.sh [iconpackname]

# Set icon pack name variable
iconpack=$1
# Is the variable empty?
if [ -z "$iconpack" ]; then
    exit 1
fi

# Set directory variables
main=/usr/share/harbour-themepacksupport
pack=/usr/share/harbour-themepack-$iconpack
dir_jolla=/usr/share/themes/jolla-ambient/meegotouch/z1.0/icons
dir_native=/usr/share/icons/hicolor/86x86/apps
dir_apk=/var/lib/apkd

# Check if a backup has been performed
if [ "$(ls $main/backup/jolla)" -o "$(ls $main/backup/native)" -o "$(ls $main/backup/apk)" -o "$(ls $main/backup/dyncal)" -o "$(ls $main/backup/dynclock)" ]; then

# Check if there are Jolla icons
if [ -d "$pack/jolla" ]; then
	if [ "$(ls $pack/jolla)" ]; then
		# List icon pack icons
		ls $pack/jolla > $main/tmp/pack_jolla
		# List Jolla icons
		ls $dir_jolla > $main/tmp/sys_jolla
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_jolla $main/tmp/sys_jolla > $main/tmp/cp_jolla
		if [ -s "$main/tmp/cp_jolla" ]; then
			# Copy selected Jolla icon pack
			for file in $(<$main/tmp/cp_jolla); do cp "$pack/jolla/$file" $dir_jolla; done
		fi
	fi
fi

# Check if there are native icons
if [ -d "$pack/native" ]; then
	if [ "$(ls $pack/native)" ]; then
		# List icon pack icons
		ls $pack/native > $main/tmp/pack_native
		# List native icons
		ls $dir_native > $main/tmp/sys_native
		#Check if there are common icons
		comm -1 -2 $main/tmp/pack_native $main/tmp/sys_native > $main/tmp/cp_native
		if [ -s "$main/tmp/cp_native" ]; then
			# Copy selected native icon pack
			for file in $(<$main/tmp/cp_native); do cp "$pack/native/$file" $dir_native; done
		fi
	fi
fi

# If Android support is installed
if [ -d "$dir_apk" ]; then
	# Check if there are Android icons
	if [ -d "$pack/apk" ]; then
		if [ "$(ls $pack/apk)" ]; then
			# List icon pack icons
			ls $pack/apk > $main/tmp/pack_apk
			# List Android icons
			ls $dir_apk > $main/tmp/sys_apk
			#Check if there are common icons
			comm -1 -2 $main/tmp/pack_apk $main/tmp/sys_apk > $main/tmp/cp_apk
			if [ -s "$main/tmp/cp_apk" ]; then
				# Copy selected Android icon pack
				for file in $(<$main/tmp/cp_apk); do cp "$pack/apk/$file" $dir_apk; done
			fi
		fi
	fi
fi

# If DynCal is installed
if [ -d "/usr/share/harbour-dyncal" ]; then
	# Check if there are DynCal icons
	if [ -d "$pack/dyncal" ]; then
		if [ "$(ls $pack/dyncal)" ]; then
			cp $pack/dyncal/*.* /usr/share/harbour-dyncal/icons/
		fi
	fi
fi

# If DynClock is installed
if [ -d "/usr/share/harbour-dynclock" ]; then
	# Check if there are DynClock icons
	if [ -d "$pack/dynclock" ]; then
		if [ "$(ls $pack/dynclock)" ]; then
			cp $pack/dynclock/*.* /usr/share/harbour-dynclock/
		fi
	fi
fi

# Clean tmp directory
if [ "$(ls $main/tmp)" ]; then
	rm $main/tmp/*
fi

# Save current icon pack
rm $main/icon-current
echo $iconpack > $main/icon-current

# Warm about backup not performed
else
echo "Run backup first!"

fi

exit 0