#!/bin/bash

python3 -m sockeye.translate --models $1 --input test.3000.diff --output out.$1
