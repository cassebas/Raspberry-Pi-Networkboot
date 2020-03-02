#!/usr/bin/env bash

# Don't expect stdin to be available during provisioning
export DEBIAN_FRONTEND=noninteractive

# cat <<EOF > /etc/hosts
# 127.0.0.1		localhost
# 127.0.1.1		bootserver		bootserver
# 192.168.1.2	bootserver.local	bootserver
# EOF

apt-get update
apt-get install isc-dhcp-server tftp-hpa tftpd-hpa -y

# Configure the DHCP server
cat <<EOF > /etc/dhcp/dhcpd.conf
default-lease-time 600;
max-lease-time 7200;
ddns-update-style none;
authoritative;
log-facility local7;
subnet 10.0.2.0 netmask 255.255.255.0 {
}
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.100 192.168.1.200;
  option routers 192.168.1.1;
  option subnet-mask 255.255.255.0;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
  option tftp-server-name "192.168.1.2";
}
EOF

systemctl restart isc-dhcp-server

# Configure the TFTP server
cat <<EOF > /etc/default/tftpd-hpa
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/srv/tftp"
TFTP_ADDRESS=":69"
EOF

systemctl restart tftpd-hpa
