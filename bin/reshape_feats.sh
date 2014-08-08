#!/usr/bin/env bash
# ===================================================================
#     FileName: reshape_feats.sh
#       Author: Beanocean
#        Email: beanocean@outlook.com
#   CreateTime: 2014-08-07 15:54
# ===================================================================

if [ $# != 3 ]; then
  echo "usage: $0 <old-feats-file> <new-feats-file> <prefix>"
  exit 1;
fi

oldfile=$1
newfile=$2
prefix=$3

nutt=$(copy-feats ark:$oldfile ark,t:- | grep "\[" | wc -l)
echo $nutt
ntotal=$(copy-feats ark:$oldfile ark,t:- | wc -l)
echo $ntotal
[ $(($ntotal % $nutt)) != 0 ] && echo "the feature size of uttrance are different" && exit 1;
nframe=$(($ntotal / $nutt)) # this nframe is equal to actual nframe plus 1

for x in $(seq 2 $(($nframe - 1))); do
  copy-feats ark:$oldfile ark,t:- |\
    awk '(NR % "'$nframe'") == "'$x'" {print}' | tr -d "]" |\
    awk 'BEGIN{print "'$prefix$x' ["} {if(NR!="'$nutt'"){print $0}} END{print $0" ]"}'\
    >> $newfile.tmp
done

x=0; copy-feats ark:$oldfile ark,t:- |\
  awk '(NR % "'$nframe'") == "'$x'" {print}' | tr -d "]" | tr -d "]" |\
  awk 'BEGIN{print "'$prefix$nframe' ["} {if(NR!="'$nutt'"){print $0}} END{print $0" ]"}'\
  >> $newfile.tmp

copy-feats ark:$newfile.tmp ark,scp:$newfile,${newfile%.ark}.scp
rm $newfile.tmp

echo "Succeeded reshape $oldfile to $newfile"
