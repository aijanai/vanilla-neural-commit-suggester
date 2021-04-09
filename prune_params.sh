#!/bin/bash

if [[ $# -lt 1 ]]; then
	echo "Usage: $0 <model dir>"
	exit 1
fi

MODEL_DIR=$1
BEST_PARAMS_LINK="$MODEL_DIR/params.best"
if [[ ! -e $BEST_PARAMS_LINK ]]; then
	echo "No $BEST_PARAMS_LINK"
	exit 0
fi

BEST_PARAMS_FILE=$(ls -l $BEST_PARAMS_LINK | awk 'BEGIN{FS="->"}{print $2}'|xargs)

echo "Will keep $BEST_PARAMS_FILE"

find $MODEL_DIR -type f -name "params.*" -not -name $BEST_PARAMS_FILE -delete
