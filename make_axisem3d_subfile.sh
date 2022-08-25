#!/bin/bash

JOBPARAMS=$1

# Get out per-user params (or fail)
. ${HOME}/axisem3d_examples_parameters.sh

# Get per-job params
. ${JOBPARAMS}

cat << EOF
#!/bin/bash --login

#SBATCH --job-name=${AX3D_JOB_NAME}
#SBATCH --nodes=${AX3D_JOB_NODES}
#SBATCH --tasks-per-node=${AX3D_JOB_TASKS_PER_NODE}
#SBATCH --cpus-per-task=${AX3D_JOB_CPUS_PER_TASK}
#SBATCH --time=${AX3D_JOB_TIME}

#SBATCH --account=${AX3D_EX_ACCOUNT}
#SBATCH --partition=standard
#SBATCH --qos=standard

# Load modules
module load PrgEnv-gnu
module load cray-fftw/3.3.8.9
module load metis/5.1.0
module load cray-hdf5/1.12.0.3
module load cray-netcdf/4.7.4.3

# run axisem (input is in input)
srun --distribution=block:block --hint=nomultithread axisem3d > axisem3d.out
EOF
