#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:15:00     # 1 day and 15 minutes
#SBATCH --output=cat.out
#SBATCH --job-name="cat"
#SBATCH -p short

cat fungi_append_out/*.fasta > all_meta.fa

gzip all_meta.fa

echo "zipped"
