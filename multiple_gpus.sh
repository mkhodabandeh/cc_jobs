#!/bin/bash
#SBATCH --gres=gpu:4              # request GPU "generic resource"
#SBATCH --nodes=1                 # request GPU "generic resource"
#SBATCH --mem=4000M               # memory per node
#SBATCH --time=0-01:00            # time (DD-HH:MM)
#SBATCH --output=%x_%a.out        # %x job name, %j job id, %A array master's job id, %a array id
#SBATCH -J "Train_MNIST"          # job name
#SBATCH --array=0-2               # job array of size 3

pids=""
for GPU_ID in `seq 0 3`; do
   SETTINGS_ID=$((SLURM_ARRAY_TASK_ID*4+GPU_ID))
   CUDA_VISIBLE_DEVICES=$GPU_ID python mycode.py $SETTINGS_ID &
   pids="$pids $!"
done

wait $pids
