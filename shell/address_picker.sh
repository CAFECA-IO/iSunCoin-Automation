#!/bin/bash

# 定義地址陣列
addresses=("0xCAFECA05eB2686e2D7e78449F35d8F6D2Faee174")
selectedAddress=${addresses[ $RANDOM % ${#addresses[@]} ]}

export selectedAddress