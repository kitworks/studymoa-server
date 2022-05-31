#!/bin/bash
pwd >> /home/ubuntu/test.txt
pwd
WORKDIR=/home/ubuntu/studymoa-server
cd $WORKDIR
bash ./entrypoint.sh