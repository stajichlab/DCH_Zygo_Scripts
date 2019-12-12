#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5G
#SBATCH --time=01:15:00     # 1 day and 15 minutes
#SBATCH --output=logs/nameappend.%a.log
#SBATCH --job-name=Funginame_append_to_read
#SBATCH -p short


CPU=$SLURM_CPUS_ON_NODE
N=${SLURM_ARRAY_TASK_ID}

if [ ! $N ]; then
    N=$1
    if [ ! $N ]; then
        echo "Need an array id or cmdline val for the job"
        exit
    fi
fi

# To create the reads.dat file use the following line in the input folder: ls *.fq.gz | sed -e 's/\.fq.gz$//' | cat > reads.dat


hostname
module load kaiju/1.7.2

INDIR=input
OUTPUT=Fungal_names_to_reads
SAMPLEFILE=reads.dat

mkdir -p $OUTPUT

BASE=$(sed -n ${N}p $SAMPLEFILE | cut -f1)

if [ ! -f $INDIR/${BASE}.fq.gz ]; then
        echo "Cannot run as $INDIR/${BASE} is missing"
        exit
elif [ ! -d $OUTPUT/${BASE}.temp.fq ]; then
        echo "unzipping $INDIR/$BASE.fq.gz"
	gunzip $INDIR/$BASE.fq.gz
	echo "writing to temp file"
	cat $INDIR/$BASE.fq > $OUTPUT/$BASE.temp.fq
	echo "finished zipping input file"
	gzip $INDIR/$BASE.fq
	echo "adding to reads.fq"
	sed -e "s/@/@$BASE|/" $OUTPUT/$BASE.temp.fq >> $OUTPUT/all_reads.fq
	echo "success, removing temp file"
	rm $OUTPUT/$BASE.temp.fq
else
	exit
fi
#for i in *.fq.gz; do gunzip $i;  b=$(basename $i .fq.gz); echo "Attempting to write $b to the ab.temp.out"; cat $b.fq > $b.temp.out; echo "now zipping";  gzip $b.fq; done
#for i in *.temp.out; do b=$(basename $i .temp.out), sed -e "s/@/@$b|/" $i; cat $i >> all_reads.fq; rm $i; done


