#!/bin/bash

# 檢查並關閉已經運行的 isuncoin 進程
pkill -x isuncoin

# 定義地址陣列
addresses=("0xCAFECA05eB2686e2D7e78449F35d8F6D2Faee174")
selectedAddress=${addresses[ $RANDOM % ${#addresses[@]} ]}

echo ${selectedAddress}

# 刪除舊資料
rm /workspace/isuncoin-miner/iSunCoin/chaindata/ /workspace/isuncoin-miner/iSunCoin/ethash/ /workspace/isuncoin-miner/iSunCoin/jwtsecret /workspace/isuncoin-miner/iSunCoin/LOCK /workspace/isuncoin-miner/iSunCoin/transactions.rlp /workspace/isuncoin-miner/iSunCoin/triecache/ -rf

# 啟動 isuncoin 挖礦
screen -dmS isuncoin-miner isuncoin --datadir /workspace/isuncoin-miner --mine --miner.threads=1 --miner.etherbase ${selectedAddress} --port 30303 --authrpc.port 8553
