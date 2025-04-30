#!/bin/bash

# 取得當前路徑
REPO_PATH=$(pwd)

# 取得當前日期和時間，格式為 YYYY-MM-DD_HH-MM-SS
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# 提交的訊息
COMMIT_MESSAGE="Update at $CURRENT_DATE"

# 讀取 GitHub 帳號和個人存取令牌
. "/home/atmmc/github/.github_credentials"

# 將檔案新增到 Git
git add .

# 提交更改
git commit -m "$COMMIT_MESSAGE"

echo  # 換行

# 使用輸入的帳號和密碼進行身份驗證
GIT_URL="https://$USERNAME:$TOKEN@github.com/CAI-HaoCheng/minecraft_server_ATM10.git"

# 推送到 GitHub
git push "$GIT_URL" main

# 完成提示
echo "Files uploaded to GitHub."