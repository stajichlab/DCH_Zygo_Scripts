#!/bin/bash -l 
#SBATCH -N 1 -n 8 --mem=16G --out logs/QUAST.%a.log --time=2:00:00 -p short

N=${SLURM_ARRAY_TASK_ID}
echo "$N"
if [ ! $N ]; then
    N=$1
    if [ ! $N ]; then
        echo "Need an array id or cmdline val for the job"
        exit
    fi
fi
CPU=$SLURM_CPUS_ON_NODE
if [ -z $CPU ]; then
        CPU=1
fi

module load QUAST

contigs=$(ls prokka/*/*.fna | sed -n ${N}p)
base=$(basename $(dirname $contigs))
gff=prokka/$base/*.gff
output=quast_results/$base

quast.py -G $gff --threads 8 $contigs -o $output

