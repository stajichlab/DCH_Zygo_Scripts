#!/bin/bash -l

for i in kaiju_out/*fq.gz.ko
do
	b=$(basename "$i" .fq.gz.ko)
	grep -i "^C" $i > kaiju_out/$b.classified_counts.txt
	grep -i "^U" $i > kaiju_out/$b.unclassified_counts.txt
	wc -l kaiju_out/$b.classified_counts.txt >> omarscounts.txt
        wc -l kaiju_out/$b.unclassified_counts.txt >> omarscounts.txt
done
