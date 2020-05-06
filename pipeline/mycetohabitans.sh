#!/bin/bash -l
#SBATCH --nodes 1 --ntasks 16 --mem 250G --out logs/SPAdes_mycetohabitans.log --time 12:00:00 -p batch

b=Mycetohabitans_endofungorum

hostname
module load SPAdes

spades.py --12 input/Mycetohabitans_endofungorum_HKI456.fastq  --isolate -o $b

echo "finished SPAdes"
module unload SPAdes

module load prokka/1.14.5
mkdir -p prokka
OUTDIR=$(realpath prokka)

file=$b/contigs.fasta
tempfile=/scratch/prokka_$b.$$
perl -p -e 's/>(NODE_\d+)_/>$1 /' $file > /scratch/prokka_$b.$$
prokka $tempfile --centre UCR --addgenes --cpus 16  --force --outdir $OUTDIR/$b 
unlink $tempfile

echo "finished prokka"
module unload prokka
module load python/2.7.13
module load checkm

INDIR=prokka/$b
OUTPUT=checkm_out/$b

checkm lineage_wf -t 16 -x fna $INDIR $OUTPUT
