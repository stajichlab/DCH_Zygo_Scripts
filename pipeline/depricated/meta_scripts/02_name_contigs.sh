#!/bin/bash
#BATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:15:00     # 1 day and 15 minutes
#SBATCH --output=contigs_rename.out
#SBATCH --mail-user=dcart001@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="contig_rename"
#SBATCH -p short

for file in fungi_append_out/*.fa*
do
 b=$(basename $file .fa)
 perl -i -p -e "s/>/>$b|/" $file 
done
