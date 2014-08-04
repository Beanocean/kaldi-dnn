#!/usr/bin/env bash
# ===================================================================
#     FileName: myrun.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-01 15:49
# ===================================================================

# environment configuration
. ./cmd.sh
[ -f path.sh ] && . ./path.sh
set -e

# how to use this shell scripts
if [ ! $# -eq  2 ]; then
  echo "USAGE: $0 <prefix_name> <feat-type>"
  echo "feat-types: mfcc, spectralband, spectrogram"
  exit 1
fi

prefix=results/$1

# check feats type
feats=$2
if [ "$feats" != "mfcc" ] && [ "$feats" != "spectralband" ] \
  && [ "$feats" != "spectrogram" ]; then
  echo "feats-type must be one of: mfcc, spectralband, spectrogram" && exit 1
fi

mkdir -p $prefix
rm -r $prefix/*
cp -r data $prefix/data

for x in train test; do 
  steps/make_${feats}.sh --cmd "$train_cmd" --nj 10 $prefix/data/$x \
    $prefix/exp/$feats/$x $prefix/$feats
done

# local/run_dnn.sh $prefix
