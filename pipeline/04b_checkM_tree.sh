#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem=200G
#SBATCH --time=2:00:00     # 2 Hours
#SBATCH --job-name="checkm_tree"
#SBATCH -p short # This is the default partition, you can use any of the following; intel, batch, highmem, gpu
#SBATCH --out logs/checkm_tree.log


source ~/.condarc
conda activate checkM

INDIR=checkm_out/burkholderia_bins
OUTPUT=checkm_out/burkholderia_bins/checkm_tree_out2

mkdir -p $OUTPUT

checkm tree -t 4 -g -x faa $INDIR $OUTPUT


