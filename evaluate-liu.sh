#!/bin/bash

if [[ $# -lt 1 ]]; then
echo "Usage: $0 <input file with translations>"
exit 1
fi

sacrebleu --input $1 liu-dataset/cleaned.test.msg  --metrics bleu --force
rouge -f liu-dataset/cleaned.test.msg $1 --avg
