#!/bin/bash

OUTPUT=$(ifconfig show | awk '/inet.*brd/{print $NF; exit}')
GATEWAY_IP=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
# OUTPUT="eth0"
# GATEWAY_IP="192.168.1.1"
RAND_NUMB=$(( $RANDOM % 255 ))

for X in ${RAND_NUMB}
do
    GET_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | sed -n 1p | awk -F. '{ print $1"."$2"."$3"."$4 }')
    RAND_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | sed -n 1p | awk -F. '{ print $1"."$2"."$3"."$4+'${RAND_NUMB}' }')
    if [[ $GET_IP == $RAND_IP ]]
    then
        continue
    fi

    STATIC_IP=${RAND_IP}
    echo ">>>>>>>>>>>Your static IP address is ${STATIC_IP}<<<<<<<<<<<<<<<<<<<<"
done

echo interface ${OUTPUT} >> /Users/sunny/pi-vpn/dummy.sh
echo -e '\t'Static ip_address=${STATIC_IP} >> /Users/sunny/pi-vpn/dummy.sh
echo -e '\t'Static routers=${GATEWAY_IP} >> /Users/sunny/pi-vpn/dummy.sh
