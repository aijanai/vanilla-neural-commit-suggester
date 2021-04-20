#!/bin/bash
echo "layer,head,bleu,rouge-1,rouge-2,rouge-l"
ls results/out.sockeye-commit-suggester-grid*|grep -v .log|sort -V|while read i; do
	echo -n $i |sed 's/results\/out.sockeye-commit-suggester-grid-layer-//g'|sed 's/-head-/,/g';
	echo -n ",";
	if [[ -s $i ]]; then
		./multi-bleu.perl test.3000.msg < $i|cut -f 1 -d, |sed 's/BLEU = //g' | tr -d "\n"  2>/dev/null;
		echo -n ",";
		rouge -f test.3000.msg $i --avg|jq -r '[."rouge-1".f, ."rouge-2".f, ."rouge-l".f] | @csv' 2>/dev/null;
	else
		echo 0,0,0,0
	fi
done

