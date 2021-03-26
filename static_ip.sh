#!/bin/bash

NIC=$(ifconfig show | awk '/inet.*brd/{print $NF; exit}')
GATEWAY_IP=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
DNS_SERVER_IP=$(awk -F" " '/nameserver/{print $2;}' /etc/resolv.conf | sed -n 2p)
IPV6_ADDRESS=$(awk -F" " '/nameserver/{print $2;}' /etc/resolv.conf | sed -n 3p)

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
done

echo interface ${NIC} >> /etc/dhcpcd.conf
echo -e '\t'Static ip_address=${STATIC_IP} >> /etc/dhcpcd.conf
echo -e '\t'Static routers=${GATEWAY_IP} >> /etc/dhcpcd.conf
echo -e '\t'static domain_name_servers=${GATEWAY_IP} ${DNS_SERVER_IP} ${IPV6_ADDRESS} >> /etc/dhcpcd.conf

read -p "The application would like to reboot your system! [yn]" answer
if [[ $answer = y ]] ; then
  sudo reboot || echo "An issue with the reboot command. Please reboot your system manaully!"
else
    echo "Done setting static-IP, but to take effect you need to reboot your system."
fi