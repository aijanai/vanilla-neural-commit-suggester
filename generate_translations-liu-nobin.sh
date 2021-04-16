#!/bin/bash

if [[ $# -lt 1 ]]; then
echo "Usage: $0 <model dir>"
exit 1
fi

python3 -m sockeye.translate --models $1 --input liu-dataset-nobin/cleaned.test.diff --output out.$1
