#!/bin/bash
set -eu

clang++-19 ./Main.cpp -o a.out "${USER_BUILD_FLAGS[@]}"
