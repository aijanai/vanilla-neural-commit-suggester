#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Usage: $0 <input file with translations> <reference>"
	exit 1
fi

./multi-bleu.perl $2 < $1
sacrebleu --input $1 $2  --metrics bleu --force
rouge -f $2 $1 --avg
