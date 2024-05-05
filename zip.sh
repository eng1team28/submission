#!/bin/bash
set -eux

jar_name='HeslingtonHustle.jar'
zipdir='exam'
zip_file="${1:-exam.zip}"

# create folder for submission
rm -rf "${zipdir}"
mkdir -p "${zipdir}"

# copy url file
cp url2.txt "${zipdir}"

# get executable jar
# skips download if there's no new release
# wget \
#     --timestamping \
#     "https://github.com/eng1team28/game2/releases/latest/download/${jar_name}"

# using gh instead allows downloading
# from a private repo
gh release download \
    --repo 'eng1team28/game2' \
    --pattern '*.jar' \
    --clobber

# copy jar to zip directory
cp "${jar_name}" "${zipdir}"

# update submodules
git submodule foreach git pull

# copy pdfs
cp eng1team28.github.io/pdf/*.pdf "${zipdir}/"

# copy source code
# checked-in files only using git archive
mkdir -p "${zipdir}/game/"
git -C 'game2/' archive --format='tar' 'HEAD' | bsdtar --extract --directory "${zipdir}/game2"

# create submission zip
bsdtar --auto-compress --create --file "${zip_file}" --directory "${zipdir}" ./
