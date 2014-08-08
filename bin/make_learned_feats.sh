#!/usr/bin/env bash
# ===================================================================
#     FileName: make_learned_feats.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-08 15:12
# ===================================================================

if [ ! $# -eq 2 ]; then
  echo "usage: $0 <dnn-path> <data-path>"
  echo "eg: "
  echo "  $0 results/exp/dnn4_pretrain-dbn_dnn results/data"
fi

featue_transform=$1/final.feature_transform
final_net=$1/final.nnet
train_data=$2/train/feats.scp
test_data=$2/test/feats.scp

nnet-forward --use-gpu=yes $feature_transform $final_net scp:$train_data ark,t:$2/lnd_train.feats
nnet-forward --use-gpu=yes $feature_transform $final_net scp:$test_data ark,t:$2/lnd_test.feats
