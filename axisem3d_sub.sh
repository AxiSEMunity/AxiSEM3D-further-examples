#!/bin/bash --login

#SBATCH --job-name=axisem3d
#SBATCH --nodes=1
#SBATCH --tasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

#SBATCH --account=n03-walk
#SBATCH --partition=standard
#SBATCH --qos=standard

# Load modules
module load PrgEnv-gnu
module load cray-fftw/3.3.8.9
module load metis/5.1.0
module load cray-hdf5/1.12.0.3
module load cray-netcdf/4.7.4.3

# run axisem (input is in input)
srun --distribution=block:block --hint=nomultithread axisem3d > axisem.out
