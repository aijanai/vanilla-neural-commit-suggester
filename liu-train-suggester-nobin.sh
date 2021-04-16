#!/bin/bash
rm -fr sockeye-commit-suggester-liu-nobin

python3 -m sockeye.train \
  --batch-size 36 \
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
  --transformer-attention-heads 8:8 \
  --source liu-dataset-nobin/cleaned.train.diff \
  --target liu-dataset-nobin/cleaned.train.msg \
  --output sockeye-commit-suggester-liu\
  --validation-source liu-dataset-nobin/cleaned.valid.diff \
  --validation-target liu-dataset-nobin/cleaned.valid.msg
#  --use-cpu \
