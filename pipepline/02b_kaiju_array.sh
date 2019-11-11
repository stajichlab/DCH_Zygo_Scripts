#!/usr/bin/bash
#SBATCH --nodes 1 --ntasks 10 --mem 100G --out logs/kaiju.%a.log --time 0:10:00 -p short

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
SAMPLEFILE=samples.dat

mkdir -p $OUTPUT

#for f in `find . -name 'Bacterial_contigs.fa'`
#do                                                                                                                                                           
#   filename=`echo $f|awk -F'/' '{parent = NF-1; print $parent  "_" $NF}'`                                                                                    
#   echo $f|awk -F'/' '{parent = NF-1; print $parent  "_" $NF}'                                                                                               
#   cp $f $OUTPUT/$filename                                                                                                                                   
#done    

BASE=$(sed -n ${N}p $SAMPLEFILE | cut -f1)

if [ ! -f $INDIR/${BASE}]; then
        echo "Cannot run as $INDIR/${BASE} is missing"
        exit
elif [ ! -d $OUTPUT/${BASE}.kaiju.out ]; then
        kaiju -t kaijudb/nodes.dmp -f kaijudb/nr/kaiju_db_nr.fmi -z 10 -a "greedy" -e 3 -E .05 -v -i $INDIR/$BASE -o $OUTPUT/${BASE}.kaiju.out
else
    echo "skipping already started/run $BASE.kaiju.out in $OUTDIR"
    exit
fi

echo "done"

#Usage:
 #  kaiju -t nodes.dmp -f kaiju_db.fmi -i reads.fastq [-j reads2.fastq]
#
#Mandatory arguments:
 #  -t FILENAME   Name of nodes.dmp file
  # -f FILENAME   Name of database (.fmi) file
   #-i FILENAME   Name of input file containing reads in FASTA or FASTQ format

#Optional arguments:
#   -j FILENAME   Name of second input file for paired-end reads
#   -o FILENAME   Name of output file. If not specified, output will be printed to STDOUT
 #  -z INT        Number of parallel threads for classification (default: 1)
#   -a STRING     Run mode, either "mem"  or "greedy" (default: greedy)
#   -e INT        Number of mismatches allowed in Greedy mode (default: 3)
#   -m INT        Minimum match length (default: 11)
#   -s INT        Minimum match score in Greedy mode (default: 65)
#   -E FLOAT      Minimum E-value in Greedy mode
