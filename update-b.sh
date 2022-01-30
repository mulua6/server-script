#!/bin/bash

scp -r  -P 15666 root@39.106.192.162:/htdata/git-project/lankao-ep/service/target/lankao-ep-1.0.jar ./tmp-lankao-ep-1.0.jar

rm -rf lankao-ep-1.0.jar

mv tmp-lankao-ep-1.0.jar lankao-ep-1.0.jar
