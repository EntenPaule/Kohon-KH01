#!/bin/bash

CORES=$(grep -c processor /proc/cpuinfo)

sudo service klipper stop
cd ~/klipper

# Update mcu rpi
echo "Start update mcu rpi"
echo ""
make clean KCONFIG_CONFIG=/home/pi/klipper_config/script/config.host
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.host
make -j $CORES KCONFIG_CONFIG=/home/pi/klipper_config/script/config.host
read -p "mcu rpi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash KCONFIG_CONFIG=/home/pi/klipper_config/script/config.host
echo "Finish update mcu rpi"
echo ""

# Update mcu XYE
echo "Start update mcu XYZE"
echo ""
make clean KCONFIG_CONFIG=/home/pi/klipper_config/script/config.mksgenl
#make menuconfig KCONFIG_CONFIG=/home/pi/klipper_config/script/config.mksgenl
make -j $CORES KCONFIG_CONFIG=/home/pi/klipper_config/script/config.mksgenl
read -p "mcu XYZE firmware built, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"
make flash FLASH_DEVICE=/dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0
echo "Finish update mcu XYZE"
echo ""

sudo service klipper start
