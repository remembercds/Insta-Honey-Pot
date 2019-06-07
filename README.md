# Insta-Honey-Pot
Simple script to set up a cowrie honey pot. Tested on Debian 9.7 and Ubuntu 18.04 on 1gb ram/1 vCPUs VPS servers.
![scary](https://i.imgur.com/MD3KRdK.png)
Almost immediately after install, spooky hackers will start trying to break in!
# How to get it working
```
git clone https://github.com/remembercds/Insta-Honey-Pot.git
cd /Insta-Honey-Pot
chmod +x
./insta-honey-pot.sh
```
If your terminal output looks like this by the end of the script:

```
Using default Python virtual environment "/home/cowrie/cowrie-env"
Starting cowrie: [twistd   --umask=0022 --pidfile=var/run/cowrie.pid --logger cowrie.python.logfile.logger cowrie ]...
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State          
................................................................................................
tcp        0      0 0.0.0.0:2222            0.0.0.0:*               LISTEN     
tcp        0      0 0.0.0.0:2223            0.0.0.0:*               LISTEN
................................................................................................
............................[blah blah blah]....................................................
.....................[more data printed by netstat here]........................................
................................................................................................
Remember you will have to log into your ssh server from the [whatever port you inputed] from now on!

```
That means it's working!


# Usage
First off heed, this reminder:
`
Remember you will have to log into your ssh server from the [whatever port you inputed] from now on!
`
At the end of the script you will be in the cowrie user, `cd` to get to home directory where cowrie files are.

- to print stream of logs
`tail -f ~/cowrie/var/log/cowrie/cowrie.log`

- restart honeypot
`~/cowrie/bin/cowrie restart`

- edit config
`vim ~/cowrie/etc/cowrie.conf`

- access virtual env
`source cowrie-env/bin/activate`
