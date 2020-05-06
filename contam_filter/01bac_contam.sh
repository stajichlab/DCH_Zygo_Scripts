#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH -p short
#SBATCH --out logs/contam.%a.log

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
OUTPUT=contam_report_bac
mkdir -p $OUTPUT
BASE=$(sed -n ${N}p $SAMPLEFILE)

echo "searching " $BASE
b=$(basename $BASE .out)
cut -f 8 $BASE | cut -d ";" -f 2 | sort -u > $BASE.tmp
while read bac
do
	count=$(grep "$bac" $BASE | cut -f 6 | sort -u | wc -l)
	echo $b $bac $count >> $OUTPUT/$b.contam.csv
done < $BASE.tmp

rm $BASE.tmp
