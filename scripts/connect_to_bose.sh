#!/bin/bash

sudo /etc/init.d/bluetooth start
echo 'connect 2C:41:A1:2F:B2:00' | bluetoothctl
