#!/bin/bash

# 檢查並關閉已經運行的 isuncoin 進程
pkill -x isuncoin

# 定義地址陣列
addresses=("0xCAFECA05eB2686e2D7e78449F35d8F6D2Faee174")
selectedAddress=${addresses[ $RANDOM % ${#addresses[@]} ]}

echo ${selectedAddress}

# 刪除舊資料
rm /workspace/isuncoin-data/iSunCoin/chaindata/ /workspace/isuncoin-data/iSunCoin/ethash/ /workspace/isuncoin-data/iSunCoin/jwtsecret /workspace/isuncoin-data/iSunCoin/LOCK /workspace/isuncoin-data/iSunCoin/transactions.rlp /workspace/isuncoin-data/iSunCoin/triecache/ -rf

# 啟動 isuncoin 同步數據
screen -dmS isuncoin-datakeeper isuncoin --datadir /workspace/isuncoin-data --miner.etherbase $selectedAddress
