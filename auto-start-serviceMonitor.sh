#!/bin/bash

# 用来把服务监控脚本添加为开机启动项，注意脚本路径

 cat > /usr/lib/systemd/system/jarMonitor.service <<-EOF
[Unit]
Description=serviceMonitor
After=syslog.target network.target
[Service]
Type=forking
PrivateTmp=yes
Restart=always
ExecStart=/usr/bin/nohup /usr/bin/sh /home/htsoft/lankao-ep/jarMonitor.sh > /home/htsoft/logs/service.log 2>&1 &
ExecStop=
User=root
Group=root
LimitCORE=infinity
LimitNOFILE=100000
LimitNPROC=100000
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload #重新加载服务配置
systemctl enable jarMonitor  #设置开机自启动
systemctl start jarMonitor   #启动serviceMonitor服务
systemctl status jarMonitor #查看serviceMonitor状态