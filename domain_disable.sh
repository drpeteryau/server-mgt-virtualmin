#!/bin/bash
# Author: Peter Yau
# E-mail: drpeteryau@gmail.com
# Description: disable virtualmin doamin from csv file
# ------------------------------------------
INPUT=$1
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read domain
do
	virtualmin disable-domain --domain $domain
done < $INPUT
IFS=$OLDIFS
