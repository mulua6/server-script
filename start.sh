#!/bin/bash

serviceName=port=8290
pid=`ps -aux |grep $serviceName |grep -v "grep"| awk '{print $2}'`
echo $pid
kill -9 $pid

cd /home/htsoft/lankao-ep/
nohup java -jar -Dserver.port=8290  lankao-ep-1.0.jar  >/home/htsoft/lankao-ep/logs/nohup-8290.log  2>&1 &
echo 'tail -f /home/htsoft/logs/nohup-8290.log'
