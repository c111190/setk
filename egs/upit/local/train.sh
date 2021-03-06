#!/usr/bin/env bash
# wujian@2019

set -eu

epochs=80
# smaller batch-size brings better performance
batch_size=16
cache_size=8
data_dir=$PWD/data/2spk

echo "$0 $@"

. ./path.sh
. ./utils/parse_options.sh || exit 1


[ $# -ne 2 ] && echo "Script format error: $0 <exp-id> <gpu-id>" && exit 1

# modifiy to PATH of SETK
export PATH=$PWD/../../bin:$PATH

exp_id=$1
gpu_id=$2

exp=$(basename $data_dir)
./nnet/train.py \
  --gpu $gpu_id \
  --checkpoint exp/$exp/$exp_id \
  --batch-size $batch_size \
  --cache-size $cache_size \
  --epochs $epochs \
  > $exp.$exp_id.train.log 2>&1
