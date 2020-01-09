#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=25
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=08:15:00     # 15 minutes
#SBATCH --output=kaiju_out.log
#SBATCH -p highmem

module load kaiju

echo "here"

for i in Rmicrosporus_OMAR/genome/*.fa
do
	b=$(basename "$i" .fa)
	echo $b
	kaiju -v -t kaijudb/nodes.dmp -f kaijudb/nr/kaiju_db_nr.fmi -z 25 -a "greedy" -e 3 -s 200 -i $i -o kaiju_out/$i.ko
done
#kaiju -v -t kaijudb/nodes.dmp -f kaijudb/nr_euk/kaiju_db_nr_euk.fmi -z 10 -a "greedy" -e 3 -s 200 -i all.clean.gz -o kaiju_out/all.txt


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
