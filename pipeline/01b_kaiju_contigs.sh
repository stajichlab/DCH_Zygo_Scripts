#!/usr/bin/bash
#SBATCH --nodes 1 --ntasks 24 --mem 240G --out logs/kaiju.maxbin2_contigs.log --time 02:00:00 -p short

hostname
module load kaiju/1.7.2


DBFOLDER=/opt/linux/centos/7.x/x86_64/pkgs/kaiju/share/DB
DB=$DBFOLDER/nr_euk/kaiju_db_nr_euk.fmi
NODES=$DBFOLDER/nodes.dmp
NAMES=$DBFOLDER/names.dmp
INPUT=maxbin2_out/
OUTPUT=kaiju_out/maxbin2/ 

#INDIR=ref_genomes/fasta
#OUTPUT=ref_genomes/kaiju_out

mkdir -p $OUTPUT
#Just Prokaryotes
#kaiju -v -m 11 -s 65 -E .05 -t kaijudb/nodes.dmp -f kaijudb/nr/kaiju_db_nr.fmi -z 24 -a "greedy" -i $INDIR/*.gz -o $OUTPUT/assemblies.out
#Classify Bins

#for i in $INPUT/*.fasta
#do
#	b=$(basename "$i" .fasta)
#	perl -i -p -e "s/>/>$b|/" $i
#done

#cat $INPUT/*.fasta > $INPUT/combinedbins.fasta
#gzip $INPUT/combinedbins.fasta

kaiju -v -s 100 -e 10 -t $NODES -f $DB -z 10 -a "greedy" -i $INPUT/combinedbins.fasta.gz -o $OUTPUT/classified.out
echo "kaiju done"


kaiju2table -m 1 -t $NODES -n $NAMES -r phylum -o $OUTPUT/kaiju_summary.tsv $OUTPUT/classified.out 

