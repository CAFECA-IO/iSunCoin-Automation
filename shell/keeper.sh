#!/bin/bash

# 檢查並關閉已經運行的 isuncoin 進程
pkill -x isuncoin

# 定義地址陣列
addresses=("0xCAFECA05eB2686e2D7e78449F35d8F6D2Faee174")
selectedAddress=${addresses[ $RANDOM % ${#addresses[@]} ]}

echo ${selectedAddress}

# 刪除舊資料
rm /workspace/isuncoin-keeper/iSunCoin/chaindata/ /workspace/isuncoin-keeper/iSunCoin/ethash/ /workspace/isuncoin-keeper/iSunCoin/jwtsecret /workspace/isuncoin-keeper/iSunCoin/LOCK /workspace/isuncoin-keeper/iSunCoin/transactions.rlp /workspace/isuncoin-keeper/iSunCoin/triecache/ -rf

# 啟動 isuncoin 同步數據
screen -dmS isuncoin-keeper isuncoin --datadir /workspace/isuncoin-keeper --miner.etherbase $selectedAddress
