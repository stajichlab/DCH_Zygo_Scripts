#!/bin/bash -l 

grep "Burkholderia" logs/checkM.4294967294.log > binpull.tmp
while read i
do
	file=$(echo $i | awk -F " " '{ print $1 }')
	cp checkm_out/bins/$file/genes.faa checkm_out/burkholderia_bins/${file}.faa
	echo "moved $file"
done <binpull.tmp
#file=$(awk -F " " '{ print $1 }' binpull.tmp)
#echo "cp checkm_out/bins/$file/genes.faa checkm_out/burkholderia_bins/${file}.faa"
	
