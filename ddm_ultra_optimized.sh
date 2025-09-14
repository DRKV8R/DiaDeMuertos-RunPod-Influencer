#!/bin/bash

# 🎭 DDM Ultra Optimized - Minimal, Fast, Intelligent Deployment
# Uses shared library for maximum efficiency and minimal code duplication
# Optimized for @DRKV8R keystroke efficiency

set -euo pipefail

# Source shared library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/ddm_shared.sh"

# DDM-specific additional packages
DDM_PACKAGES=(
    "einops==0.8.0"
    "torchsde==0.2.6" 
    "kornia>=0.7.3"
    "tokenizers>=0.19.1"
    "sentencepiece==0.2.0"
)

# DDM-specific nodes for influencer generation
DDM_NODES=(
    # Portrait and face processing
    "https://github.com/chflame163/ComfyUI_LayerStyle"
    "https://github.com/Gourieff/ComfyUI-ReActor"
    "https://github.com/cubiq/ComfyUI_FaceAnalysis"
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
    
    # Advanced AI features
    "https://github.com/1038lab/ComfyUI-JoyCaption"
    "https://github.com/kijai/ComfyUI-Florence2"
    "https://github.com/pythongosssss/ComfyUI-WD14-Tagger"
    
    # Video capabilities (optional)
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    
    # Utilities
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    "https://github.com/crystian/ComfyUI-Crystools"
)

# DDM-specific models for influencer generation
DDM_MODELS=(
    # FLUX.1 for high-quality generation
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors:checkpoints/flux1-dev.safetensors"
    
    # T5 for text encoding
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors:clip/t5xxl_fp16.safetensors"
    
    # ControlNet for pose control
    "https://huggingface.co/lllyasviel/control_v11p_sd15_openpose/resolve/main/diffusion_pytorch_model.safetensors:controlnet/control_v11p_sd15_openpose.safetensors"
    
    # Face restoration
    "https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/facerestore_models/GFPGANv1.4.pth:facerestore_models/GFPGANv1.4.pth"
)

# Main execution using shared library
main() {
    # Use the shared deployment function with DDM-specific configurations
    ddm_deploy "DDM Ultra Optimized" "${DDM_PACKAGES[@]}"
    
    # Install DDM-specific nodes
    log_info "🎭 Installing DDM-specific nodes..."
    install_nodes "${DDM_NODES[@]}"
    
    # Download DDM-specific models
    log_info "💀 Downloading DDM models..."
    download_models "${DDM_MODELS[@]}"
    
    # Final message
    log_success "🎭 DDM Ultra Optimized deployment ready!"
    log_info "🌐 ComfyUI: http://localhost:8188"
    log_info "🎨 Perfect for Día de Muertos AI influencer generation"
    
    # Keep running
    wait
}

# Execute if run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi