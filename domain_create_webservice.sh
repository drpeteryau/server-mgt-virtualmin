#!/bin/bash
# Author: Peter Yau
# E-mail: drpeteryau@gmail.com
# Description: create virtualmin doamin from csv file
# Configs: [default_password], [plan_name]
# ------------------------------------------
INPUT=$1
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read domain
do
	virtualmin create-domain --domain $domain --pass "[default_password]" --plan "[plan_name]" --unix --dir --webmin --web --dns --limits-from-plan --mysql
done < $INPUT
IFS=$OLDIFS
