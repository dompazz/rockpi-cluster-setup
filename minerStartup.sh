#!/bin/bash

apt install -y libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential

wget -qO- https://apt.llvm.org/llvm.sh | bash -s -- 18

git clone https://github.com/dompazz/ccminer

cd ccminer

ln -s /usr/bin/clang-18 /usr/bin/clang
ln -s /usr/bin/clang++-18 /usr/bin/clang++
ln -s /usr/bin/clang-cpp-18 /usr/bin/clang-cpp

./build.sh

export VerusThreads=$(nproc)
export PoolHost=verus.aninterestinghole.xyz
export Port=9999
export PublicVerusCoinAddress=RNBV5hhpoPceg4JiKTWKbkeQzPDPKUZDM6

tmux new-session -d -s "Verus" ./ccminer -a verus -o stratum+tcp://${PoolHost}:${Port} -u ${PublicVerusCoinAddress}.$(hostname) -t ${VerusThreads} -N 20
