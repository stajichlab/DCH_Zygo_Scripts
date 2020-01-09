#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=10:15:00     # 1 day and 15 minutes
#SBATCH --output=makedb_nr.out
#SBATCH --mail-user=dcart001@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="makedb_nr"
#SBATCH -p highmem

module load kaiju/1.7.2

mkdir kaijudb/
cd kaijudb/

kaiju-makedb -s nr -t 20

echo "done"

