#!/bin/bash

# 設定目標目錄
target_dir="/home/atmmc/minecraft_server_ATM10/data/simplebackups"

# 以現在時間為基準，找出一天前的日期
one_day_ago=$(date -d "1 day ago" +"%Y-%m-%d")

# 在目標目錄中搜尋一天前的.zip檔案並刪除它們
sudo find "$target_dir" -name "*.zip" -type f -mtime +0 -exec rm {} \;
