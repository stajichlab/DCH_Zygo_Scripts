#!/bin/bash -l

for i in kaiju_out/*.out
do
	b=$(basename "$i" .out)
	echo "$b $(grep -c -i "^C" $i) $(grep -c -i "^U" $i)" >> kaiju_counts_ratio.txt
	#grep -i "^C" $i > kaiju_out/$b.classified_counts.txt
	#grep -i "^U" $i > kaiju_out/$b.unclassified_counts.txt
	#wc -l kaiju_out/$b.classified_counts.txt >> omarscounts.txt
        #wc -l kaiju_out/$b.unclassified_counts.txt >> omarscounts.txt
done
