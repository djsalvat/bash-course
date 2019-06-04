#!/bin/bash
#PBS -l nodes=1:ppn=1 
#PBS -l walltime=00:01:00
#PBS -N yell
#PBS -q debug
#PBS -V

#move to working directory
cd $PBS_O_WORKDIR
#Call "date" at beginning and end just to get timestamps.
#This is just something I like to do personally.
date
./yell.sh
date
