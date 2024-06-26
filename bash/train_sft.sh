#!/bin/bash

CUDA_VISIBLE_DEVICES=0,1,2,3,4,5 accelerate launch --main_process_port 9999 \
    --config_file LLaMA-Factory/LLaMA-Factory-main/examples/accelerate/master_config.yaml \
    LLaMA-Factory/LLaMA-Factory-main/src/train_bash.py \
    --stage sft \
    --do_train True \
    --model_name_or_path Yi-9B-post-pt \
    --dataset SFT-shopping-data \
    --dataset_dir LLaMA-Factory/LLaMA-Factory-main/data \
    --template default \
    --finetuning_type lora \
    --lora_target q_proj,v_proj \
    --lora_dropout 0.08 \
    --lora_rank 4 \
    --output_dir LLaMA-Factory/LLaMA-Factory-main/saves/Yi-9B/sft \
    --overwrite_output_dir True \
    --cutoff_len 1024 \
    --preprocessing_num_workers 6 \
    --per_device_train_batch_size 1\
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 2 \
    --lr_scheduler_type cosine \
    --logging_steps 10 \
    --warmup_steps 20 \
    --save_steps 150 \
    --eval_steps 100 \
    --evaluation_strategy steps \
    --learning_rate 2e-5 \
    --num_train_epochs 25 \
    --max_samples 160000 \
    --val_size 0.05 \
    --ddp_timeout 1800000 \
    --plot_loss True\
    --fp16
