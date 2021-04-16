#!/bin/bash

for layers in $(seq 1 8); do
    for heads in 1 2 4 8 16 32 64 128; do
        MODEL_DIR=sockeye-commit-suggester-grid-layer-$layers-head-$heads
	
	rm -fr $MODEL_DIR

	echo "Next model: $MODEL_DIR"

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
          --num-layers $layers:$layers \
          --transformer-attention-heads $heads:$heads \
          --source train.26208.diff \
          --target train.26208.msg \
          --output $MODEL_DIR \
          --validation-source test.3000.diff \
          --validation-target test.3000.msg

	OUTCOME=$?
	if [[ $OUTCOME -ne 0 ]]; then
	    echo "ERROR WITH $MODEL"
	else
	    echo "Pruning model"
	    ./prune_params $MODEL_DIR

	fi
