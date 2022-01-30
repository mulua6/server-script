 #!/bin/bash
 wget https://download.redis.io/releases/redis-6.2.6.tar.gz
 tar -zxvf redis-6.2.6.tar.gz
 
 cd redis-6.2.6
 make
 make install
 
 
 firewall-cmd --zone=public --add-port=6009/tcp --permanent
firewall-cmd --reload

 
 echo "install success"
 mkdir /etc/redis
 cp ./redis.conf /etc/redis/redis.conf
 echo “conf file path：/etc/redis.conf”
 echo "please set port 6009"
 
 cat > /usr/lib/systemd/system/redis.service <<-EOF
[Unit]
Description=Redis 6009
After=syslog.target network.target
[Service]
Type=forking
PrivateTmp=yes
Restart=always
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli -h 127.0.0.1 -p 6009 -a Lankao-ep123qwe shutdown
User=root
Group=root
LimitCORE=infinity
LimitNOFILE=100000
LimitNPROC=100000
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload #重新加载服务配置
systemctl enable redis  #设置开机自启动
systemctl start redis   #启动redis服务
systemctl status redis #查看redis状态