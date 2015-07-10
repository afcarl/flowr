#BSUB-J {{JOBNAME}}                                  # name of the job
#BSUB-o {{STDOUT}}                                   # output is sent to logfile, stdout + stderr by default
#BSUB-e {{STDERR}}                                   # output is sent to logfile, stdout + stderr by default
#BSUB-q {{QUEUE}}                                    # Job queue
#BSUB-W {{WALLTIME}}                                 # Walltime in minutes
#BSUB-M {{MEMORY}}                                   # Memory requirements in Kbytes
#BSUB-R usage[mem={{MEMORY}}]                        # memory reserved
#BSUB-R span[ptile={{CPU}}]                          # CPU reserved
#BSUB-r                                              # make the jobs re-runnable
#BSUB{{EXTRA_OPTS}}                                  # Any extra arguments passed onto queue()
#BUSB{{DEPENDENCY}}                                  # Don't remove dependency args come here

## ------------------------------ n o t e s -------------------------##
## All variables specified above are replaced on the fly. 
## Most of them come from the flow_definition file.
## This is a core component of how flowr interacts with the cluster.
## Please refer to the platform manual, before editing this file
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
