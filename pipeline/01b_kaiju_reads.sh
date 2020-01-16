#!/usr/bin/bash
#SBATCH --nodes 1 --ntasks 24 --mem 240G --out logs/kaiju.%a.log --time 01:00:00 -p short

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
module load kaiju/1.7.2

INDIR=input
OUTPUT=kaiju_out
SAMPLEFILE=fullmonty.dat

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
        echo "Output will be: $OUTPUT/$b"
        echo "Forward reads: $ForRead"
        echo "Reverse reads: $RevRead"
        if [ ! -f $INDIR/${ForRead} ]; then
                echo "Cannot run as $INDIR/${ForRead} is missing"
		exit
        elif [ ! -d $OUTPUT/$b.out ]; then                                                                                                                                             
        	echo "Analyzing $b"                                                                                                                                                          
        	kaiju -v -m 11 -s 65 -E .05 -t kaijudb/nodes.dmp -f kaijudb/nr/kaiju_db_nr.fmi -z 24 -a "greedy" -i $INDIR/$ForRead -j $INDIR/$RevRead -o $OUTPUT/$b.out                                                            
        else
                echo "skipping already started/run $b in $OUTDIR"
                exit
        fi
fi

echo "kaiju done"

