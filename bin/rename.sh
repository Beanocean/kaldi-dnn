#!/usr/bin/env bash
# ===================================================================
#     FileName: rename.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-07-10 09:35
# ===================================================================


for dir in `ls $1`; do
  prefix=1000
  mkdir -p $2/$dir
  for file in `ls $1/$dir`; do
    name=$2/$dir/$dir-$prefix.mp3
    # echo "cp $1/$dir/$file $name"
    cp $1/$dir/$file $name
    prefix=`expr $prefix + 1`
  done
done
