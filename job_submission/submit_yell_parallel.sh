#!/bin/bash
#PBS -l nodes=1:ppn=4 
#PBS -l walltime=00:01:00
#PBS -N yell
#PBS -q debug
#PBS -V

#move to working directory
cd $PBS_O_WORKDIR
#Call "date" at beginning and end just to get timestamps
date

#GNU parallel expects a list of items to loop over in a parallel way.
#Here "seq" just provides a list of integers 1 to 24. We then run another script
#Which takes a given one of those integers N and runs an instance of g4simple-naive
#while writing the output to <some file>_N.root. The "{}" is a special instruction
#to GNU parallel to tell it to supply the given integer.
seq 1 4 | parallel ./yell.sh "{}"

date
