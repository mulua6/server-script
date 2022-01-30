#!/bin/bash
LOG_FILE="autostart.log"

while [ 1 -lt 2 ];do
	
	curtime=$(date "+%Y-%m-%d %H:%M:%S")


	#检测nginx
	pnginx=`ps -ef | grep nginx | grep -v "grep" | wc -l`
	if [ $pnginx -eq 0 ]; then
			echo "$curtime 系统检测到nginx,已挂掉,启动中...." >> /home/htsoft/logs/autostart.log;
			systemctl start nginx #启动nginx命令
			echo "$curtime nginx启动完成" >> /home/htsoft/logs/autostart.log;
	else
			echo "$curtime 系统检测到nginx运行正常" >> /home/htsoft/logs/autostart.log;
	fi


	#检测服务
	serviceName='lankao-ep-1.0.jar'

	pservice=`ps -ef | grep $serviceName | grep -v "grep" | wc -l`
	if [ $pservice -eq 0 ]; then
			echo "$curtime 系统检测到java服务,已挂掉,启动中...." >> /home/htsoft/logs/autostart.log;
			#启动服务命令

			nohup sh /home/htsoft/lankao-ep/start.sh  > /home/htsoft/logs/auto-start-java-8290.log 2>&1 &


			echo "$curtime java服务启动完成" >> /home/htsoft/logs/autostart.log;
			#等待5分钟
			sleep 120
	else
			echo "$curtime 系统检测到java服务进程正常" >> /home/htsoft/logs/autostart.log;

			pjava=`curl -X POST http://localhost:8290/system/server/interfaceTest | grep 200 |wc -l`
			if [ $pjava -eq 0 ]; then
				echo "$curtime 系统检测到java服务,无法访问,重新启动中...." >> /home/htsoft/logs/autostart.log;


				pid=`ps -aux |grep $serviceName |grep -v "grep"| awk '{print $2}'`
				kill -9 $pid
				
				#启动服务命令
				nohup sh /home/htsoft/lankao-ep/start.sh > /home/htsoft/logs/auto-start-java-8290.log 2>&1 &


				#等待5分钟
				sleep 120
			else
				echo "$curtime 系统检测到java服务访问正常^_^" >> /home/htsoft/logs/autostart.log;
			fi
		
	fi

	#检测间隔1分钟
	sleep 60
done
