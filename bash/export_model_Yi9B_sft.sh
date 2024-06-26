#!/bin/bash

CUDA_VISIBLE_DEVICES=0 python LLaMA-Factory/LLaMA-Factory-main/src/export_model.py \
    --model_name_or_path Yi-9B-post-pt \
    --adapter_name_or_path LLaMA-Factory/LLaMA-Factory-main/saves/Yi-9B/sft/checkpoint-3750 \
    --template default \
    --finetuning_type lora \
    --export_dir Yi-9B-sft \
    --export_size 5 \
    --export_legacy_format False