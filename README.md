# Automated scripts for OpenVPN setting on Raspberry pi

## About the application

A simple project to convert your raspberry pi to openVPN server. Doing this you can,

- Access your files, music, and movies from anywhere
- Encrypt your mobile internet connection
- Print on your home printers from your laptop
- Bypass firewalls and website restrictions at work and abroad
- Hide your mobile IP address
- Connect with your home cameras and smart devices

## Components Required

-	Raspberry pi kit 
-	Permenant ethernet cable connection from Raspberry pi kit to your router/switch.

## Steps

- `ssh pi@[Enter your raspberrypi_ip_address]`
- `git clone https://github.com/yebh17/pi-vpn.git`
- `cd pi-vpn && chmod a+x *`
- `./init.sh`
- `./static_ip.sh`
- `./pi-vpn_install.sh`