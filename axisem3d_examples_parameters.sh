#!/bin/bash

# This file contains the 'personal' settings you will need to automate the way the
# examples in AxiSEM3D-further-examples run on ARCHER2. All the file does is set some
# environment variables that get propogated to all scripts. However, we do not want
# your environment to pollute the repository, so we bundle a 'default' file in the
# repository and requier users to copy this to their homespace (the directory 
# avalable in $(HOME) and *only* look there.

# Thus the first step (step 2 in the README, after cloning the repo) is to copy
# this file to your homespace and update the values of the environment variables.

# THINGS THAT SHOULD BE UPDATED
# =============================

# Location to download AxiSEM3D code and prereqs, build binary, and store binary.
# This binary will be kept up to date with the AxiSEM3D git repository. 
AX3D_EX_BUILD_PRFX=/home/n03/n03/USER_NAME/AxiSEM-3D-build

# Location to create a directory inside which examples will run. On ARCHER2 this
# must be on the /work file system (not /home). Files are not removed from this
# location but rerunning jobs leaves backup copes (date stamps) behind. This is a 
# standard feature of AxiSEM3D!
AX3D_EX_RUNDIR=/work/n03/n03/USER_NAME/axisem3d-examples-run

# ARCHER2 account name (this is the name for accounting via slurm, it is generally
# not the same as your user name.
AX3D_EX_ACCOUNT=n03-USER


# THINGS THAT PROBABLY SHOULD NOT BE UPDATED
# ==========================================

# Location where the binary can be found. This is copied into each working directory.
# Unless you want to use some external version, just leave this as is
AX3D_EX_BINDIR=${AX3D_EX_BUILD_PRFX}/build


