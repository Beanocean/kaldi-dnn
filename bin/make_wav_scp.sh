#!/usr/bin/env bash
# ===================================================================
#     FileName: make_wav_scp.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-07 15:02
# ===================================================================

if [ ! $# -eq 1 ]; then
  echo "usage: $0 <wav_file_dir>"
  echo "eg: "
  echo "  $0 /media/tiger/data/splited/Pandora2000/train"
  exit 1
fi

inpath=$1

cd $inpath
for x in `ls ./`; do
  for y in `ls ./$x`; do
    echo -e ${y%.wav}"\t""sph2pipe -f wav $PWD/$x/$y |"
  done
done
