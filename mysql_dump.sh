#!/bin/bash

#保存备份个数，备份31天数据
number=31
#备份保存路径
backup_dir=/home/htdata/mysql_backup
#日期
dd=`date +%Y-%m-%d-%H-%M-%S`
#备份工具
tool=mysqldump
#用户名
username=root
#密码 存储在同目录keys文件中

#将要备份的数据库
database_name=lankao

#如果文件夹不存在则创建
if [ ! -d $backup_dir ]; 
then     
    mkdir -p $backup_dir; 
fi


# 在同目录常见文件keys(权限600) 内容如下
#[client]
#host=localhost
#user=root
#password=your_password

#如果是整库备份 把$database_name换成--all-databases
$tool  --defaults-extra-file=keys   -u $username  $database_name > $backup_dir/$database_name-$dd.sql

#写创建备份日志
echo "create $backup_dir/$database_name-$dd.dupm" >> $backup_dir/log.txt

#找出需要删除的备份
delfile=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | head -1`

#判断现在的备份数量是否大于$number
count=`ls -l -crt  $backup_dir/*.sql | awk '{print $9 }' | wc -l`

if [ $count -gt $number ]
then
  #删除最早生成的备份，只保留number数量的备份
  rm $delfile
  #写删除文件日志
  echo "delete $delfile" >> $backup_dir/log.txt
fi



#设置定时任务
#chmod +x mysql_dump.sh
#crontab -e
#30 4 * * * cd /home/htsoft/mysql_backup && /bin/sh mysql_dump.sh  >> /dev/null 2>&1
#每天早上6:30自动执行脚本进行数据库备份