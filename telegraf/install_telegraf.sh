#!/usr/bin/env bash

sudo echo "deb https://repo.delellis.com.ar buster buster" > /etc/apt/sources.list.d/20-pdlib.list
sudo apt-get update && sudo apt-get install apt-transport-https
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
echo "deb https://repos.influxdata.com/debian buster stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo apt-get update && sudo apt-get install telegraf
sudo usermod -a -G video telegraf
sudo systemctl stop telegraf; sudo systemctl start telegraf
