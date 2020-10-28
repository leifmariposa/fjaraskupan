#!/bin/bash

for i in 1 2 3 4 5 6
do
  echo try $i
  result=$(gatttool -b 00:1E:C0:57:41:35 --char-read -a 0x000B)
  echo result $result
  # Characteristic value/descriptor: 31 32 33 34 30 4c 5f 5f 5f 5f 30 31 30 30 30
  # 31 32 33 34 30 5f 5f 5f 5f 5f 30 30 30 30 30
  # pos 4 is fan speed
  # pos 10 - 12 is light intensity in %

  substring=${result:0:44}
  echo substring $substring
  if [ "$substring" == "Characteristic value/descriptor: 31 32 33 34" ]; then
    value=${result:63:14}
    echo value $value
    if [ "$value" == "30 30 30 30 30" ]; then
      echo zero
    fi
    exit
  fi
  sleep 2
done
