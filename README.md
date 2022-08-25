# AxiSEM3D-further-examples

This repository contains further examples of AxiSEM3D calculations along with some
infrastructure to allow semi-automated running of these examples on the ARCHER2 system
(the current UK national HPC machine). The examples are chosen to illustrate the range
of calculations that can be undertaken on this scale of machene and, unlike the examples
distributed with the code, are thus not all suitible for execution on laptop or desktop
scale resources. While the initial range of examples are chosen to accompany a paper
describing AxiSEM3d, we hope that other interesting examples can be added over time
as the code and community evolves.

## The examples

Each example lives in it's own subdirectory along with reference output. Instructions
on adding new examples, along with the directory layout can be found towards the end of
this document. The examples currently included are:

### 01_S362ANI_EMC_global

A 3D model of wave propogation through the mantle (represented by the S362ANI
tomographic model) at 50 second period and generating ground displacments at a large
number of stations.

## Running the examples

The repository is designed to allow for easy running and rerunning of the examples in
a way that allows the main AxiSEM3D source to be updated. The basic procedure is:

1. Use git to clone or update a local copy of the repository on ARCHER2
2. Update a local copy of `axisem3d_examples_parameters.sh` in your homespace
3. Create or update an AxiSEM3D binary by running `build_axisem3d_archer2.sh`
4. Run each example via the work file system and slurm queue using `run_axisem3d_example.sh`
5. Undertake basic analysis with `postprocess_axisem3d_example.sh` for each example.

Steps 3 and 4 can be combined using `run_examples.sh` which updates the binary and
runs one, some or all of the available examples. You'll need to wait until the jobs
in the queue have run before running step 5.

## Adding an example

1. Create a new directory inside `/examples` to contain your example
2. Place all AxiSEM3D input inide a directory inside the directory you have created called /input (e.g. ./examples/my_new_example/input)
3. Create a file called 'job_params.sh' inside the example directory to specify the number of cores and so on.
4. Add some information to this file!

It should now be possible to run this example with existing machinary.



