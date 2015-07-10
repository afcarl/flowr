#PBS-N {{JOBNAME}}                                  # name of the job
#PBS-l nodes={{NODES}}:ppn={{CPU}}                  # specify number of nodes and cpu to reserve
#PBS-o {{STDOUT}}                                   # output is sent to logfile, stdout + stderr by default
#PBS-e {{STDOUT}}                                   # output is sent to logfile, stdout + stderr by default
#PBS-q {{QUEUE}}                                    # Job queue
#PBS-l walltime={{WALLTIME}}                        # Walltime in minutes
#PBS-l mem={{MEMORY}}                               # Memory requirements in Kbytes
#PBS-r y -V                                         # make the jobs re-runnable. -V export all env of user to compute nodes
#PBS-j oe                                           # merge output from stdout and stderr
#PBS-S /bin/bash                                    # use bash shell
#PBS-d {CWD}}                                       # the workding dir for each job, this is {{flow_path}}/tmp
#PBS-M {EMAIL}                                      # email address of the person
#PBS{{DEPENDENCY}}                                  # Don't remove dependency args come here; format handled by: parse_dependency()
#PBS{{EXTRA_OPTS}}                                  # Any extra arguments passed onto queue(), don't change. Format handled by R

## ------------------------------ n o t e s -------------------------##
## All variables specified above are replaced on the fly. 
## Most of them come from the flow_definition file.
## This is a core component of how flowr interacts with the cluster.
## Please refer to the platform manual, before editing this file.
## ------------------------------------------------------------------##

## --- DO NOT EDIT from below here---- ##

touch {{TRIGGER}}
echo 'BGN at' `date`

## --- command to run comes here (flow_mat)
{{CMD}}

echo 'END at' `date`

exitstat=$?
echo $exitstat > {{TRIGGER}}
exit $exitstat
