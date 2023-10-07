#!/usr/bin/env bash

precision=${1:-"fp16"}  # fp16, tf32
batch=${2:-"8"}
gpus=${3:-"1"}

if [ -t 0 ]; then
    CMD="torchrun --nnodes=1 --nproc_per_node=${gpus}"
else
    CMD="python"
fi

set -euxo pipefail

if [ -t 0 ]; then
    DGXNNODES=1
    DGXNGPU=${gpus}
    extra="cluster_type=BCP"
else
    DGXNNODES=${SLURM_NNODES}
    DGXNGPU=${SLURM_NTASKS_PER_NODE}
    extra=""
fi

${CMD} main.py \
    --train \
    --base configs/stable-diffusion/v2-training.yaml \
    --precision ${precision} \
    --train_batch_size ${batch} \
    lightning.trainer.num_nodes=${DGXNNODES} \
    lightning.trainer.devices=${DGXNGPU} \
    ${extra}

