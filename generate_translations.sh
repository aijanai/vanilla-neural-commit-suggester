#!/bin/bash

if [[ $# -lt 1 ]]; then
echo "Usage: $0 <model dir>"
exit 1
fi

python3 -m sockeye.translate --models $1 --input test.3000.diff --output out.$1
