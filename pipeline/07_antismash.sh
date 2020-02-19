#!/bin/bash -l
#SBATCH --nodes 1 --ntasks 8 --mem 16G --out logs/antismash.%a.log -J antismash --partition batch --time=12:00:00


module unload miniconda2
module unload miniconda3
module load anaconda3
module load antismash/5.1.1
module load antismash/5.1.1
module unload meme/4.11.2 
module load meme
which perl
which antismash
which meme

CPU=1
if [ ! -z $SLURM_CPUS_ON_NODE ]; then
	CPU=$SLURM_CPUS_ON_NODE
fi

OUTDIR=annotate
SAMPFILE=outgroup_samples.csv
N=${SLURM_ARRAY_TASK_ID}
if [ ! $N ]; then
	N=$1
	if [ ! $N ]; then
		echo "need to provide a number by --array or cmdline"
		exit
	fi
fi
MAX=`wc -l $SAMPFILE | awk '{print $1}'`

if [ $N -gt $MAX ]; then
	echo "$N is too big, only $MAX lines in $SAMPFILE"
	exit
fi

#INPUTFOLDER=prokka/${name}
INPUTFOLDER=gtoTree/ncbi-genomes-2020-02-13

name=$(sed -n ${N}p $SAMPFILE | cut -f1) 
species=$(echo "$Species" | cut -f2)
#FILECT=$(ls $INPUTFOLDER/$name/PROKKA*.gbk | wc -l | awk '{print $1}')
#if [ $FILECT -gt 1 ]; then
#	echo "More than one gbk file in $INPUTFOLDER/$name"
#	exit
#fi
#INFILE=$(ls $INPUTFOLDER/$name/PROKKA*.gbk)
#INFILE=$(ls $INPUTFOLDER/$name)
antismash --taxon bacteria --output-dir $OUTDIR/$name.antismash_local --genefinding-tool prodigal \
		--asf --fullhmmer --clusterhmmer --cb-general --pfam2go --cb-subclusters --cb-knowncluster -c 8 \
		$INPUTFOLDER/${name} 
# --genefinding-gff3  #only provide GFF or GBK not both $INPUTFOLDER/$name/PROKKA*.gff
