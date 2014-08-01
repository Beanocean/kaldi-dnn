#!/bin/bash
feats=$1

if [ ! -e $1 ]; then
  echo "feats.scp doesn't exist!"
  exit 1
fi

echo "Getting files' path ..." 
cut -d ' ' -f 2 $1 | cut -d : -f 1 | sort -u > tmp.file
tail -n 9 tmp.file > feats.file
head -n 1 tmp.file >> feats.file
rm tmp.file
echo "Got it!"

cat feats.file | while read line; do
  copy-feats ark:$line ark,t:-
done >> allfeats.txt
