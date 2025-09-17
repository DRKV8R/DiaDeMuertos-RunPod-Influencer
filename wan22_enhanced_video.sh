#!/bin/bash

# WAN 2.2 Enhanced Video Models - Comparison with FLUX 1
# Based on research from FLUX 1 vs WAN 2.2 video generation capabilities
# This script includes the latest WAN 2.2 models with enhanced features

# https://github.com/DRKV8R/DiaDeMuertos-RunPod-Influencer

DEFAULT_WORKFLOW="https://raw.githubusercontent.com/kingaigfcash/aigfcash-runpod-template/refs/heads/main/workflows/default_workflow.json"

APT_PACKAGES=(
    "git"
    "python3-pip"
    "python3-venv"
    "python3-dev"
    "build-essential"
    "libgl1"
    "ffmpeg"
    "libsm6"
    "libxext6"
)

PIP_PACKAGES=(
    "torch"
    "torchvision"
    "torchaudio"
    "torchsde"
    "numpy>=1.25.0"
    "einops"
    "transformers>=4.28.1"
    "tokenizers>=0.13.3"
    "sentencepiece"
    "safetensors>=0.4.2"
    "aiohttp>=3.11.8"
    "yarl>=1.18.0"
    "pyyaml"
    "Pillow"
    "scipy"
    "tqdm"
    "psutil"
    "kornia>=0.7.1"
    "diffusers"
    "xformers"
    "comfyui-frontend-package"
    "huggingface_hub>=0.20.0"
    "accelerate"
    "opencv-python"
    "matplotlib"
    "requests"
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/Gourieff/ComfyUI-ReActor"
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
    "https://github.com/ltdrdata/ComfyUI-Impact-Subpack"
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/giriss/comfy-image-saver"
    "https://github.com/WASasquatch/was-node-suite-comfyui"
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/ltdrdata/ComfyUI-Inspire-Pack"
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    "https://github.com/twri/sdxl_prompt_styler"
    "https://github.com/melMass/comfy_mtb"
    "https://github.com/crystian/ComfyUI-Crystools"
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes"
    "https://github.com/RockOfFire/ComfyUI_Comfyroll_CustomNodes"
    "https://github.com/BadCafeCode/masquerade-nodes-comfyui"
    "https://github.com/SeargeDP/SeargeSDXL"
    "https://github.com/LEv145/images-grid-comfyui"
    "https://github.com/kijai/ComfyUI-WAN-Video-Suite"
    "https://github.com/kijai/ComfyUI-FLUX-BFL-API"
)

WORKFLOWS=(
    "https://github.com/kingaigfcash/aigfcash-runpod-template.git"
)

# Initialize empty arrays for models - Enhanced with WAN 2.2
CHECKPOINT_MODELS=(
    # FLUX.1 Models for comparison
    "https://huggingface.co/RunDiffusion/Juggernaut-XI-v11/resolve/main/Juggernaut-XI-byRunDiffusion.safetensors"
    "https://huggingface.co/John6666/epicrealism-xl-v8kiss-sdxl/resolve/main/epicrealismXL_vx1Finalkiss.safetensors"
    "https://huggingface.co/TheImposterImposters/URPM-v2.3Final/resolve/main/uberRealisticPornMerge_v23Final.safetensors"
    "https://huggingface.co/AiWise/epiCRealism-XL-vXI-aBEAST/resolve/5c3950c035ce565d0358b76805de5ef2c74be919/epicrealismXL_vxiAbeast.safetensors"
)

# FLUX.1 UNET Models for comparison
UNET_MODELS=(
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors"
)

# Enhanced CLIP Vision - WAN 2.2 compatible
CLIP_VISION=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors"
)

CLIP_MODELS=(
    # FLUX.1 text encoders for comparison
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
)

# WAN 2.2 Lightning LoRAs - Major improvement over WAN 2.1
LORA_MODELS=(
    # WAN 2.2 Lightning LoRAs for 4-step generation
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_high_noise.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_low_noise.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_t2v_lightx2v_4steps_lora_v1.1_high_noise.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_t2v_lightx2v_4steps_lora_v1.1_low_noise.safetensors"
)

CONTROLNET_MODELS=()
ESRGAN_MODELS=()

# Enhanced Text Encoders - WAN 2.2 compatible
TEXT_ENCODER_MODELS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
)

# Enhanced VAE Models - WAN 2.2 with improved quality
VAE_MODELS=(
    # WAN 2.2 VAE - Enhanced quality over WAN 2.1
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors"
    # FLUX.1 VAE for comparison
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors"
    # Keep WAN 2.1 VAE for backward compatibility
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
)

# WAN 2.2 Enhanced Diffusion Models - Major improvements over WAN 2.1
DIFFUSION_MODELS=(
    # Text-to-Video Models - High and Low Noise variants
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp8_scaled.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp8_scaled.safetensors"
    
    # Image-to-Video Models - High and Low Noise variants
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors"
    
    # NEW: Sound-to-Video Models (WAN 2.2 exclusive feature)
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_s2v_14B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_s2v_14B_fp8_scaled.safetensors"
    
    # NEW: Fun Camera Models (WAN 2.2 exclusive feature)
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_camera_high_noise_14B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_camera_low_noise_14B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_camera_high_noise_14B_fp8_scaled.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_camera_low_noise_14B_fp8_scaled.safetensors"
    
    # NEW: Fun Control Models (WAN 2.2 exclusive feature)
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_control_5B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_control_high_noise_14B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_control_low_noise_14B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_control_high_noise_14B_fp8_scaled.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_control_low_noise_14B_fp8_scaled.safetensors"
    
    # NEW: Fun Inpaint Models (WAN 2.2 exclusive feature)
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_inpaint_5B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_inpaint_high_noise_14B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_inpaint_low_noise_14B_bf16.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_inpaint_high_noise_14B_fp8_scaled.safetensors"
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_fun_inpaint_low_noise_14B_fp8_scaled.safetensors"
    
    # NEW: Text+Image-to-Video Model (WAN 2.2 exclusive feature)
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors"
)

# Audio Encoders - New in WAN 2.2
AUDIO_ENCODER_MODELS=(
    "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/audio_encoders/wav2vec2_large_english_fp16.safetensors"
)

INSIGHTFACE_MODELS=(
    "https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/inswapper_128.onnx"
)

# Ultralytics models (YOLOv8)
ULTRALYTICS_BBOX_MODELS=(
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
)

ULTRALYTICS_SEGM_MODELS=(
    "https://github.com/ultralytics/assets/releases/download/v0.0.0/yolov8m-seg.pt"
)

SAM_MODELS=(
    "https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    if [[ ! -d /opt/environments/python ]]; then 
        export MAMBA_ROOT_PREFIX=/opt/micromamba
        export MAMBA_EXE=/opt/micromamba/bin/micromamba
        export MAMBA_ROOT_PREFIX_FILE=/opt/micromamba/pfile
        eval "$(micromamba shell hook -s posix)"
        micromamba activate comfyui
    fi
    DISK_GB_AVAILABLE=$(($(df --output=avail -m "${WORKSPACE}" | tail -n1) / 1000))
    DISK_GB_USED=$(($(df --output=used -m "${WORKSPACE}" | tail -n1) / 1000))
    DISK_GB_ALLOCATED=$(($DISK_GB_AVAILABLE + $DISK_GB_USED))
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_pip_packages
    provisioning_get_nodes
    provisioning_get_workflows
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/checkpoints" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip_vision" \
        "${CLIP_VISION[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip" \
        "${CLIP_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/loras" \
        "${LORA_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/upscale_models" \
        "${ESRGAN_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/text_encoders" \
        "${TEXT_ENCODER_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/diffusion_models" \
        "${DIFFUSION_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/audio_encoders" \
        "${AUDIO_ENCODER_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/insightface" \
        "${INSIGHTFACE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/ultralytics/bbox" \
        "${ULTRALYTICS_BBOX_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/ultralytics/segm" \
        "${ULTRALYTICS_SEGM_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/sams" \
        "${SAM_MODELS[@]}"
    provisioning_print_end
}

# Normalize path to remove any double slashes
normalize_path() {
    echo "${1//\/\///}"
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
    printf "🎬 WAN 2.2 Enhanced Video Models vs FLUX 1\n"
    printf "✨ Features: Fun Camera, Fun Control, Fun Inpaint, Sound-to-Video\n"
    printf "⚡ Lightning LoRAs for 4-step generation\n"
    printf "🎯 High/Low noise variants for optimal quality\n\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        printf "WARNING: Your allocated disk size (%sGB) is below the recommended %sGB - Some models will not be downloaded\n" "$DISK_GB_ALLOCATED" "$DISK_GB_REQUIRED"
    fi
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Web UI will start now\n\n"
    printf "🎭 WAN 2.2 vs FLUX 1 Video Generation Ready!\n"
    printf "📁 Models downloaded to: /workspace/ComfyUI/models/\n"
    printf "🎨 ComfyUI: http://localhost:8188\n"
    printf "\n🚀 WAN 2.2 Improvements over WAN 2.1:\n"
    printf "   • Fun Camera models for dynamic camera movements\n"
    printf "   • Fun Control models for precise motion control\n" 
    printf "   • Fun Inpaint models for video editing\n"
    printf "   • Sound-to-Video generation (S2V)\n"
    printf "   • Text+Image-to-Video (TI2V)\n"
    printf "   • Lightning LoRAs for 4x faster generation\n"
    printf "   • Enhanced VAE for better quality\n"
    printf "   • High/Low noise variants for optimal results\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "User-Agent: AutoDL")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
        sudo $APT_FRONTEND apt-get update
        sudo $APT_FRONTEND apt-get install -y ${APT_PACKAGES[*]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
        micromamba run -n comfyui pip install --upgrade ${PIP_PACKAGES[*]}
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="/opt/ComfyUI/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                    micromamba run -n comfyui pip install -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                micromamba run -n comfyui pip install -r "$requirements"
            fi
        fi
    done
}

function provisioning_get_workflows() {
    for workflow in "${WORKFLOWS[@]}"; do
        local workflow_path="${WORKSPACE}/ComfyUI/user/default/workflows/${workflow##*/}"
        if [[ -d $workflow_path ]]; then
            ( cd "$workflow_path" && git pull )
        else
            mkdir -p "${workflow_path}"
            git clone "${workflow}" "${workflow_path}"
        fi
    done
}

function provisioning_get_models() {
    local target_dir="$1"
    shift
    local models=("$@")
    
    printf "📁 Downloading models to: %s\n" "$target_dir"
    mkdir -p "$target_dir"
    
    for model_url in "${models[@]}"; do
        if [[ -n $model_url ]]; then
            model_name=$(basename "$model_url")
            model_path=$(normalize_path "${target_dir}/${model_name}")
            
            if [[ -f "$model_path" ]]; then
                printf "✅ Model exists: %s\n" "$model_name"
            else
                printf "⬇️  Downloading: %s\n" "$model_name"
                aria2c -x 5 -s 5 --file-allocation=none --retry-wait=1 --max-tries=3 --max-connection-per-server=5 --split=5 --conditional-get=true --allow-overwrite=true -d "$target_dir" -o "$model_name" "$model_url"
                if [[ $? -eq 0 ]]; then
                    printf "✅ Downloaded: %s\n" "$model_name"
                else
                    printf "❌ Failed: %s\n" "$model_name"
                fi
            fi
        fi
    done
}

provisioning_start