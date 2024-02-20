#!/bin/bash
set -eux

url='https://teaching.cs.york.ac.uk/student/2023-4/submit/COM00019I/001/A'
username='jm3017'
zip_file='exam.zip'

./zip.sh "${zip_file}"
ls -lh "${zip_file}"
md5sum "${zip_file}"

uoy-assessment-uploader --username "${username}" --submit-url "${url}" --file "${zip_file}"
