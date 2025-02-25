#!/bin/bash -ex

BASEDIR=$(dirname $(dirname $0))
SCRIPTS=$BASEDIR/scripts
CONF=$BASEDIR/conf

cd build

source virtualenv/bin/activate

python $SCRIPTS/lint.py
