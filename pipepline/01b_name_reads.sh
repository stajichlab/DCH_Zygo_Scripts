#!/bin/bash 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=01:15:00
#SBATCH -p short
#SBATCH --job-name="rename"
for BASE in *.kaiju.out; do sed -e "s/^/^$BASE|/" $BASE > $BASE.rename; done
