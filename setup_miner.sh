#!/bin/bash

mkdir /mining
chmod -R 777 /mining
cd /mining

apt-get -y install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential clang lld

wget https://versatilemc.net/ccminer_don.tar

tar xvzf ccminer_don.tar
mv ccminer_don ccminer

cd ccminer
chmod +x build.sh
chmod +x configure.sh
chmod +x autogen.sh
./build.sh


