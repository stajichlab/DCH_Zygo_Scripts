#!/bin/bash -l 

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=5G
#SBATCH --time=02:00:00     # 1 day and 15 minutes
#SBATCH -p short

#Grabs total number of contigs input assembler assembled

INPUT=unicycler_out/*.fasta
OUTFILE=uni_fasta_data.txt

#Pulls Each node and its respective length into a text file

for i in $INPUT
do 
	b=$(basename "Rhizopus_microsporus_NRRL_13129" .*.fasta)
	d=$(grep ">" $i | awk 'BEGIN {FS = " "} {print $1, $2}' | sed "s/^/$b /g" | sed 's/>//' | sed 's/length=//' |sed 's/$/ U/') 
	echo "$d" >> $OUTFILE
done


# grep ">" unicycler_out/assembly.fasta | awk 'BEGIN {FS = " "} {print $1, $2}' | sed "s/^/Rhizopus /g" | sed 's/>//' | sed 's/length=//'
