#!/bin.bash

cd /etc/yum.repos.d/
mv CentOS-Base.repo CentOS-Base.repo_bak

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all
yum makecache
