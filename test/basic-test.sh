#!/bin/bash

cd $(dirname $0)/..
FRAGMENTS_DIR=${PWD}
TEST_DIR=${FRAGMENTS_DIR}/test
export FRAGMENTS_TEXT=${TEST_DIR}/basic-text

OUTPUT_DIR=/tmp/fragments-basic
rm -rf ${OUTPUT_DIR}
mkdir ${OUTPUT_DIR}

set -e

${FRAGMENTS_DIR}/bin/publish-local.sh
${FRAGMENTS_DIR}/bin/publish-apache.sh ${OUTPUT_DIR} http://base-url.org

diff -ur ${TEST_DIR}/basic-expected ${OUTPUT_DIR}
