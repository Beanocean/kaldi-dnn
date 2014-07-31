#!/bin/bash

# Copyright 2012-2014  Brno University of Technology (Author: Karel Vesely)
# Apache 2.0

# This example script trains a DNN on top of fMLLR features. 
# The training is done in 3 stages,
#
# 1) RBM pre-training:
#    in this unsupervised stage we train stack of RBMs, 
#    a good starting point for frame cross-entropy trainig.
# 2) frame cross-entropy training:
#    the objective is to classify frames to correct pdfs.
# 3) sequence-training optimizing sMBR: 
#    the objective is to emphasize state-sequences with better 
#    frame accuracy w.r.t. reference alignment.

. ./cmd.sh ## You'll want to change cmd.sh to something that will work on your system.
           ## This relates to the queue.

. ./path.sh ## Source the tools/utils (import the queue.pl)

# Config:
prefix=$1
data_feats=$prefix/data
stage=0 # resume training with --stage=N
# End of config.
. utils/parse_options.sh || exit 1;
#

# Stage 0: split train set into train and cross validation sets
if [ $stage -le 0 ]; then
  # split the data : 90% train 10% cross-validation (held-out)
  dir=$data_feats/train
  utils/subset_data_dir_tr_cv.sh $dir ${dir}_tr90 ${dir}_cv10 || exit 1
fi

# Stage 1: pre-train DBN
if [ $stage -le 1 ]; then
  # Pre-train DBN, i.e. a stack of RBMs (small database, smaller DNN)
  dir=$prefix/exp/dnn4_pretrain-dbn
  (tail --pid=$$ -F $dir/log/pretrain_dbn.log 2>/dev/null)& # forward log
  $cuda_cmd $dir/log/pretrain_dbn.log \
    steps/nnet/pretrain_dbn.sh --hid-dim 1024 --rbm-iter 20 $data_feats/train $dir || exit 1;
fi

# Stage 2: train DNN
if [ $stage -le 2 ]; then
  # Train the DNN optimizing per-frame cross-entropy.
  dir=$prefix/exp/dnn4_pretrain-dbn_dnn
  labels=$data_feats/train/label.pdf  # label.pdf should be made by yourself -- by Beanocean
  feature_transform=$prefix/exp/dnn4_pretrain-dbn/final.feature_transform
  dbn=$prefix/exp/dnn4_pretrain-dbn/6.dbn
  (tail --pid=$$ -F $dir/log/train_nnet.log 2>/dev/null)& # forward log
  # Train
  $cuda_cmd $dir/log/train_nnet.log \
    steps/nnet/train.sh --feature-transform $feature_transform --dbn $dbn --hid-layers 0 --learn-rate 0.008 \
    $data_feats/train_tr90 $data_feats/train_cv10 $labels $dir || exit 1;
fi

echo Success
exit 0
