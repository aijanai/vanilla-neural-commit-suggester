#!/bin/bash

for i in 16 32 ; do
	MODEL_DIR=sockeye-commit-suggester-transformer-head-ablation-$i
	#rm -fr $MODEL_DIR
	python3 -m sockeye.train \
	  --batch-size 64 \
	  --batch-type sentence \
	  --device-ids 0 1 2 3 \
	  --checkpoint-interval 3000 \
	  --decode-and-evaluate 100 \
	  --decoder ssru_transformer \
	  --embed-dropout 0.2 \
	  --initial-learning-rate 0.0001 \
	  --keep-last-params 0 \
	  --learning-rate-reduce-factor 0.7 \
	  --learning-rate-reduce-num-not-improved 2 \
	  --encoder transformer \
	  --max-num-checkpoint-not-improved 4 \
	  --max-seq-len 500 \
	  --optimized-metric bleu \
	  --optimizer adam \
	  --num-embed 512:512 \
	  --num-layers 1:1 \
	  --transformer-attention-heads $i:$i \
	  --source train.26208.diff \
	  --target train.26208.msg \
	  --output $MODEL_DIR \
	  --validation-source test.3000.diff \
	  --validation-target test.3000.msg
done
