#!/bin/bash

# 1. 进入指定目录
cd ~/code/sqls || exit

BACKUP_NAME="backup_$(date +%Y%m%d).sql"
mysqldump -h 127.0.0.1 -P 3307 -u root -ppasswd learn >"$BACKUP_NAME"

# 3. Git 提交并推送
git add "$BACKUP_NAME"
git commit -m "自动备份: $(date +'%Y-%m-%d %H:%M:%S')"
git push
