#!/usr/bin/env bash
# ===================================================================
#     FileName: make_labels.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-04 18:56
# ===================================================================

file=$1

while read line; do
  num=$(grep $line $file | wc -l)
  numlist="$numlist $num"
done < <(cut -d ' ' -f 1 $file | cut -d '-' -f 1 | sort -u)

# echo $numlist

i=0
for x in $numlist; do
  for j in $(seq $x); do
    row="$row $i"
    # echo $i
  done
  i=$((i + 1))
done

echo $row
