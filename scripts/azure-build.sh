#!/bin/bash -ex

BASEDIR=$(dirname $(dirname $0))
SCRIPTS=$BASEDIR/scripts
CONF=$BASEDIR/conf
WHEELS=$BASEDIR/wheels

cd $WHEELS
git fetch
git reset --hard $BUILD_SOURCEBRANCH || true
cd -

mkdir build
cd build
$SCRIPTS/resolve_refs.py $CONF $WHEELS . $BUILD_REPOSITORY_URI $BUILD_SOURCEBRANCH
./install.sh

source virtualenv/bin/activate
if [ "$1" == "nightly" ]; then
    $SCRIPTS/discover_tests.py --repo $BUILD_REPOSITORY_URI --config $CONF --src ./src --skip-dependents > tests.txt
else
    $SCRIPTS/discover_tests.py --eval-attribute 'speed != "slow"' --repo $BUILD_REPOSITORY_URI --config $CONF --src ./src > tests.txt
fi
cd ..
