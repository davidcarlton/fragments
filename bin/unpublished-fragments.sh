#!/bin/bash

set -e

cd $(dirname $0)/..

ls published/fragments > /tmp/published-fragments
ls fragments > /tmp/all-fragments

diff -u /tmp/{published,all}-fragments | grep ^+ | sed 's/\+//'