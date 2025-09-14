#!/bin/bash

# ⚡ DDM Quick Deploy - One-liner deployment for rapid prototyping
# Maximum keystroke efficiency as requested by @DRKV8R

# Source shared library
source "$(dirname "${BASH_SOURCE[0]}")/lib/ddm_shared.sh"

# Minimal packages for quick setup
QUICK_PACKAGES=("einops" "torchsde")

# Essential nodes only
QUICK_NODES=(
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
)

# Core models only
QUICK_MODELS=(
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors:checkpoints/flux1-dev.safetensors"
)

# One-line deployment
ddm_deploy "DDM Quick" "${QUICK_PACKAGES[@]}" && \
install_nodes "${QUICK_NODES[@]}" && \
download_models "${QUICK_MODELS[@]}" && \
log_success "⚡ Quick deployment ready in minimal time!" && wait