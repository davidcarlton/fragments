#!/bin/sh

set -e

if [ "$#" != "1" ]; then
  echo "Usage: preview.sh ITEM_NAME"
  exit 1
fi

ITEM_NAME=$1

cd $(dirname $0)/..

bin/publish-local.sh
open /tmp/fragments/${ITEM_NAME}.html
