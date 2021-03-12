#!/bin/bash
if [[ $# -lt 1 ]]; then
echo "Usage: $0 <training log file>"
exit 1
fi

grep ppl= -r $1 |awk '{print $2,$3,$NF}'|sed -r 's/[a-zA-Z]{1,3}=//g' > perplexity
