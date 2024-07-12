#!/bin/bash

addresses=("0xCAFECA05eB2686e2D7e78449F35d8F6D2Faee174")
selectedAddress=${addresses[ $RANDOM % ${#addresses[@]} ]}
isuncoin --datadir /workspace/isuncoin-miner/ attach <<< "miner.setEtherbase(\"$selectedAddress\")"
