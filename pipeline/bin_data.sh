#!/bin/bash -l

for i in maxbin2_out/*.summary
do
	#b=$(basename "$i" .summary)
	echo "$(grep "fasta" $i)" >> bin_complete.txt
done
