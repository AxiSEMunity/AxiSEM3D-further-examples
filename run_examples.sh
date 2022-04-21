#!/bin/bash

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

BINDIR=/home/n03/n03/andreww/AxiSEM-3D-test/build
RUNDIR=/work/n03/n03/andreww/axisem3d-examples-test
mkdir -p $RUNDIR

for EXAMPLE in ${EXAMPLES}; do
	mkdir -p $RUNDIR/${EXAMPLE##*/}
	cp -r $EXAMPLE/input $RUNDIR/${EXAMPLE##*/}
	cp $BINDIR/axisem3d $RUNDIR/${EXAMPLE##*/}
	cp axisem3d_sub.sh $RUNDIR/${EXAMPLE##*/}
	cd $RUNDIR/${EXAMPLE##*/}
	if [ $dryrun != "true" ]; then
		sbatch axisem3d_sub.sh
	else
		echo "Not running " $EXAMPLE " but set up"
	fi
	cd -
done
