#!/bin/bash -x


export PATH=$PATH:~/.local/bin

# activate the venv
source /pfs/lustrep4/scratch/project_462000259/shared_envs/deepSpeedMDEL/bin/activate

# check status of GPUs
/opt/rocm/bin/rocm-smi


# check if packages are available. if this fails, create a new venv as it indicates that the venv is not working correctly
pip show datasets

# check which python is being used
which python

TRAINING_LAYERS=9,10,11,12,13
export WANDB_PROJECT=pythia-1b-deduped-demo-run-$DATASET
export WANDB_NAME="layer_$TRAINING_LAYERS"
export WANDB_ENTITY=ontocord


export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
export WANDB_MODE=offline

accelerate launch --main_process_port 32183 /pfs/lustrep4/scratch/project_462000259/mdel_builds/MDEL/src/mdel/trainer.py \
        --configs lumi   \
        --dataset_name /pfs/lustrep4/scratch/project_462000259/shared_datasets/uspto \
        --model_name_or_path /pfs/lustrep4/scratch/project_462000259/shared_models/pythia-1b-deduped-base/pythia-1b-deduped \
        --output_dir "/pfs/lustrep4/scratch/project_462000259/shared_training/instruct_1bil/pile-instruct-test-run/ckpts/pythia-1b-deduped/$DATASET/layer_$TRAINING_LAYERS" \
        --training_layers $TRAINING_LAYERS \
        --wandb_entity $WANDB_ENTITY \
        --wandb_project $WANDB_PROJECT \
        --wandb_run_name $WANDB_NAME 