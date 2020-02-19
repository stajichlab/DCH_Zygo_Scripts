#!/bin/bash -l
#SBATCH --ntasks=16 --mem=100G -p short --time=2:00:00 --out logs/fasttree.log

module load fasttree
#all bins
#iqtree -s checkm_out/burholderia_bins/storage/tree/concatenated.fasta -m MFP -nt AUTO -ntmax 16
#just burks
FastTreeMP checkm_out/autometa/storage/tree/concatenated.fasta > autometa_bins.tree
