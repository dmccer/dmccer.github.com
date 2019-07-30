#!/bin/bash

set -euvo pipefail

PROJ=personal-site
OUT_DIR=${PWD}/deploy
mkdir -p $OUT_DIR

DEST_DIR=./dist
mkdir -p $DEST_DIR
rm -rf $DEST_DIR/*

cp ./index.html $DEST_DIR
cp -r ./res $DEST_DIR

TAR_NAME=personal-$(date +%Y-%m-%d)
tar -zcvf $OUT_DIR/$TAR_NAME.tar.gz $DEST_DIR

OPS_USER=root
IP=106.14.202.241
REMOTE_DIR=/home/admin/www

scp $OUT_DIR/$TAR_NAME.tar.gz $OPS_USER@$IP:$REMOTE_DIR/tars
ssh $OPS_USER@$IP /home/admin/deploy.sh $TAR_NAME $REMOTE_DIR $PROJ
