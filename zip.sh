#!/bin/bash
set -eux

jar_name='HeslingtonHustle.jar'
zipdir='exam'
zip_file="${1:-exam.zip}"

# create folder for submission
rm -rf "${zipdir}"
mkdir -p "${zipdir}"

# copy url file
cp url1.txt "${zipdir}"

# get executable jar
wget \
    --directory-prefix="${zipdir}" \
    "https://github.com/eng1team28/game/releases/latest/download/${jar_name}"

# update submodules
git submodule foreach git pull

# copy pdfs
cp eng1team28.github.io/pdf/* "${zipdir}/"

# copy source code
# checked-in files only using git archive
mkdir -p "${zipdir}/game/"
git -C game/ archive --format='tar' 'HEAD' | bsdtar --extract --directory "${zipdir}/game"

# create submission zip
bsdtar --auto-compress --create --file "${zip_file}" --directory "${zipdir}" ./
