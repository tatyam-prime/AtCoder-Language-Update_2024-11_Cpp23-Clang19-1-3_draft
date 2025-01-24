# shellcheck disable=all

BASIC_BUILD_FLAGS=(
    "-std=gnu++23"
    "-stdlib=libc++"
    "-fuse-ld=lld"
    -O2
)

BASIC_USER_BUILD_FLAGS=(
    ${BASIC_BUILD_FLAGS[@]}
    -DONLINE_JUDGE
    -DATCODER
    -Wall
    -Wextra
)

EXTRA_USER_BUILD_FLAGS=(
    "-march=native"
    "-flto=auto"
    "-fconstexpr-depth=2147483647"
    "-fconstexpr-steps=2147483647"
)

USER_LIBRARY_FLAGS=(
    -I/opt/abseil/include/ -L/opt/abseil/lib/
    -I/opt/ac-library/
    -I/opt/boost/include/ -L/opt/boost/lib/
    -I/usr/include/eigen3/
    -lgmpxx -lgmp
    -I/opt/range-v3/include/
    -I/opt/unordered_dense/include/ -L/opt/unordered_dense/lib/
)

INTERNAL_BUILD_FLAGS=( # for internal library building (CMake).
    ${BASIC_BUILD_FLAGS[@]}
    -w
)

USER_BUILD_FLAGS=( # for contestants.
    ${BASIC_USER_BUILD_FLAGS[@]}
    ${EXTRA_USER_BUILD_FLAGS[@]}
    ${USER_LIBRARY_FLAGS[@]}
)
