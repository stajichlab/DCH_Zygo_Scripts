#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=200G
#SBATCH --time=02:00:00     # 1 day and 15 minutes
#SBATCH --output=logs/kaiju_tax.log
#SBATCH -p short

module load kaiju/1.7.2
mkdir tax/

for i in kaiju_out/*.out
do
	b=$(basename "$i" .out)
	echo $i
	echo $b
	kaiju-addTaxonNames -u -r kingdom,genus -t kaijudb/nodes.dmp -n kaijudb/names.dmp -i $i -o tax/$b.out
done

#grep -i "^C" tax/*.out > all_tax.out
kaiju2table -m 1 -t kaijudb/nodes.dmp -n kaijudb/names.dmp -r genus -o kaiju_table_summary.tsv tax/*.out
sed -i -e "s/tax\///g" kaiju_table_summary.tsv 
sed -i -e "s/\.out//g" kaiju_table_summary.tsv 
sed -i -e "s/_/ /g" kaiju_table_summary.tsv 
