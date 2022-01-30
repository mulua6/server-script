#!/bin/bash

cd web

rm -rf ./*

scp -r -P 15666 root@39.106.192.162:/htdata/git-project/lankao-ep/web/dist-dev/* .

