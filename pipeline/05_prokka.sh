#!/bin/bash -l
#SBATCH -N 1 -n 8 --mem=16G --out logs/prokka.%a.log --time=2:00:00 -p short

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
#conda activate prokka
#module unload perl
#module unload perl
#module load perl/5.24.0 
module load prokka/1.14.5
mkdir -p prokka
OUTDIR=$(realpath prokka)
#SAMPFILE=burk_samples.csv
#MAX=`wc -l $SAMPFILE | awk '{print $1}'`

#if [ $N -gt $MAX ]; then
#        echo "$N is too big, only $MAX lines in $SAMPFILE"
#        exit
#fi

#INPUTFOLDER=prokka/${name}

#name=$(sed -n ${N}p $SAMPFILE | cut -f1)
#species=$(echo "$Species" | cut -f2)

file=$(ls autometa_bins/burkholderia/*.bac.fasta | sed -n ${N}p)
b=$(basename $file .fasta)
tempfile=/scratch/prokka_$b.$$
perl -p -e 's/>(NODE_\d+)_/>$1 /' $file > /scratch/prokka_$b.$$
prokka $tempfile --centre UCR --addgenes --metagenome --cpus $CPU  --force --outdir $OUTDIR/$b 
unlink $tempfile
