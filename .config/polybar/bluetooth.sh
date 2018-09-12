#!/bin/bash

on=""
off=""
status=`systemctl is-active bluetooth.service`

if [ $status == "active" ]; then
    echo "$on"
else
    echo "$off"
fi
