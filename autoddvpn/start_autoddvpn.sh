#!/bin/sh
cd /tmp
#wget http://gongwan34.3vzhuji.com/options.sh
#mv options.sh /tmp/pptpd_client/options.vpn
wget http://gongwan34.3vzhuji.com/jffs/run.sh
wget http://gongwan34.3vzhuji.com/pptp/vpnup.sh
wget http://gongwan34.3vzhuji.com/pptp/vpndown.sh
chmod a+x run.sh
chmod a+x vpnup.sh
chmod a+x vpndown.sh
/tmp/run.sh &

