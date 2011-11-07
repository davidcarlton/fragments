#!/bin/sh

set -e

if [ "$#" != "2" ]; then
  echo "Usage: publish.sh LOCATION ITEM_NAME"
  exit 1
fi

LOCATION=$1

# People can pass in either item_name or location/item_name.
ITEM_NAME=$(basename $2)

cd $(dirname $0)/..
# FIXME (2011-11-05, carlton): Make this parameterizable.
SOURCE_DIR=${PWD}
mkdir -p ${SOURCE_DIR}/published/${LOCATION}

if [ ! -e "${SOURCE_DIR}/${LOCATION}/${ITEM_NAME}" ]; then
  echo "Item ${ITEM_NAME} does not exist."
  exit 1
fi

# This is the format that the atom standard recommends.
date -u "+%Y-%m-%dT%H:%M:%SZ" > ${SOURCE_DIR}/published/${LOCATION}/${ITEM_NAME}
