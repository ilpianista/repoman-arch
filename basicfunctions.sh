#!/bin/bash
#
# Repoman's basic functions
# Based on Yaourt/basicfunctions.sh by Julien MISCHKOWITZ (wain@archlinux.fr)
#
# Copyright (C) 2009 Andrea Scarpino <bash.lnx@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

isnumeric(){
	if let $1 2>/dev/null; then return 0; else return 1; fi
}

is_x_gt_y(){
	local version=( $(echo $1 | tr "[:punct:]" "\ " | sed 's/[a-zA-Z]/ &/g') )
	local lversion=( $(echo $2 | tr "[:punct:]" "\ " | sed 's/[a-zA-Z]/ &/g') )
	if [ ${#version[@]} -gt ${#lversion[@]} ]; then 
		versionlength=${#version[@]}
	else
		versionlength=${#lversion[@]}
	fi
	
	for i_index in `seq 0 $((${versionlength}-1))`; do 
		if `isnumeric ${version[$i_index]}` && `isnumeric ${lversion[$i_index]}`;  then
			if [ ${version[$i_index]} -eq ${lversion[$i_index]} ]; then continue; fi
			if [ ${version[$i_index]} -gt ${lversion[$i_index]} ]; then return 0; else return 1; fi
			break
		elif [ `isnumeric ${version[$i_index]}` -ne  `isnumeric ${lversion[$i_index]}` ]; then
			if [ "${version[$i_index]}" = "${lversion[$i_index]}" ]; then continue;fi
			if [ "${version[$i_index]}" \> "${lversion[$i_index]}" ]; then return 0; else return 1; fi
			break
		fi
	done
	return 1
}

get_community_category(){
	id=`wget -q -O - "http://aur.archlinux.org/rpc.php?type=info&arg=$1" \
		| sed -e 's/^.*{"ID":"//' -e 's/",".*$//' | sed '/^$/d'`
	category=`wget -q -O - "http://aur.archlinux.org/packages.php?ID=$id" \
		| grep 'community ::' | sed 's|<[^<]*>||g' | awk '{print $3}'`
}

check_files(){
	if [ ! -d "${workspace}/pkgs" ]; then
		mkdir -p "${workspace}/pkgs" || exit 1
	fi

	if [ "$NOCHANGELOG" != "TRUE" -a ! -f "${workspace}/$changelog" ]; then
		touch "${workspace}/$changelog"
	fi
}

if [ -f ~/.repomanrc ]; then
	configfile="$HOME/.repoman.conf"
else
	configfile="/etc/repoman.conf"
fi

source $configfile
