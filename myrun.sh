#!/usr/bin/env bash
# ===================================================================
#     FileName: myrun.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-01 15:49
# ===================================================================

# Default configuration.
nj=10
stage=0

# Environment configuration
. ./cmd.sh
[ -f path.sh ] && . ./path.sh
. utils/parse_options.sh || exit 1;
set -e


# How to use this shell scripts
if [ ! $# -eq  2 ]; then
  echo "usage: $0 [options] <prefix_name> <feat-type>"
  echo "opthions: "
  echo "  --stage <stage>     # resume the script from certain stage."
  echo "feat-types: "
  echo "  mfcc, spectralband, spectrogram"
  exit 1
fi

prefix=../results/$1
feats=$2

# Check feature type
if [ "$feats" != "mfcc" ] && [ "$feats" != "spectralband" ] \
  && [ "$feats" != "spectrogram" ]; then
  echo "feats-type must be one of: mfcc, spectralband, spectrogram" && exit 1
fi

# Extract feature
if [ $stage -le 0 ]; then
  # make directories for current experiments
  # [ -e $prefix ] && echo "remove old data in $prefix" && rm -r $prefix
  mkdir -p $prefix
  cp -r data $prefix/

  # shuffle wav.scp
  mv $prefix/data/train/wav.scp $prefix/data/train/wav.scp.old
  shuf $prefix/data/train/wav.scp.old -o $prefix/data/train/wav.scp

  # prepare utt2spk & spk2utt, extract train & test data
  find $prefix/data/{train,test}/wav.scp > /dev/null
  [ $? -eq 1 ] && exit 1;

  for x in train test; do 
    # bin/make_utt_spk.sh $prefix/data/$x/wav.scp  # make utt2spk & spk2utt
    steps/make_${feats}.sh --cmd "$train_cmd" --nj $nj $prefix/data/$x \
      $prefix/exp/$feats/$x $prefix/$feats
  done
fi

# Reshape feature
if [ $stage -le 1 ]; then
  # reshape all feature
  dir=$prefix/$feats; cmd=run.pl; logdir=$prefix/exp/reshape_feature
  echo "cmd: "$cmd
  echo "logdir: "$logdir
  $cmd JOB=1:$nj $logdir/reshape_feature_train.JOB.log \
    bin/reshape_feats.sh $dir/raw_${feats}_train.JOB.ark \
    $dir/new_${feats}_train.JOB.ark utt-JOB
  # make label
  $cmd JOB=1:$nj $logdir/make_label_train.JOB.log \
    bin/make_utt_labels.py $dir/raw_${feats}_train.JOB.scp \
    $dir/new_${feats}_train.JOB.scp $dir/new_${feats}_train.JOB.labels
  # make label.pdf and new feats.scp
  mv $prefix/data/train/feats.scp $prefix/data/train/feats.scp.old
  rm $prefix/data/train/labes.pdf -f
  for i in $(seq $nj); do
    cat $dir/new_${feats}_train.${x}.scp >> $prefix/data/train/feats.scp
    cat $dir/new_${feats}_train.${x}.labels >> $prefix/data/train/label.pdf
  done
  # make new utt2spk spk2utt
  bin/make_new_utt_spk.sh $prefix/data/train/feats.scp
fi

stage=4
# Train dnn
if [ $stage -le 2 ]; then
  # pretrain & train
  local/run_dnn.sh $prefix
fi

# Generate learned-feature
if [ $stage -le 3 ]; then
  dir=$prefix/learned_feature
  mkdir $dir
  bin/make_learned_feats.sh $dir
fi

echo "finshed successfully!"
