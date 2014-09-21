#!/bin/sh

VPNUP='vpnup.sh'
VPNDOWN='vpndown.sh'
VPNLOG='/tmp/autoddvpn.log'
IPUP="/tmp/pptpd_client/vpn"
TEMP_LK=1
TEMP_LK2=0

PPTP_ENABLE=$(nvram get pptpd_client_enable)

echo "Super autoddvpn start! v1_0" >> $VPNLOG

sleep 10

while [ 1 -eq 1 ]
do
  PPTP_ENABLE=$(nvram get pptpd_client_enable)
  if [ 0 -ne $PPTP_ENABLE ]; then    
    if [ -f $IPUP -a $TEMP_LK2 -eq 0 ]; then
      /tmp/test_ppp1.sh
      if [ 0 -eq $? ]; then
       echo "ppp1 established!" >> $VPNLOG
       echo "Founding vpn..." >> $VPNLOG
       sleep 20
       echo "Vpn connected. Route info adding..." >> $VPNLOG
       /tmp/vpnup.sh pptp
       TEMP_LK=0
       TEMP_LK2=1
       echo "Route info added." >> $VPNLOG
      fi 
     fi
   fi
    
   if [ 0 -eq $PPTP_ENABLE ]; then
     sleep 5
     if [ 0 -eq $TEMP_LK ]; then
       echo "Vpn drop. Route info clearing..." >> $VPNLOG 
       /tmp/vpndown.sh pptp
       TEMP_LK=1
       TEMP_LK2=0
       echo "Vpn drop. Route info cleared." >> $VPNLOG 
     fi       
   fi
   sleep 20
done
