#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00     # 1 day and 15 minutes
#SBATCH --out logs/checkmTest.%a.log
#SBATCH -p short # This is the default partition, you can use any of the following; intel, batch, highmem, gpu
source ~/.bashrc
conda activate checkM

checkm test ./checkm_test_results
