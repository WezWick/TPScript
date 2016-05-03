#!/bin/bash
#Travis Perkins DevOps Engineer Test

username=$1
host=$2

if [ $# -eq 0 ]; then
echo $0: Usage: Travisperkins.sh ssh-username ssh-host
exit 1
fi

ssh -t $username@$host '
sleep 3;
hostname;
sleep 3;
echo UPDATE PACKAGE LIST...;
sleep 3;
sudo apt-get update;
echo Dist-Upgrade...;
sleep 3;
sudo apt-get -y dist-upgrade;
sleep 3;
echo UPDATE PACKAGE LIST...;
sudo apt-get update;
sleep 3;
echo INSTALL UNCOMPLICATED FIREWALL.....;
sudo apt-get -y install ufw;
sleep 3;
echo Enable UFW....;
sudo ufw --force enable;
sleep 3;
echo ADD SSH RULE....;
sudo ufw allow ssh;
sleep 3;
echo GOING DOWN FOR A REBOOT....;
sudo reboot;'

while ! ssh -t $username@$host 'echo UPTIME IS....; uptime;'
do
 sleep 2;
 echo "Trying again..."
done

echo Provisioned