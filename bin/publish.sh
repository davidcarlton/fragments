#!/bin/sh

set -e

if [ "$#" != "1" ]; then
  echo "Usage: publish.sh ITEM_NAME"
  exit 1
fi

# fragments/name-of-fragment or mosaics/name-of-mosaic
ITEM_NAME=$1

cd $(dirname $0)/..
# FIXME (2011-11-05, carlton): Make this parameterizable.
SOURCE_DIR=${PWD}

if [ ! -e "${SOURCE_DIR}/${ITEM_NAME}" ]; then
  echo "Item ${ITEM_NAME} does not exist."
  exit 1
fi

date -u "+%Y-%m-%dT%H:%M:%SZ" > ${SOURCE_DIR}/published/${ITEM_NAME}
