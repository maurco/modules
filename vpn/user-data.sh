#!/usr/bin/env bash

sudo su

export DEBIAN_FRONTEND=noninteractive

NOOB="/home/openvpnas/.noob"
SACLI="/usr/local/openvpn_as/scripts/sacli"

# install dependencies
apt-get update
apt-get install -y fail2ban

# prompt a password change on first login
touch $NOOB
cat <<EOT >> /home/openvpnas/.profile
if [[ -f $NOOB ]]; then
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

# initialize OpenVPN
ovpn-init --host=${domain} --no_reroute_gw --local_auth --batch --force # --ec2

# configure OpenVPN
# $SACLI --key "host.name" --value "${domain}" ConfigPut
# $SACLI --key "vpn.client.routing.reroute_gw" --value "false" ConfigPut
$SACLI --key "vpn.client.routing.inter_client" --value "false" ConfigPut
$SACLI --key "vpn.client.routing.reroute_dns" --value "true" ConfigPut
$SACLI --key "vpn.server.routing.gateway_access" --value "false" ConfigPut
$SACLI --key "vpn.server.routing.private_network.0" --value "${cidr_block}" ConfigPut

# configure SSL certificate
[[ ! -z "${cert}" ]] && $SACLI --key "cs.cert" --value "${cert}" ConfigPut
[[ ! -z "${ca_bundle}" ]] && $SACLI --key "cs.ca_bundle" --value "${ca_bundle}" ConfigPut
[[ ! -z "${priv_key}" ]] && $SACLI --key "cs.priv_key" --value "${priv_key}" ConfigPut

# $SACLI start

# stop instance until it's needed
shutdown -h now

