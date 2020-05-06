#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=06:00:00
#SBATCH -p batch
#SBATCH --out logs/contam.gene.%a.log

CPU=$SLURM_CPUS_ON_NODE
N=${SLURM_ARRAY_TASK_ID}

if [ ! $N ]; then
    N=$1
    if [ ! $N ]; then
        echo "Need an array id or cmdline val for the job"
        exit
    fi
fi
hostname

ls ../tax/*.out > genomes.dat
SAMPLEFILE=genomes.dat
OUTPUT=contam_report
mkdir -p $OUTPUT
BASE=$(sed -n ${N}p $SAMPLEFILE)

echo "searching " $BASE
b=$(basename $BASE .out)
 
cut -f 6 $BASE | sort -u > $BASE.gene.tmp
while read gene
do
	count=$(grep "$gene" $BASE | wc -l)
	echo $b $gene $count >> $OUTPUT/$b.contam.csv
done < $BASE.gene.tmp

rm $BASE.gene.tmp
