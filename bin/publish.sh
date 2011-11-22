#!/bin/sh

set -e

if [ "$#" != "1" ]; then
  echo "Usage: publish.sh ITEM_NAME"
  exit 1
fi

# fragments/name-of-fragment or mosaics/name-of-mosaic
ITEM_NAME=$1

if [ ! -e "${FRAGMENTS_TEXT}/${ITEM_NAME}" ]; then
  echo "Item ${ITEM_NAME} does not exist."
  exit 1
fi

mkdir -p ${FRAGMENTS_TEXT}/published
date -u "+%Y-%m-%dT%H:%M:%SZ" > ${FRAGMENTS_TEXT}/published/${ITEM_NAME}
