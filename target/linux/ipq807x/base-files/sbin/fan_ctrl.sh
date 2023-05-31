#!/bin/sh

NSS_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
CPU_TEMP=$(cat /sys/class/thermal/thermal_zone9/temp)
WIFI0_TEMP=$(cat /sys/class/hwmon/hwmon2/temp1_input 2>/dev/null) || WIFI0_TEMP=0
WIFI1_TEMP=$(cat /sys/class/hwmon/hwmon3/temp1_input 2>/dev/null) || WIFI1_TEMP=0
WIFI2_TEMP=$(cat /sys/class/hwmon/hwmon4/temp1_input 2>/dev/null) || WIFI2_TEMP=0

NSS_LOW=70000
NSS_HIGH=75000
CPU_LOW=70000
CPU_HIGH=75000
WIFI_LOW=75000
WIFI_HIGH=80000

FAN_CTRL=/sys/class/gpio/fan/value
if ! [ -f "$FAN_CTRL" ];then
	exit 0
fi

if [ "$NSS_TEMP" -ge "$NSS_HIGH" -o "$CPU_TEMP" -ge "$CPU_HIGH" -o "$WIFI0_TEMP" -ge "$WIFI_HIGH" -o "$WIFI1_TEMP" -ge "$WIFI_HIGH" -o "$WIFI2_TEMP" -ge "$WIFI_HIGH" ];then
	echo "1" > $FAN_CTRL
elif [ "$NSS_TEMP" -lt "$NSS_LOW" -o "$CPU_TEMP" -lt "$CPU_HIGH" -o "$WIFI0_TEMP" -lt "$WIFI_LOW" -o "$WIFI1_TEMP" -lt "$WIFI_LOW" -o "$WIFI2_TEMP" -lt "$WIFI_LOW" ];then
	echo "0" > $FAN_CTRL
fi
