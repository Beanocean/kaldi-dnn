#!/usr/bin/env bash
# ===================================================================
#     FileName: make_new_utt_spk.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-08 15:43
# ===================================================================

if [ ! $# -eq 1 ]; then
  echo "usage: $0 <scp-file>"
  exit 1
fi

scpfile=$1
dir=${scpfile%/*}
awk '{print $1"\t"$1}' $scpfile > $dir/utt2spk
cp $dir/utt2spk $dir/spk2utt
