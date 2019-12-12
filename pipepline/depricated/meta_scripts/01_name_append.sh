#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=00:15:00     # 1 day and 15 minutes
#SBATCH --output=fungalappend.out
#SBATCH --mail-user=dcart001@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name=Fungalgenome_append_to_contig
#SBATCH -p short # This is the default partition, you can use any of the following; intel, batch, highmem, gpu<Paste>

OUTPUT=fungi_append_out
mkdir -p $OUTPUT
for f in `find . -name '*.fasta'`
do                                                                                                                                                           
   filename=`echo $f|awk -F'/' '{parent = NF-1; print $parent  "_" $NF}'`                                                                                    
   echo $f|awk -F'/' '{parent = NF-1; print $parent  "_" $NF}'                                                                                               
   cp $f $OUTPUT/$filename                                                                                                                                   
done    


