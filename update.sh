#!/bin/bash

cat /etc/environment | grep -v Pool | grep -v Port | grep -v Verus > /etc/environment

cat environment.vals >> /etc/environment

rm /mining/ccminer/run

cat run > /mining/ccminer/run

chmod 777 /mining/ccminer/run

systemctl restart verus
