#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:45:00     # 1 day and 15 minutes
#SBATCH --output=clean.log
#SBATCH --mail-user=dcart001@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="clean up"
#SBATCH -p short # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

IN=/rhome/dcart001/bigdata/zygo_bacteria/metaspades/fungi_append_out

cat $IN/*.fa > all.fa
sed -E 's/([0-9])_.*/\1/' all.fa > all_no_.fa
sed -E 's/([0-9]).auto.*/\1/' all_no_.fa > all_no_auto.fa
sed -E 's/([0-9])\+.*/\1/' all_no_auto.fa > all_no_autoplus.fa
sed -E 's/([0-9])\-.*/\1/' all_no_autoplus.fa > all_clean.fa
gzip all_clean.fa

#sed 's/_/ /g' all_no_autoplusminus.fa > all_clean.fa
