#!/bin/bash

logger -t post-install.sh tunapanda post-install process starting...

#cat > /etc/hosts <<EOF
#127.0.0.1	localhost tunapanda
#127.0.1.2	moodle
#127.0.1.3	wikipedia www.wikipedia.org en.wikipedia.org wikipedia.org
#127.0.1.4	askubuntu
#127.0.1.5	ka-lite
#
## The following lines are desirable for IPv6 capable hosts
#::1     ip6-localhost ip6-loopback
#fe00::0 ip6-localnet
#ff00::0 ip6-mcastprefix
#ff02::1 ip6-allnodes
#ff02::2 ip6-allrouters
#EOF

cat >> /etc/hosts <<EOF

127.0.1.2	moodle
127.0.1.3	wikipedia www.wikipedia.org en.wikipedia.org wikipedia.org
127.0.1.4	askubuntu
127.0.1.5	ka-lite
EOF

cat > /etc/apt/sources.list <<EOF
deb file:/usr/local/tunapanda/packages tunapanda main
EOF
apt-get update
apt-get autoremove -y
apt-get upgrade -y

find /etc/skel /home -name ltsp-live.desktop -exec rm -f {} \;

#ssh-keygen -A 
#ltsp-update-sshkeys && ltsp-update-image
