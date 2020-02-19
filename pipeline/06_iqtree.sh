#!/bin/bash -l
#SBATCH --ntasks=16 --mem=100G -p batch --time=24:00:00 --out logs/iqtree_burks.log

module load IQ-TREE
#all bins
#iqtree -s checkm_out/burholderia_bins/storage/tree/concatenated.fasta -m MFP -nt AUTO -ntmax 16
#just burks
iqtree -s checkm_out/burkholderia_bins/checkm_tree_out2/storage/tree/concatenated.fasta -m MFP -nt AUTO -ntmax 16
