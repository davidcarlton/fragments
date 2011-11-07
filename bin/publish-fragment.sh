#!/bin/sh

set -e

if [ "$#" != "1" ]; then
  echo "Usage: publish-fragment.sh FRAGMENT_NAME"
  exit 1
fi

cd $(dirname $0)/..
bin/publish.sh fragments $1
