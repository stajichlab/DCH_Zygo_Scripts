#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem=196G
#SBATCH --time=06:00:00     # 1 day and 15 minutes
#SBATCH --out logs/Maxbin2.%a.log
#SBATCH -p batch # This is the default partition, you can use any of the following; intel, batch, highmem, gpu
source ~/.bashrc
conda activate maxbin2

for i in metaSPAdes_out/*.metaSPAdes.out
do
	cat $i/corrected/*R1.fq.00.0_0.cor.fastq.gz $i/corrected/*R2.fq.00.0_0.cor.fastq.gz > $i/reads_list.gz
	gunzip $i/reads_list.gz
	mkdir $i/Maxbin_out/
	run_MaxBin.pl -contig $i/contigs.fasta -thread 48 -reads $i/reads_list -out $i/Maxbin_out/out
	echo $i " completed"
done

