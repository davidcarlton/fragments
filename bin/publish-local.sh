#!/bin/bash

set -e

cd $(dirname $0)/..
SCRIPTDIR=${PWD}
DESTDIR=/tmp/fragments

rm -rf ${DESTDIR}
mkdir ${DESTDIR}
mkdir ${DESTDIR}/css
cp css/*.css ${DESTDIR}/css
mkdir ${DESTDIR}/js
cp js/*.js ${DESTDIR}/js
mkdir ${DESTDIR}/fragments
mkdir ${DESTDIR}/mosaics
mkdir ${DESTDIR}/feeds

ruby -I ${SCRIPTDIR}/ruby -e "load 'local_publisher.rb'; LocalPublisher.new('${FRAGMENTS_TEXT}', '${DESTDIR}').publish"
