#!/bin/bash

val=-1

for i in 1 2 3 4 5 6
do
  if (($1==0)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233344b6f636866656c64) # Kochfeld
  elif (($1==1)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3030312d) # 001
  elif (($1>=2 && $1<=14)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3031302d) # 010
  elif (($1>=15 && $1<=24)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3032302d) # 020
  elif (($1>=25 && $1<=34)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3033302d) # 030
  elif (($1>=35 && $1<=44)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3034302d) # 040
  elif (($1>=45 && $1<=54)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3035302d) # 050
  elif (($1>=55 && $1<=64)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3036302d) # 060
  elif (($1>=65 && $1<=74)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3037302d) # 070
  elif (($1>=75 && $1<=84)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3038302d) # 080
  elif (($1>=85 && $1<=94)); then
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3039302d) # 090
  else
    result=$(gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3130302d) # 100
  fi

  if [ "$result" == "Characteristic value was written successfully" ]; then
    echo $i - ok
    exit
  fi
  sleep 2
done

echo "Timeout!"
