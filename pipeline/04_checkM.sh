#!/bin/bash -l

#SBATCH --nodes 1 --ntasks 16 --mem 200G --out logs/checkM.%a.log --time 48:00:00 -p batch

#CPU=$SLURM_CPUS_ON_NODE
#N=${SLURM_ARRAY_TASK_ID}

#if [ ! $N ]; then
#    N=$1
#    if [ ! $N ]; then
#        echo "Need an array id or cmdline val for the job"
#        exit
#    fi
#fi
hostname

source ~/.bashrc
conda activate checkM

#INDIR=maxbin2_out
INDIR=autometa_bins
OUTPUT=checkm_out/autometa/
SAMPLEFILE=bins.dat

mkdir -p $OUTPUT

#BASE=$(sed -n ${N}p $SAMPLEFILE | cut -f1)

#if [ ! -f $INDIR/${BASE} ]; then
#        echo "Cannot run as $INDIR/${BASE} is missing"
#	exit
#if [ ! -d $OUTPUT/${BASE} ]; then
#	echo "input: $INDIR/$BASE"		
#	echo "save to: $OUTPUT/${BASE}"
checkm lineage_wf -t 16 -x fasta $INDIR/ $OUTPUT
#else
#    echo "skipping already started/run $BASE in $OUTDIR"
#    exit
#fi

echo "done"

