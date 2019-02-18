#!/bin/bash

on=""
off=""
regex="Status: (\w+)"
status=`nordvpn status`

if [[ $status =~ $regex ]];
then
	if [[ ${BASH_REMATCH[1]} == "Connected" ]];
	then
		echo "$on"
	else
		echo "$off"
	fi
fi

