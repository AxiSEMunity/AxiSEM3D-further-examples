#!/bin/bash

# Get out per-user params (or fail)
. ${HOME}/axisem3d_examples_parameters.sh

# Display help
Help()
{
	echo "Script to run some (or all) AxiSEM3d examples on ARCHER2"
	echo
	echo "Syntax: run_examples.sh [-a|r] [example_dir...]"
	echo "options:"
	echo " a    run all known examples"
	echo " r    update and rebuild AxiSEM3d"
	echo " d    dryrun (don't actually submit jobs)"
	echo "Otherwise the example in each example_dir is submitted to the queue"
}

# Main script
rebuild=false
all=false
dryrun=false
while [ $# -gt 0 ]; do
    while getopts arhd name; do
        case $name in
            a) all=true;;
            r) rebuild=true;;
            h) Help;;
	    d) dryrun=true;;
        esac
    done
    [ $? -eq 0 ] || exit 1
    [ $OPTIND -gt $# ] && break 

    shift $[$OPTIND - 1] 
    OPTIND=1             
    ARGS[${#ARGS[*]}]=$1 
    shift                
done

if [ $rebuild = "true" ]; then
	echo "Reuilding AxiSEM3D"
	/bin/bash build_axisem3d_archer2.sh
fi

if [ $all = "true" ]; then
	EXAMPLES=()
	for example in `ls examples`; do
		EXAMPLES+=("examples/"$example)
	done
else
	EXAMPLES=${ARGS[*]}
fi

for EXAMPLE in ${EXAMPLES}; do
	mkdir -p ${AX3D_EX_RUNDIR}/${EXAMPLE##*/}
	cp -r $EXAMPLE/input ${AX3D_EX_RUNDIR}/${EXAMPLE##*/}
	cp ${AX3D_EX_BINDIR}/axisem3d ${AX3D_EX_RUNDIR}/${EXAMPLE##*/}
	/bin/bash ./make_axisem3d_subfile.sh $EXAMPLE/jobparams.sh > ${AX3D_EX_RUNDIR}/${EXAMPLE##*/}/axisem3d_sub.sh
	cd ${AX3D_EX_RUNDIR}/${EXAMPLE##*/}
	if [ $dryrun != "true" ]; then
		sbatch axisem3d_sub.sh
	else
		echo "Not running " $EXAMPLE " but set up"
	fi
	cd -
done
