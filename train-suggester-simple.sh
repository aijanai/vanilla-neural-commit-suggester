#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Usage: $0 <model dir> <training prefix> <validation prefix>"
	exit 1
fi

python3 -m sockeye.train \
  --batch-size 48 \
  --batch-type sentence \
  --device-ids 1 2 3 \
  --checkpoint-interval 3000 \
  --decode-and-evaluate 100 \
  --decoder transformer \
  --embed-dropout 0.1 \
  --initial-learning-rate 0.0002 \
  --learning-rate-warmup 4000 \
  --keep-last-params 0 \
  --learning-rate-reduce-factor 0.7 \
  --learning-rate-reduce-num-not-improved 2 \
  --encoder transformer \
  --max-num-checkpoint-not-improved 4 \
  --max-seq-len 500 \
  --optimized-metric bleu \
  --cache-metric bleu \
  --optimizer adam \
  --num-embed 512:512 \
  --num-layers 2:2 \
  --transformer-attention-heads 16:16 \
  --source $2.diff \
  --target $2.msg \
  --output $1 \
  --validation-source $3.diff \
  --validation-target $3.msg
#  --use-cpu \
