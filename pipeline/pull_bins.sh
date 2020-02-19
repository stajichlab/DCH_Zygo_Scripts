#!/bin/bash -l 

for i in ./logs/checkM.*
do
	b=$(basename "$i" .log)
	b=$(grep "input" $i)
	echo -e "$b \n $(grep -A 10 "Bin Id" $i)" > binpull.tmp
	sed -i -e 's/input //g' binpull.tmp
	sed -i -e 's/.metaSPAdes.out\/Maxbin_out//g' binpull.tmp
	sed -i -e 's/metaSPAdes_out\///g' binpull.tmp
	file=$(sed -n '1p' binpull.tmp)
	echo $file
	bin=$(grep "o__Burkholderiales (UID4001)" binpull.tmp | cut -c 3-9)
	echo $bin
	cp checkm_out/${file::-1}.metaSPAdes.out/bins/$bin/genes.faa checkm_out/burkholderia_bins/${file::-1}.faa
	
done

