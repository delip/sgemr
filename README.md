sgemr
=====

A map-reduce imitation using the Sun Grid Engine. This is really esoteric software that I used a lot in grad school but 
putting it out there for anyone to use. You really should be using a real map-reduce but if you are constrained to the Sun Grid Engine
this is a way to distribute jobs without worrying about sharding, etc.

Installation
------------

1. Clone this repo to a directory, say `mrinstall`.
2. Set MRHOME appropriately

	export MRHOME=/home/delip/mrinstall/bin
	
	setenv MRHOME /home/delip/mrinstall/bin

Tutorial
--------
A detailed tutorial with examples is available here:

http://docs.google.com/Presentation?id=dhdwqnx7_67gn2ss8f7

dist options
-------------
<pre>
`$MRHOME/dist` - All you need to run map-reduce

OPTIONS:
--no-split   : Use input file as is
--dist-split : Use distributed line count
  Only used with the default mapper (line-mapper).
--job-name   : Name of the job (mandatory)
--num-workers: Number of workers
  Note - The SGE has a quota (60, I think) on the no. of processes per user. 
	 Remaining workers will be queued.
--mapper     : Path to the mapper script.
  The default mapper will be used when this is not provided.
  Default mapper (line-mapper) splits the input equally (by #lines). 
  When a mapper is provided, --no-split is enabled
--mapper-argstr : Arguments to the custom mapper script
  All argument strings (argstr) consist of NAME=VALUE or NAME, 
  separated by commas.
  e.g. if the mapper takes two arguments, say -c with no value and -l 2, 
       the argstr will be "-c,-l=2"
--worker     : Path to the worker script (mandatory)
--worker-argstr : Arguments to the worker script
--reducer    : One of 'null', 'identity', 'sum', or path to the reducer script.
  null reducer does no action.
  identity reducer concats the worker outputs.
  sum reduce adds worker outputs
--reducer-argstr : Arguments to the reducer script
--enable-combiner: Flag to run combiner
  As of now, combiner is the reducer that runs on worker nodes to 
  partially aggregate results
--infile     : Input file to work on
--infilelist : List of input files
  Either one of --infile or --infilelist must be specified
  If --infilelist is specified, the mapper is skipped and --no-split is enabled.
--notify     : Receive job completion notification by email
  For multiple recepients separate email-ids by comma.
--outfile    : Output file that will contain combined result
--rm-workdir : Delete work directory containing intermediate files
  By default, the work directory is not deleted.
  Note - typically a large number of files are created in the work directory 
	 which can consume a lot of inode table space. Its a good idea to 
	 enable this option once your map-reduce scripts have been tested and
	 debugged.
--help       : This help
</pre>
