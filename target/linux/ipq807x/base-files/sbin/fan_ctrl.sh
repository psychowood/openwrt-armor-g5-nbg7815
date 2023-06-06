#!/bin/sh

NSS_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
CPU_TEMP=$(cat /sys/class/thermal/thermal_zone4/temp)
AQR_TEMP=$(cat /sys/class/hwmon/hwmon0/temp1_input 2>/dev/null) || AQR_TEMP=0
WIFI0_TEMP=$(cat /sys/class/hwmon/hwmon2/temp1_input 2>/dev/null) || WIFI0_TEMP=0
WIFI1_TEMP=$(cat /sys/class/hwmon/hwmon3/temp1_input 2>/dev/null) || WIFI1_TEMP=0
WIFI2_TEMP=$(cat /sys/class/hwmon/hwmon4/temp1_input 2>/dev/null) || WIFI2_TEMP=0

AQR_LOW=65000
AQR_HIGH=70000
NSS_LOW=65000
NSS_HIGH=70000
CPU_LOW=65000
CPU_HIGH=70000
WIFI_LOW=65000
WIFI_HIGH=70000

FAN_CTRL=/sys/class/gpio/fan/value
if ! [ -f "$FAN_CTRL" ];then
	exit 0
fi

if [ "$AQR_TEMP" -ge "$AQR_HIGH" -o "$NSS_TEMP" -ge "$NSS_HIGH" -o "$CPU_TEMP" -ge "$CPU_HIGH" -o "$WIFI0_TEMP" -ge "$WIFI_HIGH" -o "$WIFI1_TEMP" -ge "$WIFI_HIGH" -o "$WIFI2_TEMP" -ge "$WIFI_HIGH" ];then
	echo "1" > $FAN_CTRL
elif [ "$AQR_TEMP" -lt "$AQR_LOW" -o "$NSS_TEMP" -lt "$NSS_LOW" -o "$CPU_TEMP" -lt "$CPU_HIGH" -o "$WIFI0_TEMP" -lt "$WIFI_LOW" -o "$WIFI1_TEMP" -lt "$WIFI_LOW" -o "$WIFI2_TEMP" -lt "$WIFI_LOW" ];then
	echo "0" > $FAN_CTRL
fi
