#!/bin/bash

python3 -m sockeye.train \
  --batch-size 48 \
  --batch-type sentence \
  --device-ids 1 2 3 \
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
  --num-layers 8:8 \
  --transformer-attention-heads 32:32 \
  --source train.26208.diff \
  --target train.26208.msg \
  --output sockeye-commit-suggester-grid-layer-8-head-32 \
  --validation-source test.3000.diff \
  --validation-target test.3000.msg
#  --use-cpu \
