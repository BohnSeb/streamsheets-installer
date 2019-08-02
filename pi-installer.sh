#!/bin/sh

#this is a script to install streamsheets on raspberry pi with raspbian buster
#sudo apt-get update
#sudo apt-get upgrade


#download docker install script
#when installed with this script there will be a docker & docker-engine folder in /var/lib and docker folder in /usr/bin
cd ~


if [ -f /usr/bin/docker ]
then
	echo "Docker already exists"
else
	echo "installing docker"
	echo ""
	sudo curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
	sudo usermod -aG docker pi
	echo "installed docker"
fi


if [ -d "/usr/local/lib/python3.7/dist-packages/compose" ]
then
	echo "docker-compose is already installed"
else
	echo "installing docker-compose now"
	echo ""
	sudo pip3 install docker-compose
	echo "finished installing docker-compose"
fi

echo "docker & docker-compose is installed, now need to login"
echo "_______________________________________________________"
sudo docker login

echo ""
echo "now downloading streamsheet installing wizard"
mkdir cedalo
cd cedalo
sudo docker run -v ~/cedalo:/streamsheets cedalo/streamsheets-installer:1.3-rpi

echo "new yml is now downloaded, you can start streamsheets by executing ~/cedalo/streamsheets/scripts/start.sh with: sh ~/cedalo/streamsheets/scripts/start.sh"
sleep 5
echo ""
echo ""
echo ""
read -p "Do you want to start streamsheets now? (Y/N): " choice
case "$choice" in
	y|Y ) cd streamsheets/scripts; sh start.sh;;
	n|N ) echo "closing shell";;
	* ) echo "type in y/Y or n/N: "
esac