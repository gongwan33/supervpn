#!/bin/sh

VPNUP='vpnup.sh'
VPNDOWN='vpndown.sh'
VPNLOG='/tmp/autoddvpn.log'
IPUP="/tmp/pptpd_client/vpn"

while [ 1 -eq 1 ]
do
  echo "Finding vpn..." >> $VPNLOG
  while [ 1 -eq 1 ]
  do 
   ifconfig ppp1; 
   if [ 0 -eq $? ]; then
     sleep 10
     /tmp/vpnup.sh pptp
     break
   fi 
   sleep 20
  done
 
  echo "Waiting vpn exit..." >> $VPNLOG
  while [ 1 -eq 1 ]
  do
   ifconfig ppp1; 
   if [ 0 -ne $? ]; then
     sleep 5
     /tmp/vpndown.sh pptp
     break
   fi
   sleep 20
  done
done

