#!/bin/bash
#SBATCH -J yell 
#SBATCH -p debug
#SBATCH -o %j.o
#SBATCH -e %j.e
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00:01:00
#SBATCH -A general

#move to working directory
cd $SLURM_SUBMIT_DIR
#Call "date" at beginning and end just to get timestamps.
#This is just something I like to do personally.
date
./yell.sh
date
