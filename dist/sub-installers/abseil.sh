#!/bin/bash
########## AUTO-GENERATED ##########
# Do not modify this file manually #
####################################
VERSION="20240722.0"

set -eu

cd /tmp/

mkdir -p ./abseil/

sudo wget -q "https://github.com/abseil/abseil-cpp/releases/download/${VERSION}/abseil-cpp-${VERSION}.tar.gz" -O ./abseil.tar.gz
sudo tar -I pigz -xf ./abseil.tar.gz -C ./abseil/ --strip-components 1

cd ./abseil/

mkdir -p ./build/ && cd ./build/

BUILD_ARGS=(
    -DCMAKE_CXX_COMPILER=clang++-19
    -DCMAKE_C_COMPILER=clang-19
    -DABSL_PROPAGATE_CXX_STD:BOOL=ON
    -DCMAKE_INSTALL_PREFIX:PATH=/opt/abseil/
    -DCMAKE_CXX_FLAGS:STRING="${INTERNAL_BUILD_FLAGS[*]}"
)

if [[ -v RUN_TEST ]]; then
    sudo cmake -DABSL_BUILD_TESTING=ON -DABSL_USE_GOOGLETEST_HEAD=ON "${BUILD_ARGS[@]}" ../

    sudo make "-j${PARALLEL}"
    sudo ctest --parallel "${PARALLEL}"
else
    sudo cmake "${BUILD_ARGS[@]}" ../
fi

sudo cmake --build ./ --target install --parallel "${PARALLEL}"
