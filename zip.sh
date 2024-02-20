#!/bin/bash
set -eux

zipdir='exam'
zip_file="${1:-exam.zip}"

# create folder for submission
rm -rf "${zipdir}"
mkdir -p "${zipdir}"

# update submodules
git submodule foreach git pull

# copy url file
cp url1.txt "${zipdir}"

# copy pdfs
cp eng1team28.github.io/pdf/* "${zipdir}/"

# copy source code
# checked-in files only using git archive
mkdir -p "${zipdir}/game/"
git -C game/ archive --format='tar' 'HEAD' | bsdtar --extract --directory "${zipdir}/game"

# get executable jar
# todo enable
# wget --directory-prefix="${zipdir}" 'https://github.com/eng1team28/game/releases/download/latest/HeslingtonHustle.jar'

# create submission zip
bsdtar --auto-compress --create --file "${zip_file}" --directory "${zipdir}" ./
