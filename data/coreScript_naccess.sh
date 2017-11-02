#!/bin/bash

# already loaded in the sbatch script
# - module load naccess

# required variables :
# - targetPdbFile

cmd="naccess $targetPdbFile"
# run
if ! $cmd > /dev/null
        then echo "ERROR with Naccess" 1>&2 # redirect to error
fi

# to avoid perl warning :
export LANGUAGE=fr_FR.UTF-8
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8

fileName=`basename $targetPdbFile | perl -pe 's/\.inp$//'`
rsaFile=$fileName".rsa"

# cp $WORKDIR/$rsaFile ./ # for web services

# parse & get results
echo `echo "{\"listRES\" : [" ;grep "^RES" $rsaFile | awk 'BEGIN{FS="";OFS=""}{print "[\"" $5$6$7 "\",\"" $9 "\"," $10$11$12$13 "," $15$16$17$18$19$20$21$22 "],"}' | head --bytes -2; echo "]}"`
