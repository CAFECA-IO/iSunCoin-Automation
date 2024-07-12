#!/bin/bash

# 定義地址陣列
$BASEDIR/address_picker.sh

# 替換挖礦獎勵地址
isuncoin --datadir /workspace/isuncoin-miner/ attach <<< "miner.setEtherbase(\"$selectedAddress\")"
