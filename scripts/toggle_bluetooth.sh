#!/bin/bash

status=`systemctl is-active bluetooth.service`

if [ $status == "active" ]; then
	sudo /etc/init.d/bluetooth stop
else
	sudo /etc/init.d/bluetooth start
fi
