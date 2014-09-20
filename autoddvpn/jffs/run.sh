#!/bin/sh

VPNUP='vpnup.sh'
VPNDOWN='vpndown.sh'
VPNLOG='/tmp/autoddvpn.log'
IPUP="/tmp/pptpd_client/vpn"
TEMP_LK=0

PPTP_ENABLE=$(nvram get pptpd_client_enable)


while [ 1 -eq 1 ]
do
  PPTP_ENABLE=$(nvram get pptpd_client_enable)
  if [ 0 -ne $PPTP_ENABLE ]; then
    echo "Founding vpn..." >> $VPNLOG
    while [ 1 -eq 1 ]
    do  
     if [ -f $IPUP ]; then
       sleep 10
       echo "Vpn connected. Route info adding..." >> $VPNLOG
       /tmp/vpnup.sh pptp
       TEMP_LK=0
       echo "Route info added." >> $VPNLOG
       break
     fi 
     sleep 20
    done
   fi
    
   if [ ! -f $IPUP ]; then
     sleep 5
     if [ 0 -eq $TEMP_LK ]; then
       echo "Vpn drop. Route info clearing..." >> $VPNLOG 
       /tmp/vpndown.sh pptp
       TEMP_LK=1
       echo "Vpn drop. Route info cleared." >> $VPNLOG 
       break
     fi       
   fi
   sleep 20
done
