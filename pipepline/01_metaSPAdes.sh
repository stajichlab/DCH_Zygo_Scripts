#!/usr/bin/bash
#SBATCH --nodes 1 --ntasks 16 --mem 250G --out logs/metaSPAdes.%a.log --time 8:00:00 -p batch

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
module load SPAdes/3.13.1

INDIR=Rmicrosporus_OMAR/raw_reads
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
	echo $ForRead
	echo $RevRead
	if [ ! -f $INDIR/${ForRead}]; then
        	echo "Cannot run as $INDIR/${ForRead} is missing"
        	exit
	elif [ ! -d $OUTPUT/${ForRead}.metaSPAdes.out ]; then
        	spades.py --meta -1 $INDIR/$ForRead -2 $INDIR/$RevRead -o $OUTPUT/${ForRead}.metaSPAdes.out
	else
    		echo "skipping already started/run $ForRead.metaSPAdes.out in $OUTDIR"
    		exit
	fi
fi

echo "finished metaSPAdes"

for i in metaSPAdes_out/*.out; do b=$(basename "$i" _R1.fq.gz.metaSPAdes.out); echo $i; echo $b; mv $i metaSPAdes_out/$b.metaSPAdes.out; done




