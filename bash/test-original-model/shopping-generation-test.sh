#!/bin/bash

CUDA_VISIBLE_DEVICES=0,1 accelerate launch\
    --config_file LLaMA-Factory/LLaMA-Factory-main/examples/accelerate/master_config_1.yaml \
    LLaMA-Factory/LLaMA-Factory-main/src/train_bash.py \
    --model_name_or_path Yi-9B \
    --stage sft \
    --do_predict true \
    --dataset shopping-generation-test \
    --dataset_dir LLaMA-Factory/LLaMA-Factory-main/data \
    --template default \
    --output_dir Yi-9B/shopping-generation-test \
    --per_device_eval_batch_size 4 \
    --max_samples 50000 \
    --cutoff_len 1024 \
    --max_new_tokens 512 \
    --predict_with_generate true \
    --fp16 true \