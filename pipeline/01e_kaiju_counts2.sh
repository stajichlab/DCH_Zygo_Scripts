#!/bin/bash -l 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=100G
#SBATCH --time=00:15:00     # 1 day and 15 minutes
#SBATCH --job-name="cleanup Tax out"
#SBATCH --out logs/cleanup.log
#SBATCH -p short # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

cut -f 1,8,9 all_tax.out > all_tax.small
gzip all_tax.out
gzip all_tax.small
