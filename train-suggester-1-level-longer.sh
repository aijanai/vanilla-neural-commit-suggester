#!/bin/bash

rm -fr sockeye-commit-suggester-transformer-ablation-$i
python3 -m sockeye.train \
  --batch-size 32 \
  --batch-type sentence \
  --device-ids 1 2 \
  --checkpoint-interval 3000 \
  --decode-and-evaluate 100 \
  --decoder ssru_transformer \
  --embed-dropout 0.2 \
  --initial-learning-rate 0.0001 \
  --keep-last-params 2 \
  --learning-rate-reduce-factor 0.7 \
  --learning-rate-reduce-num-not-improved 2 \
  --encoder transformer \
  --max-num-checkpoint-not-improved 4 \
  --max-seq-len 500 \
  --optimized-metric bleu \
  --optimizer adam \
  --num-embed 512:512 \
  --num-layers 1:1 \
  --source train.26208.diff \
  --target train.26208.msg \
  --output sockeye-commit-suggester-transformer-ablation-monolevel \
  --validation-source test.3000.diff \
  --validation-target test.3000.msg
