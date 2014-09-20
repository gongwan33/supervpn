#!/bin/sh

VPNUP='vpnup.sh'
VPNDOWN='vpndown.sh'
VPNLOG='/tmp/autoddvpn.log'
IPUP="/tmp/pptpd_client/vpn"

echo "Finding vpn..." >> $VPNLOG
while [ 1 -eq 1 ]
do 
 if [ -f $IPUP ]; then
   sleep 10
   /tmp/vpnup.sh pptp
   break
 fi 
 sleep 10
done
 
echo "Waiting vpn exit..." >> $VPNLOG
while [ 1 -eq 1 ]
do 
 if [ ! -f $IPUP ]; then
   sleep 5
   /tmp/vpndown.sh pptp
   break
 fi
 sleep 10
done


