#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=240G
#SBATCH --time=2:00:00 
#SBATCH --out logs/Maxbin22.%a.log
#SBATCH -p short # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

echo "I am running"

hostname
source ~/.bashrc
conda activate maxbin2

CPU=$SLURM_CPUS_ON_NODE
N=${SLURM_ARRAY_TASK_ID}

if [ ! $N ]; then
    N=$1
    if [ ! $N ]; then
        echo "Need an array id or cmdline val for the job"
        exit
    fi
fi

CONTIGS=autometa/genomes_unfilt
READS=autometa/fastq
OUTDIR=maxbin2_out/SPAdes
SAMPLEFILE=SPAdes_metagenomes.dat
#mkdir -p $OUTDIR

BASE=$(sed -n ${N}p $SAMPLEFILE | cut -f1)
echo "$BASE"
echo "output is $OUTDIR/$BASE"
if [ ! -f $CONTIGS/$BASE.spades.fasta ]; then
        echo "Cannot run as $CONTIGS/$BASE contigs are missing"
        exit
elif [ ! -d $OUTDIR/$BASE ]; then
        cat $READS/"$BASE"_R1.fq.gz $READS/"$BASE"_R2.fq.gz > $READS/$BASE.reads_list.gz
        gunzip $READS/$BASE.reads_list.gz
        run_MaxBin.pl -contig $CONTIGS/$BASE.spades.fasta -thread 24 -reads $READS/$BASE.reads_list -out $OUTDIR/$BASE
	rm $READS/$BASE.reads_list
	rm $READS/$BASE.reads_list.gz
else
        echo "skipping already started/run $BASE in $OUTDIR"
        exit
fi

