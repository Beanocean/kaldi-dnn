#!/bin/bash
featscp=$1
allfeats=$2

if [ ! -e $featscp ]; then
  echo "feats.scp doesn't exist!"
  exit 1
fi

echo "Getting featrue's path ..." 
cut -d ' ' -f 2 $featscp | cut -d : -f 1 | sort -u > tmp.file
echo "tmp.file is:" && cat tmp.file
# LC_ALL=C
head -n 1 tmp.file > feats.file
tail -n 8 tmp.file >> feats.file
head -n 2 tmp.file | tail -n 1 >> feats.file
rm tmp.file
echo "feats.file is:" && cat feats.file

cat feats.file | while read line; do
  copy-feats ark:$line ark,t:-
done >> $allfeats

rm feats.file
