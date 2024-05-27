#!/bin/bash

rm -rf build
mkdir -p build
pushd build

cmake -DCMAKE_BUILD_TYPE=relwithdebinfo -DCMAKE_TOOLCHAIN_FILE==${VCPKG_ROOT}/vcpkg/scripts/buildsystems/vcpkg.cmake -DVCPKG_TARGET_TRIPLET=x64-linux ..
cmake --build . --config relwithdebinfo

popd

# popd

# echo continue && read -n 1
