. ./path.sh
. ./cmd.sh

prefix=$1
featue_transform=$1/dnn4_pretrain-dbn_dnn/final.feature_transform
final_net=$1/dnn4_pretrain-dbn_dnn/final.nnet
data=$2/data/train/feats.scp
test_data=$2/data/test/feats.scp
#nnet-forward --use-gpu=yes $feature_transform $final_net scp:$data ark,t:feats.txt

nnet-forward --use-gpu=yes $feature_transform $final_net scp:$test_data ark,t:test_feats.txt

