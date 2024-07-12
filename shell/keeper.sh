#!/bin/bash
# 只保存資料不參與挖礦

# 檢查並關閉已經運行的 isuncoin-keeper
screen -X -S isuncoin-keeper quit

# 刪除舊資料
rm /workspace/isuncoin-keeper/iSunCoin/chaindata/ /workspace/isuncoin-keeper/iSunCoin/ethash/ /workspace/isuncoin-keeper/iSunCoin/jwtsecret /workspace/isuncoin-keeper/iSunCoin/LOCK /workspace/isuncoin-keeper/iSunCoin/transactions.rlp /workspace/isuncoin-keeper/iSunCoin/triecache/ -rf

# 啟動 isuncoin 同步數據
screen -dmS isuncoin-keeper isuncoin --datadir /workspace/isuncoin-keeper --port 30303 --authrpc.port 8553
