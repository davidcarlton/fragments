#!/bin/bash

set -e

cd $(dirname $0)/..
SCRIPTDIR=${PWD}
DESTDIR=/tmp/fragments
# FIXME (2011-11-05, carlton): Make this parameterizable.
SOURCEDIR=${SCRIPTDIR}

rm -rf ${DESTDIR}
mkdir ${DESTDIR}
mkdir ${DESTDIR}/css
cp css/*.css ${DESTDIR}/css
mkdir ${DESTDIR}/fragments

ruby -I ${SCRIPTDIR}/ruby -e "load 'local_publisher.rb'; LocalPublisher.new('${SOURCEDIR}', '${DESTDIR}').publish"