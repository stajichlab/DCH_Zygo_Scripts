#!/bin/bash -l 

for i in quast_results/*/report.tsv; do echo $(basename $(dirname $i)) $(grep "Largest" $i); done | sort -k4 -n > Contig_size.tsv

for i in quast_results/*/report.tsv; do echo $(basename $(dirname $i)) $(grep "N50" $i); done | sort -k4 -n > N50_size.tsv
