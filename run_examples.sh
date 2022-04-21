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
	echo "Otherwise the example in each example_dir is submitted to the queue"
}

# Main script
rebuild=false
all=false
while [ $# -gt 0 ]; do
    while getopts arh name; do
        case $name in
            a) all=true;;
            r) rebuild=true;;
            h) Help;;
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
	echo "Not running " $EXAMPLE

done
