#!/bin/bash

. ./cmd.sh
[ -f path.sh ] && . ./path.sh
set -e

if [ ! $# -eq 1 ]; then
	echo "USAGE: $0 <prefix_name> <feat-type>"
	echo "feat-types: mfcc, spectralband, fmcp"
	exit 1
fi

prefix=$1
feats=$2

mkdir -p $prefix
cp -r data $prefix/data

for x in train test; do 
	steps/make_${feats}.sh --cmd "$train_cmd" --nj 10 $prefix/data/$x $prefix/exp/$feats/$x $prefix/$feats
done

#local/run_dnn_new.sh $prefix
