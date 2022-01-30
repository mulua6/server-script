#!/bin/bash
docker exec -it gitlab2022 /bin/bash -c 'gitlab-rake gitlab:backup:create'

mv /htdata/docker/disk2022/gitlab/data/backups/*.tar /htdata/backup/tmp/

cp /htdata/docker/disk2022/gitlab/config/gitlab.rb /htdata/backup/tmp/
cp /htdata/docker/disk2022/gitlab/config/gitlab-secrets.json /htdata/backup/tmp/


cd /htdata/backup/tmp/


time=$(date "+%Y%m%d%H%M%S")

fileName=${time}_gitlab_13.1.4_backup.zip

zip $fileName ./*

cd ../
rm -rf ./*13.1.4_backup.zip

mv ./tmp/$fileName ./

rm -rf ./tmp/*

echo 'all done'
