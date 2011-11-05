#!/bin/bash

set -e

if [ "$#" != "2" ]; then
  echo "Usage: publish-apache.sh OUTPUT_DIR BASE_URL"
fi

OUTPUT_DIR=$1
BASE_URL=$2

cd $(dirname $0)/..
SCRIPT_DIR=${PWD}
STAGING_DIR=/tmp/fragments-apache
# FIXME (2011-11-05, carlton): Make this parameterizable.
SOURCE_DIR=${SCRIPT_DIR}

rm -rf ${STAGING_DIR}
mkdir ${STAGING_DIR}
mkdir ${STAGING_DIR}/css
cp css/*.css ${STAGING_DIR}/css
cp config/dot.htaccess ${STAGING_DIR}/.htaccess
mkdir ${STAGING_DIR}/fragments
touch ${STAGING_DIR}/fragments/index.html

ruby -I ${SCRIPT_DIR}/ruby -e "load 'apache_publisher.rb'; ApachePublisher.new('${SOURCE_DIR}', '${STAGING_DIR}', '${BASE_URL}').publish"

mkdir -p ${OUTPUT_DIR}

# NOTE (2011-11-05, carlton): I'm tempted to stick in --delete,
# but that would be really dangerous if OUTPUT_DIR is wrong, and
# we won't be deleting stuff very often; so just blow away
# OUTPUT_DIR in that case.
rsync -rlpcv ${STAGING_DIR}/ ${OUTPUT_DIR}
