#!/bin/bash -l 

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=200G
#SBATCH --time=02:00:00     # 1 day and 15 minutes
#SBATCH -p short

#Grabs total number of contigs assembled from SPAdes and MetaSPAdes

INPUT=maxbin2_out/SPAdes/*.fasta
OUTFILE=maxbin2_bin_data.txt

#Pulls Each node and its respective length into a text file

for i in $INPUT
do 
	b=$(basename "$i" .*.fasta)
	d=$(grep ">" $i | awk 'BEGIN {FS = "[_]"} {print $2, $4}' | sed "s/^/$b /g" | sed 's/$/ MB2/') 
	echo "$d" >> $OUTFILE
done
