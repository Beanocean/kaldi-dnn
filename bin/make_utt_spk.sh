#!/usr/bin/env bash
# ===================================================================
#     FileName: make_utt_spk.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-07 14:45
# ===================================================================

if [ ! $# -eq 1 ]; then
  echo "usage: $0 <wav.scp_path>"
  exit 1
fi

wavfile=$1
dir=${wavfile%/*}
awk '{print $1"\t"$1}' $wavfile > $dir/utt2spk
cp $dir/utt2spk $dir/spk2utt
