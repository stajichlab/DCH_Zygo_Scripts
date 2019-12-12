#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --output=makebwt.log
#SBATCH -p highmem

module load kaiju

kaiju -t kaijudb/nodes.dmp -f kaiju/nr_euk/kaiju_db_nr_euk.fmi -z 10 -a "greedy" -e 5 -s 200 -i meta_all_clean.fa.gz


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
