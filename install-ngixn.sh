#!/bin/bash

yum -y install gcc gcc-c++

yum -y install pcre pcre-devel

yum -y install zlib zlib-devel 
yum -y install openssl openssl-devel

wget https://nginx.org/download/nginx-1.20.2.tar.gz

tar -axvf nginx-1.20.2.tar.gz
cd nginx-1.20.2
./configure --prefix=/usr/local/nginx
make
make install


firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload

cat > /usr/lib/systemd/system/nginx.service <<-EOF
[Unit]
Description=nginx
After=network.target
  
[Service]
Type=forking
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/usr/local/nginx/sbin/nginx -s quit
PrivateTmp=true
  
[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload #重新加载服务配置
systemctl enable nginx  #设置开机自启动
systemctl start nginx   #启动nginx服务
systemctl status nginx #查看nginx状态