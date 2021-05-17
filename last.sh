#!/bin/bash

rm /mining/ccminer/run

cat run > /mining/ccminer/run

chmod 777 /mining/ccminer/run

cat verus.service > /etc/systemd/system/verus.service

systemctl daemon-reload
systemctl enable verus
systemctl start verus
journalctl -f -u verus
