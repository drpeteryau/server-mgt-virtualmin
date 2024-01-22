#!/bin/bash
# Purpose: Read Comma Separated CSV File
# Author: Vivek Gite under GPL v2.0+
# ------------------------------------------
INPUT=$1
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read sid un pw domain db
do
	virtualmin create-domain --domain $domain --pass $pw --unix --dir --webmin --web --dns --limits-from-plan --mysql
done < $INPUT
IFS=$OLDIFS
