#!/bin/bash

# set_kitchen_fan_light.sh
#
# Script for to set the light in Fjäråskupan, https://www.fjaraskupan.se/ It is 
# controlled via bluetooth. If running on a Raspberry Pi it can be 
# set up according to this instruction: 
# https://www.instructables.com/Control-Bluetooth-LE-Devices-From-A-Raspberry-Pi/
#
# The script depends on mac.sh which should have the MAC address of the Fjäråskupan 
# set. The MAC address can be obtained with e. g. Bluetooth Mac Finder for Android.
#
# Command to set the light look like this:
# gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3130302d
# The hexadecimal string at the end of the command is the actual data sent to 
# Fjäråskupan. The second to last three values, 313030, is the light value in percent, 
# in this case 313030 equals 100 %.
#
# The script takes one parameter, brightness 0 - 255
#

#echo $(date -u) "set_kitchen_fan_light.sh $1" >> /home/pi/bluetooth/fan_light.log

if [ -z "$1" ]; then
    echo "error: No argument supplied"; exit 1
fi

re='^[0-9]+$'
if ! [[ $1 =~ $re ]]; then
   echo "error: Light value has to be a number"; exit 1
fi

if [ $1 -gt 255 ]; then
   echo "error: Light value has to be in the interval 0 - 100%"; exit 1
fi

# include the mac address
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $dir/mac_address.sh

brightness_in_percent=$(bc <<< $1/2.55)
percent_string=$(printf "%03g" $brightness_in_percent) # convert the brightness in percent to a three digit string
d1=$(echo $percent_string | cut -c1) # get first digit
d2=$(echo $percent_string | cut -c2) # get second digit
d3=$(echo $percent_string | cut -c3) # get third digit

command=$(echo "313233344B6F636866656C64") # '1234Kochfeld'
if [ $brightness_in_percent -gt 0 ]; then
  command=$(echo "313233342d44696d3"$d1"3"$d2"3"$d3"2d") # create set light command to Fjäråskupan, e.g. "1234-Dim000-"
fi

#echo $command >> /home/pi/bluetooth/log
retries=0
while [ $retries -lt 20 ]; do
  result=$(timeout 0.6 gatttool -b $mac_address --char-write-req -a 0x000B -n $command 2>&1)
  let retries=retries+1 
  if [ "$result" == "Characteristic value was written successfully" ]; then
    # success
    #echo $(date -u) "set_kitchen_fan_light.sh $1 - $command" >> /home/pi/bluetooth/fan_light.log
    exit 0
  fi
done

# all retries failed...
exit 1
