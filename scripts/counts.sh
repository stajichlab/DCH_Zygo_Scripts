#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=00:15:00 
#SBATCH -p short
#create file with all reads from bacteria, with NA's filtered out

mkdir Counts/

for i in tax/*.out
do
	b=$(basename $i .out)
	grep -v "NA; NA;" $i > Counts/$b.counts
	c=$(wc -l Counts/$b.counts | awk '{print $1}')
	echo -e $b"\t"$c >> countsfile.out 

done

for i in Counts/*.counts
do
        b=$(basename $i .counts)
        
        awk -F ';' '{print $2}' $i | sort | uniq -c > Counts/$b.unique_sorted
done

awk '{print $0, FILENAME}' Counts/*.unique_sorted > counts_unique_bacteria.out

