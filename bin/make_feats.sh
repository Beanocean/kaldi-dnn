#!/bin/bash
splice=$1
if [ -f feat.scp ]; then
	mv feats.scp feats.scp.old
fi
input=allfeats.txt
output_inter=splice.txt
output=new_feats.txt
feats_old=feats.scp.old
label=label.pdf

if [ ! -f $input ]; then
	cat_into_one.sh $feats_old 
fi
splice.py $input $output_inter $splice 
make_new_feats.py $output_inter $output
dir=$PWD
copy-feats ark:$output ark,scp:$dir/feats.ark,feats.scp

makeLabel.py $feats_old feats.scp $label

make_spk2utt.py feats.scp utt2spk

make_spk2utt.py feats.scp spk2utt
