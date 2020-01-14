#!/bin/bash -l

#SBATCH --nodes 1 --ntasks 8 --mem 40G --out logs/checkM.%a.log --time 01:00:00 -p short

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

source ~/.bashrc
conda activate checkM

INDIR=metaSPAdes_out
OUTPUT=checkm_out
SAMPLEFILE=bins.dat

mkdir -p $OUTPUT

BASE=$(sed -n ${N}p $SAMPLEFILE | cut -f1)

if [ ! -f $INDIR/${BASE}/Maxbin_out/out.001.fasta ]; then
        echo "Cannot run as $INDIR/${BASE}/Maxbin_out/out.001.fasta is missing"
	exit
elif [ ! -d $OUTPUT/${BASE} ]; then
	echo "input $INDIR/$BASE/Maxbin_out"		
	echo "save to $OUTPUT/${BASE}"
	checkm lineage_wf -t 8 -x fasta $INDIR/$BASE/Maxbin_out ./$OUTPUT/${BASE}
else
    echo "skipping already started/run $BASE in $OUTDIR"
    exit
fi

echo "done"

