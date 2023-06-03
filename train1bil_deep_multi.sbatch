#!/bin/bash -x
#SBATCH -A project_462000259
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --time=00:10:00
#SBATCH --gres=gpu:4
#SBATCH --partition=dev-g	
#SBATCH --mem 40G
#SBATCH --cpus-per-task 12
ping -c 4 google.com
# if the ping to google fails and the scripts hangs, it is trying to reach the internet somewhere in the script.


master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)

export MASTER_ADDR=$master_addr

export WANDB__EXECUTABLE=/opt/conda/bin/python

srun singularity exec -B /pfs/lustrep4/scratch/project_462000259 -B /pfs/lustrep4/users/$USER /pfs/lustrep4/scratch/project_462000259/shared_envs/deepspeed/deepspeed_rocm5.2.3_ubuntu20.04_py3.7_pytorch_1.12.1_deepspeed.sif bash run_sing_deep.sh