#!/bin/bash

# 取得當前目錄位置
BASEDIR=$(dirname "$0")

# 定義地址陣列
source "$BASEDIR/address_picker.sh"

# 替換挖礦獎勵地址
isuncoin --datadir /workspace/isuncoin-miner/ attach <<< "miner.setEtherbase(\"$selectedAddress\")"
