#!/bin/bash

for file in fungi_append_out/*.fa
do
 b=$(basename $file .fa)
 perl -i -p -e "s/>/>$b|/" $file 
done
