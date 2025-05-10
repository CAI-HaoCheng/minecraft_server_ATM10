#!/bin/bash

# 取得當前路徑
REPO_PATH=$(pwd)

# 取得當前日期和時間，格式為 YYYY-MM-DD_HH-MM-SS
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# 提交的訊息
COMMIT_MESSAGE="Update at $CURRENT_DATE"

# 讀取 GitHub 帳號和個人存取令牌
. "/home/atmmc/github/.github_credentials"

# docker container名稱
CONTAINER_NAME="ATM10"

echo "正在停止 container: $CONTAINER_NAME"
docker stop "$CONTAINER_NAME"

if [ $? -ne 0 ]; then
    echo "停止 container 失敗，請確認名稱正確"
    exit 1
fi

# 當伺服器關閉就執行備份
while true; do
    # 查詢目前contaier狀態
    STATUS=$(docker inspect -f '{{.State.Status}}' "$CONTAINER_NAME" 2>/dev/null)

    if [[ "$STATUS" == "exited" || "$STATUS" == "dead" ]]; then
        echo "Container $CONTAINER_NAME 已關閉（狀態：$STATUS）"
        # 將檔案新增到 Git
        git add .

        # 提交更改
        git commit -m "$COMMIT_MESSAGE"

        echo # 換行

        # 使用輸入的帳號和密碼進行身份驗證
        GIT_URL="https://$USERNAME:$TOKEN@github.com/CAI-HaoCheng/minecraft_server_ATM10.git"

        # 推送到 GitHub
        git push "$GIT_URL" main

        # 完成提示
        echo "Files uploaded to GitHub."
        break
    else
        echo "Container $CONTAINER_NAME 尚未關閉（目前狀態：$STATUS）"
        echo "正在執行關閉ATM10"
    fi
    sleep 5 # 每 5 秒檢查一次
done