#!/bin/bash

apt update
apt upgrade -y
apt install -y libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential
apt install -y wget lsb-release wget software-properties-common gnupg

wget -qO- https://apt.llvm.org/llvm.sh | bash -s -- 18

git clone https://github.com/dompazz/ccminer

cd ccminer

rm /usr/bin/clang
rm /usr/bin/clang++
rm /usr/bin/clang-cpp
ln -s /usr/bin/clang-18 /usr/bin/clang
ln -s /usr/bin/clang++-18 /usr/bin/clang++
ln -s /usr/bin/clang-cpp-18 /usr/bin/clang-cpp

./build.sh

export VerusThreads=$(nproc)
export PoolHost=usse.vipor.net
export Port=5040
export PublicVerusCoinAddress=RNBV5hhpoPceg4JiKTWKbkeQzPDPKUZDM6

tmux new-session -d -s "Verus" ./ccminer -a verus -o stratum+tcp://${PoolHost}:${Port} -u ${PublicVerusCoinAddress}.$(hostname) -t ${VerusThreads} -N 100

cd ~
wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.92/lolMiner_v1.92_Lin64.tar.gz
tar -xvf lolMiner_v1.92_Lin64.tar.gz
cd 1.92

tmux new-session -d -s "Ergo" ./lolMiner --algo AUTOLYKOS2 --pool us2.ergo.herominers.com:1180 --user 9fVrW4psZifRfTR7dsADDp6EF3TNfi1MaKHtn4MMcgSxnM3xXzj.$(hostname)
