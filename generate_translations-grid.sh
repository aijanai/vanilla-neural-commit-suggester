#!/bin/bash

for layers in $(seq 1 8); do
    for heads in 1 2 4 8 16 32 64 128; do
        MODEL_DIR=sockeye-commit-suggester-grid-layer-$layers-head-$heads
	
	echo "Next model: $MODEL_DIR"

	python3 -m sockeye.translate --models $MODEL_DIR --input test.3000.diff --output out.$MODEL_DIR
    done
done
