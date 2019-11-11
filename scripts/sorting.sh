#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=00:15:00
#SBATCH -p short

for i in Counts/*.counts
do
	b=$(basename $i .counts)
	
	awk -F ';' '{print $2}' $i | sort | uniq -c > Counts/$b.unique_sorted
done

awk '{print $0, FILENAME}' Counts/*.unique_sorted > counts_unique_bacteria.temp.out

sed 's/Candidatus /Candidatus_/' counts_unique_bacteria.temp.out > counts_unique_bacteria.out 

