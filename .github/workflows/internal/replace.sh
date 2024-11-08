#!/bin/bash

set -eu

function get-content() {
    sed 's/$/\\\\n/' "$1" |
        sed -r '$s/\\\\n//' |
        while IFS= read -r line; do
            echo -n "$line"
        done
}

installer=$(cat ./install.sh)
builder=$(cat ./compile.sh)

target=$(cat ./install.toml)

mkdir -p ./dist/

target="${target//"\${{ref:installer}}"/"\n${installer}\n"}"
echo -e "### AUTO GENERATED (DO NOT MODIFY THIS FILE MANUALLY) ###\n\n${target//"\${{ref:builder}}"/"\n${builder}\n"}" >./dist/install.toml
