#!/bin/bash

nmcli connection down "Wired connection 1"
nmcli connection modify "Wired connection 1" ethernet.cloned-mac-address  86:e0:c0:ea:fa:b8
nmcli connection up "Wired connection 1"
