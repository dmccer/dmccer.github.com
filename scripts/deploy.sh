#!/bin/bash

set -euvo pipefail

OUT_DIR=${PWD}/deploy
mkdir -p $OUT_DIR

yarn build

TAR_NAME=$(date +%Y-%m-%d)
tar -zcvf $OUT_DIR/$TAR_NAME.tar.gz ./dist

OPS_USER=root
IP=106.14.202.241
REMOTE_DIR=/home/admin/www

scp $OUT_DIR/$TAR_NAME.tar.gz $OPS_USER@$IP:$REMOTE_DIR/tars
ssh $OPS_USER@$IP /home/admin/deploy.sh $TAR_NAME $REMOTE_DIR
