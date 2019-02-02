#!/bin/bash
grep perplexity= -r $1 |grep Epoch|awk '{print $NF}'|awk ' FS="=" {print $2}' > perplexity
