#!/bin/bash

rm /mining/ccminer/run

cat run > /mining/ccminer/run

cat verus.service > /etc/systemd/system/verus.service

systemctl daemon-reload
systemctl enable verus
systemctl start verus
journalctl -f -u verus
