#!/bin/bash
set -eu

### Clang
cd /tmp/
sudo apt-get install -y lsb-release software-properties-common gnupg

wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 19
sudo apt-get install -y libc++-19-dev

sudo apt-get purge -y --auto-remove lsb-release software-properties-common gnupg

### Libraries
sudo apt-get install -y build-essential cmake pigz pbzip2

./sub-installers/abseil.sh
./sub-installers/AC-Library.sh
./sub-installers/Boost.sh
./sub-installers/Eigen.sh
./sub-installers/GMP.sh
./sub-installers/range-v3.sh
./sub-installers/unordered_dense.sh

sudo apt-get purge -y --auto-remove build-essential cmake pigz pbzip2
