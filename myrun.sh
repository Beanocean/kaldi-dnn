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
stage=0

# how to use this shell scripts
if [ ! $# -eq  2 ]; then
  echo "USAGE: $0 <prefix_name> <feat-type>"
  echo "feat-types: mfcc, spectralband, spectrogram"
  exit 1
fi

prefix=../results/$1

# check feats type
feats=$2
if [ "$feats" != "mfcc" ] && [ "$feats" != "spectralband" ] \
  && [ "$feats" != "spectrogram" ]; then
  echo "feats-type must be one of: mfcc, spectralband, spectrogram" && exit 1
fi

# extract feature
if [ $stage -le 0 ]; then
  # make directories of current experiments
  [ -e $prefix ] && echo "remove old data in $prefix" && rm -r $prefix
  mkdir -p $prefix
  cp -r data $prefix/data

  for x in train test; do 
    steps/make_${feats}.sh --cmd "$train_cmd" --nj 10 $prefix/data/$x \
      $prefix/exp/$feats/$x $prefix/$feats
  done
fi

stage=2
if [ $stage -le 1 ]; then
  # reshape all feature and make label
  dir=$prefix/data/train
  # bin/cat_into_one.sh $dir/feats.scp $dir/allfeat.txt
  python bin/make_new_feats.py $dir/allfeat.txt $dir/newfeats.txt
fi

stage=3
if [ $stage -le 2 ]; then
  # train dnn
  local/run_dnn.sh $prefix
fi
