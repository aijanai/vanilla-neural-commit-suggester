#!/bin/bash

python3 -m sockeye.train \
  --batch-size 64 \
  --batch-type sentence \
  --device-ids -2 \
  --checkpoint-interval 3000 \
  --decode-and-evaluate 100 \
  --decoder ssru_transformer \
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
  --num-layers 6:6 \
  --transformer-attention-heads 8:8 \
  --source train.26208.diff \
  --target train.26208.msg \
  --output sockeye-commit-suggester \
  --validation-source test.3000.diff \
  --validation-target test.3000.msg
#  --use-cpu \
