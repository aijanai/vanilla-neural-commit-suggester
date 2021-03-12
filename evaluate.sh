#!/bin/bash

if [[ $# -lt 1 ]]; then
echo "Usage: $0 <input file with translations>"
exit 1
fi

sacrebleu --input $1 test.3000.msg  --metrics bleu
rouge -f test.3000.msg $1--avg
