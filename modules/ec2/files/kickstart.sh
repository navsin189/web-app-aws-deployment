#!/bin/sh
timestamp=`date +"%Y%b%d"`
rsyslog_conf="/etc/rsyslog.conf"
haproxy_conf="/etc/haproxy/haproxy.cfg"
rsyslog_conf_backup="/etc/rsyslog.conf.$timestamp"
haproxy_conf_backup="/etc/haproxy/haproxy.cfg.$timestamp"

sudo dnf install haproxy rsyslog -y
sudo cp $haproxy_conf $haproxy_conf_backup
sudo mv -f /home/haproxy.cfg $haproxy_conf
sudo systemctl restart haproxy
if [[ `echo $?` -ne 0 ]]; then
  echo "haproxy conf failed, reverting to original"
  sudo mv -f $haproxy_conf_backup $haproxy_conf
  sudo systemctl restart haproxy
fi

sudo cp $rsyslog_conf $rsyslog_conf_backup
sudo mv -f  /home/rsyslog.conf $rsyslog_conf
sudo systemctl restart rsyslog
if [[ `echo $?` -ne 0 ]]; then
  echo "rsyslog conf failed, reverting to original"
  sudo mv -f $rsyslog_conf_backup $rsyslog_conf
  sudo systemctl restart rsyslog
fi
echo "Kickstart setup Done"