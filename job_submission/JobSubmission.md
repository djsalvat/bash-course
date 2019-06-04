When transitioning from handling small-scale datasets to something somewhat larger
such as production data from an experiment, it can be worth setting up and configuring
an environment on a grid computer. Many institutions have one,
and there are larger-scale options like [XSEDE](https://www.xsede.org/) and [NERSC](https://www.nersc.gov/).

These computing environments generally use a job submission and resource management system.
You can submit a "job" -- e.g. the execution of some custom analysis code
that can benefit from running on multiple processors, take a long time,
require a lot of memory, or all of the above. The resource manager
will then consider the estimated length and required resources for your job
and place it in a queue with others' jobs in order to distribute and execute them in an efficient way.

There are several submission/management systems such as [SLURM](https://en.wikipedia.org/wiki/Slurm_Workload_Manager),
[PBS](https://en.wikipedia.org/wiki/Portable_Batch_System), or the related [TORQUE](https://en.wikipedia.org/wiki/TORQUE).
Here we will use the last of these, but most are similar enough that learning one
makes it easy to learn another.
[TORQUE](https://kb.iu.edu/d/avmy) is [fairly](https://gif.biotech.iastate.edu/torque-pbs-job-management-cheat-sheet)
common at [universities](http://www.arc.ox.ac.uk/content/torque-job-scheduler).
Here we will learn by example.

A job is submitted with the `qsub` command, canceled with `qdel`, and the status of a job
viewed with `qstat`. The flags and configuration options used by TORQUE
can depend upon the particular computing environment. For example,
some environments can have multiple queues with different names,
and the `qsub` command can be used to select one of those particular queues.

Options can be passed as flags to the `qsub` command,
but I find it is preferable to instead incorporate them into the beginning
of a submission shell script using TORQUE's special syntax.
Lines beginning with `#PBS` contain flags to be passed to the submission system.
In this folder we have a trivial shell script called `yell.sh`.
To facilitate use with TORQUE, we make an additional `submit_yell.sh`
script with the configuration flags followed by the invocation of `yell.sh`
along with any other commands we wish to execute.
As you can see, we can tell TORQUE the required resources with `-l`,
specify a queue with `-q`, pass along locally-declared environment
variables to the separate shell where the job will be executed with `-V`,
and so on. There are numerous helpful options, and exploring the above
linked resources is worth your time. For example, you can have an e-mail
sent to you when the job is completed.

The real power of grid computing is, of course, to execute demanding
jobs while using multiple processors. There are many ways to make programs
parallelizable depending on the programming language and complexity
of the tasks. [OpenMP](https://www.openmp.org/) and [MPI](https://www.open-mpi.org/) can be used
to parallelize `C` or `fortran` code, for example.
For [embarrassingly parallel](https://en.wikipedia.org/wiki/Embarrassingly_parallel) programs,
there are many options: TORQUE's [job arrays](http://www.arc.ox.ac.uk/content/torque-job-scheduler#PBSqsub),
python's [multiprocessing](https://docs.python.org/2/library/multiprocessing.html) module,
or [GNU parallel](https://www.gnu.org/software/parallel/). The author has provided
a nice installation and usage [walk-through](https://www.youtube.com/watch?v=OpaiGYxkSuQ),
and here I provide `submit_yell_parallel.sh` as a simple example.

In particular, note usage of the `{}` special characters. This can be used to,
for example, pass a unique number or other identifier to each instance of a script.
For example, this is useful if your script produces some output, and you wish to
have all *N* instances of your code produce *N* output files with unique names.
