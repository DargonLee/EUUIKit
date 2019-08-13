#!/usr/bin/env bash
set -u
set -e
mkdir -p ../libs
rm -rf ../obj
rm -rf ../libs/*/*.so

ndk-build clean
ndk-build -B NDK_DEBUG=0

for file in $(find ../obj/local -depth 2)
do
    if [[ ${file##*.} != 'so' ]]; then
         rm -rf ${file}
    fi
done
#rm -rf ../obj