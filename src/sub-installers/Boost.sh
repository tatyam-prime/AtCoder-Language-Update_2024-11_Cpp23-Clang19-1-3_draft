#!/bin/bash
set -eu

sudo ln -s /usr/bin/clang-19 /usr/bin/clang
sudo ln -s /usr/bin/clang++-19 /usr/bin/clang++

cd /tmp/

mkdir -p ./boost/

sudo wget -q "https://archives.boost.io/release/${VERSION}/source/boost_${VERSION//./_}.tar.bz2" -O ./boost.tar.bz2
sudo tar -I pbzip2 -xf ./boost.tar.bz2 -C ./boost/ --strip-components 1

cd ./boost/

sudo ./bootstrap.sh --with-toolset=clang --without-libraries=mpi,graph_parallel

BUILD_ARGS=(
    -d0
    "-j$(nproc)"
    "toolset=clang"
    "threading=single"
    "variant=release"
    "link=static"
    "runtime-link=static"
    "cxxflags=${INTERNAL_BUILD_FLAGS[*]}"
)

sudo ./b2 "${BUILD_ARGS[@]}" stage
sudo ./b2 "${BUILD_ARGS[@]}" --prefix=/opt/boost/ install
