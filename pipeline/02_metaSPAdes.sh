#!/bin/bash -l
#SBATCH --nodes 1 --ntasks 16 --mem 250G --out logs/metaSPAdes.%a.log --time 24:00:00 -p batch

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
conda activate SPAdes

INDIR=input
OUTPUT=metaSPAdes_out
SAMPLEFILE=samples.dat

mkdir -p $OUTPUT


if [ $((N%2)) -eq 0 ]; then
	echo $N "is even, skipping"
else
	O=$((N + 1))
	echo $N
	echo $O
	ForRead=$(sed -n ${N}p $SAMPLEFILE | cut -f1)
	RevRead=$(sed -n ${O}p $SAMPLEFILE | cut -f1)
	b=$(basename "$ForRead" _R1.fq.gz)
        echo "output is $OUTPUT/$b"
	echo "Forward reads $ForRead"
	echo "Reverse reads $RevRead"
	if [ ! -f $INDIR/${ForRead} ]; then
        	echo "Cannot run as $INDIR/${ForRead} is missing"
        	exit
	elif [ ! -d $OUTPUT/$b ]; then
		spades.py --meta -1 $INDIR/$ForRead -2 $INDIR/$RevRead -o $OUTPUT/$b
	else
    		echo "skipping already started/run $b in $OUTDIR"
    		exit
	fi
fi

echo "finished metaSPAdes"





