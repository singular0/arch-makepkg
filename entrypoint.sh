#!/bin/bash

if [[ -z "$1" ]]; then
    PKGBUILD=$1
else
    PKGBUILD=./PKGBUILD
fi

echo "Running makepkg for '$PKGBUILD'"

pkg_deps=$(source "$PKGBUILD" && echo ${makedepends[@]} ${depends[@]})
echo "Installing dependencies: $pkg_deps"
pacman -Syu --noconfirm $pkg_deps

chown -R builder "$PWD"

echo "Running makepkg"

# TODO: support extra flags

su --login builder --command="makepkg -fs $PKGBUILD"

echo "Running namcap"

namcap -i *.pkg.tar.xz
