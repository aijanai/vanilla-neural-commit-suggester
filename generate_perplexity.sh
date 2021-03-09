#!/bin/bash
grep ppl= -r $1 |awk '{print $2,$3,$NF}'|sed -r 's/[a-zA-Z]{1,3}=//g' > perplexity
