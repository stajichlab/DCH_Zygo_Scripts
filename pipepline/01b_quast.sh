#!/bin/bash

module load QUAST/4.6.3

for i in metaSPAdes_out/*.fq.gz.kaiju.out/
metaquast.py $i
