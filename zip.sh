#!/bin/bash
set -eux

git submodule update

zipdir='exam'

mkdir -p "${zipdir}"
cp eng1team28.github.io/pdf/* "${zipdir}/"
cp zip.sh "${zipdir}"

git -C game/ archive --format='tar' 'HEAD' | bsdtar --extract --directory "${zipdir}/game"

bsdtar --auto-compress --create --file 'exam.zip' "${zipdir}"