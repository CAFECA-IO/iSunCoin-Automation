#!/bin/bash
# 需安裝 jq
# 太久沒人挖礦才會啟動

# 取得最新區塊號碼的函數
get_latest_block_number() {
    block_number_hex=$(curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' https://isuncoin.baifa.io | jq -r '.result')
    block_number=$((16#${block_number_hex:2}))
    echo $block_number
}

# 取得區塊時間的函數
get_block_time() {
    block_number_hex=$(printf "0x%x" $1)
    block_time_hex=$(curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["'"$block_number_hex"'", false],"id":1}' https://isuncoin.baifa.io | jq -r '.result.timestamp')
    block_time=$((16#${block_time_hex:2}))
    echo $block_time
}

# 取得當前時間的秒數
current_time_seconds=$(date +%s)

# 取得最新區塊號碼
latest_block_number=$(get_latest_block_number)

# 取得最新區塊時間的秒數
latest_block_time=$(get_block_time $latest_block_number)

# 計算時間差（秒數）
time_difference=$((current_time_seconds - latest_block_time))

# 如果時間差超過 60 秒（1 分鐘），則執行 miner.sh
if [ $time_difference -gt 60 ]; then
    ./miner.sh
else
    echo "在 $time_difference 秒前正常出塊"
fi
