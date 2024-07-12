#!/bin/bash

# 取得當前目錄位置
BASEDIR=$(dirname "$0")

# 取得本地最新區塊號碼的函數
get_local_latest_block_number() {
    block_number=$(isuncoin --datadir /workspace/isuncoin-miner attach <<< "eth.blockNumber" | awk '/^[0-9]+$/{print $1}')
    echo $block_number
}

# 取得本地區塊 hash 的函數
get_local_block_hash() {
    block_number=$1
    block_hash=$(isuncoin --datadir /workspace/isuncoin-miner attach <<< "eth.getBlockByNumber($block_number).hash" | awk -F '"' '/^"0x/ {print $2}')
    echo $block_hash
}

# 取得區塊 hash 的函數
get_remote_block_hash() {
    block_number_hex=$(printf "0x%x" $1)
    block_hash=$(curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["'"$block_number_hex"'", false],"id":1}' $2 | jq -r '.result.hash')
    echo $block_hash
}

# 取得本地最新區塊號碼
local_latest_block_number=$(get_local_latest_block_number)

# 目標區塊
target_block_number=$((local_latest_block_number - 10))

# 檢查目標區塊號碼是否大於 0
if [ "$target_block_number" -gt 0 ]; then

    # 取得本地目標區塊的 hash
    local_block_hash=$(get_local_block_hash $target_block_number)

    # 取得遠端目標區塊的 hash
    remote_block_hash=$(get_remote_block_hash $target_block_number "https://isuncoin.baifa.io")

    # 比較本地和遠端的 blockhash
    echo "檢驗區塊: $target_block_number"
    echo "本地資料: $local_block_hash"
    echo "遠端資料: $remote_block_hash"
    if [ "$local_block_hash" != "$remote_block_hash" ]; then
        "$BASEDIR/keeper.sh"
    else
        echo "本地和遠端的區塊 blockhash 一致"
    fi
elif [ -z "$local_latest_block_number" ]; then
    echo "嘗試啟動同步"
    "$BASEDIR/keeper.sh"
else
    echo "區塊鏈尚在同步中"
fi
