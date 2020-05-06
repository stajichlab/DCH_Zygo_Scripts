#!/bin/bash

OUTPUT=fungi_append_out
mkdir -p $OUTPUT

for f in `find . -name '*Bacteria_contigs.fa'`
do
   filename=`echo $f|awk -F'/' '{parent = NF-1; print $parent  "_" $NF}'`
   echo $f|awk -F'/' '{parent = NF-1; print $parent  "_" $NF}'
   cp $f $OUTPUT/$filename
done

