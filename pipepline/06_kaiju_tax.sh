#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=05:15:00     # 1 day and 15 minutes
#SBATCH --output=06_sort_tax
#SBATCH -p batch

module load kaiju/1.7.2
mkdir tax/

for i in kaiju_out/*.fq.gz.kaiju.out.rename
do
	b=$(basename "$i" .fq.gz.kaiju.out.rename)
	echo $i
	#echo $b
	kaiju-addTaxonNames -u -r kingdom,genus -t kaijudb/nodes.dmp -n kaijudb/names.dmp -i $i -o tax/taxified_kaiju.$b.out
	#kaiju2table -t kaijudb/nodes.dmp -n kaijudb/names.dmp -r genus -o summary_$b_.tsv tax/taxified_kaiju.$b.out
	#kaiju2krona -t nodes.dmp -n names.dmp -i kaiju.out -o kaiju.out.krona
done

grep "C" tax/*.out >> all_tax.out

