#!/bin/bash

# set_kitchen_fan.sh
#
# Script for to set the light in Fjäråskupan, https://www.fjaraskupan.se/ It is 
# controlled via bluetooth. If running on a Raspberry Pi it can be 
# set up according to this instruction: 
# https://www.instructables.com/Control-Bluetooth-LE-Devices-From-A-Raspberry-Pi/
#
# The script depends on mac.sh which should have the MAC address of the Fjäråskupan 
# set. The MAC address can be obtained with e. g. Bluetooth Mac Finder for Android.
#
# Command to set the fan speed look like this:
# gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d342d
# The hexadecimal string at the end of the command is the actual data sent to 
# Fjäråskupan. The second to last value, 34, is the fan speed value, 
# in this case 34 equals 4.
# To turn the fan off, there's a different command, 313233344c7566742d417573.
#
# The script takes one parameter, fan speed value 0 - 8
#

if [ -z "$1" ]; then
    echo "error: No argument supplied"; exit 1
fi

re='^[0-9]+$'
if ! [[ $1 =~ $re ]]; then
   echo "error: Fan speed value has to be a number"; exit 1
fi

if [ $1 -gt 8 ]; then
   echo "error: Fan speed value has to be in the interval 0 - 8"; exit 1
fi

# include the mac address
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $dir/mac_address.sh

# create set light command to Fjäråskupan
command="313233344c7566742d417573"
if [ $1 -gt 0 ] && [ $1 -lt 9 ]; then
  command=$(echo "313233342d4c7566742d3"$1"2d") 
fi

retries=0
while [ $retries -lt 20 ]; do
  result=$(timeout 0.6 gatttool -b $mac_address --char-write-req -a 0x000B -n $command 2>&1)
  let retries=retries+1 
  if [ "$result" == "Characteristic value was written successfully" ]; then
    # success
    exit 0
  fi
done

# all retries failed...
exit 1
