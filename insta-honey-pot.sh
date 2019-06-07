#!/bin/bash
apt update
apt-get install git python-virtualenv libssl-dev libffi-dev build-essential libpython-dev python2.7-minimal authbind python-pip dialog -y
sudo adduser --disabled-password --gecos cowrie
runuser -l cowrie -c 'git clone http://github.com/micheloosterhof/cowrie'
runuser -l cowrie -c 'cd cowrie'
runuser -l cowrie -c 'virtualenv cowrie-env'
runuser -l cowrie -c 'source cowrie-env/bin/activate'
runuser -l cowrie -c 'pip install -r ~/cowrie/requirements.txt'
runuser -l cowrie -c 'cp ~/cowrie/etc/cowrie.cfg.dist ~/cowrie/etc/cowrie.cfg'
hostname=$(dialog --inputbox "Type in a convincing hostname." 10 60 3>&1 1>&2 2>&3 3>&1) || exit
runuser -l cowrie -c "sed -i '29s/.*/hostname = $hostname/' ~/cowrie/etc/cowrie.cfg"
ssh=$(dialog --inputbox "Type in an new ssh port for root (port 22 is for the honeypot) \n You will have to log onto the server from this port from now on. \n **ssh connection may break at this point, just log back in and restart script" 10 60 3>&1 1>&2 2>&3 3>&1)
let ssh="$ssh$number"
echo 'Port' $ssh >> /etc/ssh/sshd_config
service ssh restart
iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222
runuser -l cowrie -c "sed -i '492s/.*/enabled = true/' ~/cowrie/etc/cowrie.cfg"
runuser -l cowrie -c 'export PYTHONPATH=/home/cowrie/cowrie'
runuser -l cowrie -c 'source cowrie-env/bin/activate'
runuser -l cowrie -c 'virtualenv cowrie-env'
runuser -l cowrie -c 'pip install -r ~/cowrie/requirements.txt'
runuser -l cowrie -c '~/cowrie/bin/cowrie start'
netstat -tan
echo "Remember you will have to log into your ssh server from the $ssh port from now on!"
su cowrie

