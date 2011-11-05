#!/bin/sh

set -e

if [ "$#" != "1" ]; then
  echo "Usage: publish-fragment.sh FRAGMENT_NAME"
  exit 1
fi

# People can pass in either fragment_name or fragments/fragment_name.
FRAGMENT_NAME=$(basename $1)

cd $(dirname $0)/..
# FIXME (2011-11-05, carlton): Make this parameterizable.
SOURCE_DIR=${PWD}
mkdir -p ${SOURCE_DIR}/published

if [ ! -e "${SOURCE_DIR}/fragments/${FRAGMENT_NAME}" ]; then
  echo "Fragment ${FRAGMENT_NAME} does not exist."
  exit 1
fi

# This is the format that the atom standard recommends.
date -u "+%Y-%m-%dT%H:%M:%SZ" > ${SOURCE_DIR}/published/${FRAGMENT_NAME}
