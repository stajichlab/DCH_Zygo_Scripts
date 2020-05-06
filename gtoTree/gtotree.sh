#!/bin/bash -l 
#SBATCH -p short --out gtotree_DC.log --mem=10gb -N 1 --cpus-per-task=8

module unload miniconda2
module load anaconda3
module unload perl 
source activate gtotree

GToTree -f fasta_files.txt -H Betaproteobacteria -j 8 -o autometa_binned_burk_5
#GToTree -A bacillus_aa_list.txt -f bacillus_fasta_files.txt -H Firmicutes -t -L Species,Strain -j 8 -o autometa_binned_baci
