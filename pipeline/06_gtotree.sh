#!/bin/bash -l 
#SBATCH --out logs/gtotree.log --partition short --mem=10gb --ntasks 8 -N 1

source activate gtotree
