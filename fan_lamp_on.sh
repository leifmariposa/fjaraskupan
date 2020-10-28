#!/bin/sh

sudo gatttool -b 00:1E:C0:57:41:35 --char-write-req -a 0x000B -n 313233342d44696d3130302d
