#!/bin/bash

CUDA_VISIBLE_DEVICES=0 python LLaMA-Factory/LLaMA-Factory-main/src/export_model.py \
    --model_name_or_path Yi-9B \
    --adapter_name_or_path LLaMA-Factory/LLaMA-Factory-main/saves/Yi-9B/post-pt-1 \
    --template default \
    --finetuning_type lora \
    --export_dir Yi-9B-post-pt \
    --export_size 5 \
    --export_legacy_format False