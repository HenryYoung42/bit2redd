#!/bin/bash
#
# Copyright (c) 2017-2018 The Reddcoin Fast developers
#
# This script converts a fresh fork of reddcoin 0.18.x into reddcoin-fast
#
# Credit to Ray Dillinger's article from the Bear's Den blog for inspiring and informing this approach:
#
#   http://dillingers.com/blog/2015/04/18/how-to-make-an-altcoin/
#

cd ~/reddcoin-fast

# Add new copyright notice in null, '#', 'dnl' and '//' comment delimited files

find . -type f -print0 | xargs -0 sed -i '/^Copyright.*Bitcoin Core developers/a Copyright (c) 2017-2019 The Reddcoin Fast developers'
find . -type f -print0 | xargs -0 sed -i '/^# Copyright.*Bitcoin Core developers/a # Copyright (c) 2017-2019 The Reddcoin Fast developers'
find . -type f -print0 | xargs -0 sed -i '/^dnl Copyright.*Bitcoin Core developers/a dnl Copyright (c) 2017-2019 The Reddcoin Fast developers'
find . -type f -print0 | xargs -0 sed -i '/^\/\/ Copyright.*Bitcoin Core developers/a \/\/ Copyright (c) 2017-2019 The Reddcoin Fast developers'

# Update except in copyright notices:
#
#   Reddcoin Fast -> Reddcoin Fast
#   Reddcoin -> Reddcoin
#   reddcoin -> reddcoin
#   REDDCOIN -> REDDCOIN

find . -type f -print0 | xargs -0 sed -i '/Copyright/!s/Bitcoin Core/Reddcoin Fast/g'
find . -type f -print0 | xargs -0 sed -i '/Copyright/!s/Bitcoin/Reddcoin/g'
find . -type f -print0 | xargs -0 sed -i '/Copyright/!s/bitcoin/reddcoin/g'
find . -type f -print0 | xargs -0 sed -i '/Copyright/!s/BITCOIN/REDDCOIN/g'

# Undo above changes in release notes

sed -i 's/Reddcoin Fast/Reddcoin Fast/g' doc/release-notes/*
sed -i 's/Reddcoin/Reddcoin/g' doc/release-notes/*
sed -i 's/reddcoin/reddcoin/g' doc/release-notes/*
sed -i 's/REDDCOIN/REDDCOIN/g' doc/release-notes/*

# Rename source files

find . -exec rename 's/Reddcoin/Reddcoin/' {} ";"
find . -exec rename 's/reddcoin/reddcoin/' {} ";"
find . -exec rename 's/REDDCOIN/REDDCOIN/' {} ";"

# Update currency symbol RDD -> RDD

find . -type f -print0 | xargs -0 sed -i 's/RDD/RDD/g'

### CHECK IF THIS NACKERS ANY TEST DATA : it probably does

# Zap seed node files /contrib/seeds/nodes_[main|test].txt & regen chainparamseeds.h

cd contrib/seeds
> nodes_main.txt
> nodes_test.txt
python3 generate-seeds.py . > ../../src/chainparamsseeds.h
cd - > /dev/null

# Update port numbers - rcp/testnet/mainnet

#find . -type f -print0 | xargs -0 sed -i 's/8332/45443/g'
#find . -type f -print0 | xargs -0 sed -i 's/18333/55444/g'
#find . -type f -print0 | xargs -0 sed -i 's/8333/45444/g'

#FIND A BETTER WAY TO DO THIS : also testnet3 -> testnet : also regtest - assign a notional port

# Update seed nodes in chainparams.cpp



