#!/usr/bin/env bash

sudo su
export DEBIAN_FRONTEND=noninteractive

# install dependencies
apt-get update
apt-get install -y fail2ban

# prompt a password change on first login
NOOB="/home/openvpnas/.noob"
touch $NOOB

cat <<EOT >> /home/openvpnas/.profile
if [ -f $NOOB ]; then
	sudo passwd openvpn
	rm -f $NOOB
fi
EOT

# accept ssh connections only if it is a new connection
iptables -I INPUT -p tcp --dport ${port} -i eth0 -m state --state NEW -m recent --set

# make iptables entries persistent on reboot
iptables-save > /etc/iptables.up.rules
printf "@reboot root /bin/bash iptables-restore < /etc/iptables.up.rules" > /etc/cron.d/iptables.up

# harden SSH configuration
printf "%s\n" "PermitRootLogin no" "PasswordAuthentication no" "Port ${port}" >> /etc/ssh/sshd_config
printf "%s\n" "[sshd]" "enabled = true" "port = ${port}" > /etc/fail2ban/jail.local

# configure OpenVPN
ovpn-init --host=${domain} --ec2 --batch --local_auth --no_reroute_gw --force

# request SSL certificate
# certbot certonly --standalone --agree-tos --email jane@doe.com -nd ${domain}

# install SSL certificate
# ln -s -f /etc/letsencrypt/live/${domain}/cert.pem /usr/local/openvpn_as/etc/web-ssl/server.crt
# ln -s -f /etc/letsencrypt/live/${domain}/privkey.pem /usr/local/openvpn_as/etc/web-ssl/server.key

# stop instance until it's needed
shutdown -h now
