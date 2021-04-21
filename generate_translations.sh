#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Usage: $0 <model dir> <reference>"
	exit 1
fi

python3 -m sockeye.translate --models $1 --input $2 --output out.$1
