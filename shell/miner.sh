#!/bin/bash

# 取得當前目錄位置
BASEDIR=$(dirname "$0")

# 檢查並關閉已經運行的 isuncoin-miner
screen -X -S isuncoin-miner quit

# 定義地址陣列
$BASEDIR/address_picker.sh

echo ${selectedAddress}

# 刪除舊資料
rm /workspace/isuncoin-miner/iSunCoin/chaindata/ /workspace/isuncoin-miner/iSunCoin/ethash/ /workspace/isuncoin-miner/iSunCoin/jwtsecret /workspace/isuncoin-miner/iSunCoin/LOCK /workspace/isuncoin-miner/iSunCoin/transactions.rlp /workspace/isuncoin-miner/iSunCoin/triecache/ -rf

# 啟動 isuncoin 挖礦
screen -dmS isuncoin-miner isuncoin --datadir /workspace/isuncoin-miner --mine --miner.threads=1 --miner.etherbase ${selectedAddress} --port 30303 --authrpc.port 8553
