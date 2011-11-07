#!/bin/sh

set -e

if [ "$#" != "1" ]; then
  echo "Usage: publish-mosaic.sh MOSAIC_NAME"
  exit 1
fi

cd $(dirname $0)/..
bin/publish.sh mosaics $1
