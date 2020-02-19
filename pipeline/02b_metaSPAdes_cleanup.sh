#!/bin/bash -l
#SBATCH --nodes 1 --ntasks 1 --mem 2G --out logs/metaSPAdes_cleanup.log --time 1:00:00 -p short

mkdir -p metaSPAdes_assemblies/
mkdir -p metaSPAdes_reads/ 

for i in metaSPAdes_out/*
do
	b=$(basename "$i" .fasta)
	mkdir -p metaSPAdes_assemblies/$b/
	mkdir -p metaSPAdes_reads/$b/
	mv $i/contigs.fasta metaSPAdes_assemblies/$b/
	mv $i/corrected/*.gz metaSPAdes_reads/$b/
done

gzip -r metaSPAdes_out

