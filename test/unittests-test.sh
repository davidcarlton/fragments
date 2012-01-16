#!/bin/bash

cd $(dirname $0)/..
SCRIPT_DIR=${PWD}

ruby -I ${SCRIPT_DIR}/ruby -e "load 'test/test_all.rb'" > /dev/null
