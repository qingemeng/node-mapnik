#!/bin/bash

set -eu
set -o pipefail

function install() {
    ./mason/mason install $1 $2
    ./mason/mason link $1 $2
}

ICU_VERSION="57.1"

if [ ! -f ./mason/mason.sh ]; then
    mkdir -p ./mason
    curl -sSfL https://github.com/mapbox/mason/archive/9a3f4d195614bb30d9ca54dd6070739de605cb14.tar.gz | tar --gunzip --extract --strip-components=1 --exclude="*md" --exclude="test*" --directory=./mason
fi

if [ ! -f ./mason_packages/.link/bin/mapnik-config ]; then

    # mapnik deps
    install jpeg_turbo 1.5.1
    install libpng 1.6.28
    install libtiff 4.0.7
    install icu ${ICU_VERSION}
    install proj 4.9.3
    install pixman 0.34.0
    install cairo 1.14.8
    install webp 0.6.0
    install libgdal 2.1.3
    install boost 1.65.1
    install boost_libsystem 1.65.1
    install boost_libfilesystem 1.65.1
    install boost_libregex_icu57 1.65.1
    install freetype 2.7.1
    install harfbuzz 1.4.2-ft

    # mapnik
    # NOTE: sync this version with the `mapnik_version` in package.json (which is used for windows builds)
    # In the future we could pull from that version automatically if mason were to support knowing the right dep
    # versions to install automatically. Until then there is not much point since the deps are still hardcoded here.
    install mapnik 3.0.18
fi
