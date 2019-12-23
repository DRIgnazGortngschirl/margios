#!/bin/bash

# Phase 1 Standart Hosts to check
echo 'google.at' >> hosts.txt
echo '1.1.1.1' >> hosts.txt
echo "Standart Hosts to check has been set"
echo Enter user for systemd
read USER
echo "[i] : Searching for installation path ... This can take a few moments"
INSTALLATIONPATH=$(find / -name "*margios" 2>/dev/null)
echo "Installation path : $INSTALLATIONPATH"
echo "[i] : Found installation path"

# Phase 2 Seting up Systemd Service
echo "[Unit]" >> /etc/systemd/system/margios.service
echo "Description=Marios's Nagius @ https://github.com/MrMarioMichel/margios" >> /etc/systemd/system/margios.service
echo "After=network-online.target" >> /etc/systemd/system/margios.service
echo "StartLimitIntervalSec=0" >> /etc/systemd/system/margios.service
echo "" >> /etc/systemd/system/margios.service
echo "[Service]" >> /etc/systemd/system/margios.service
echo "Type=simple" >> /etc/systemd/system/margios.service
echo "User=$USER" >> /etc/systemd/system/margios.service
echo "ExecStart=/bin/bash $INSTALLATIONPATH" >> /etc/systemd/system/margios.service
echo "" >> /etc/systemd/system/margios.service
echo "[Install]" >> /etc/systemd/system/margios.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/margios.service
echo "Systemd Service was created"

# Phase 3 Enable Autostartup
systemctl enable margios.service
systemctl start margios.service
systemctl status margios.service
echo "Autostartup was enabled"

# Phase 4 Install telegram-send 
apt-get install python3-pip
pip3 install telegram-send
telegram-send --configure
echo "Telegram send has been configured"
