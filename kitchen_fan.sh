#!/bin/bash

val=-1

for i in 1 2 3 4 5 6
do
  if (($1==0)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233344c7566742d417573) # Luft-Aus
  elif (($1==1)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d312d) # -Luft-1-
  elif (($1==2)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d322d) # -Luft-2-
  elif (($1==3)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d332d) # -Luft-3-
  elif (($1==4)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d342d) # -Luft-4-
  elif (($1==5)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d352d) # -Luft-5-
  elif (($1==6)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d362d) # -Luft-6-
  elif (($1==7)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d372d) # -Luft-7-
  elif (($1==8)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d382d) # -Luft-8-
  else
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d4c7566742d342d) # -Luft-4-
  fi

  if [ "$result" == "Characteristic value was written successfully" ]; then
    echo ok
    exit
  else
    echo $i: $result
  fi
  sleep 2
done

echo "Timeout!"

