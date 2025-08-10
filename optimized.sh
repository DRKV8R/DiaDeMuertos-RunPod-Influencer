# This file will be sourced in default.sh

# https://github.com/kingaigfcash/aigfcash-runpod-template

# Packages are installed after nodes

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
)

NODES=(
	"https://github.com/ltdrdata/ComfyUI-Manager"
	"https://github.com/cubiq/ComfyUI_essentials"
	"https://github.com/Gourieff/ComfyUI-ReActor"
	"https://github.com/ltdrdata/ComfyUI-Impact-Pack"
	"https://github.com/ltdrdata/ComfyUI-Impact-Subpack"
	"https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
	"https://github.com/giriss/comfy-image-saver"
	"https://github.com/pythongosssss/ComfyUI-WD14-Tagger"
	"https://github.com/hylarucoder/comfyui-copilot"
	"https://github.com/kijai/ComfyUI-KJNodes"
	"https://github.com/KoreTeknology/ComfyUI-Universal-Styler"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    "https://github.com/mpiquero1111/ComfyUI-SaveImgPrompt"
    "https://github.com/melMass/comfy_mtb"
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    "https://github.com/if-ai/ComfyUI_IF_AI_LoadImages"
    "https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes"
    "https://github.com/shiimizu/ComfyUI-TiledDiffusion"
    "https://github.com/BadCafeCode/masquerade-nodes-comfyui"
    "https://github.com/city96/ComfyUI_ExtraModels"
    "https://github.com/city96/ComfyUI-GGUF"
    "https://github.com/Ryuukeisyou/comfyui_face_parsing"
    "https://github.com/chflame163/ComfyUI_LayerStyle"
    "https://github.com/chflame163/ComfyUI_LayerStyle_Advance"
    "https://github.com/cubiq/ComfyUI_FaceAnalysis"
    "https://github.com/chrisgoringe/cg-use-everywhere"
    "https://github.com/jakechai/ComfyUI-JakeUpgrade"
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/0xbitches/ComfyUI-LCM"
    "https://github.com/flowtyone/ComfyUI-Flowty-LDSR"	
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/un-seen/comfyui-tensorops"
    "https://github.com/glifxyz/ComfyUI-GlifNodes"
    "https://github.com/EllangoK/ComfyUI-post-processing-nodes"
    "https://github.com/sipherxyz/comfyui-art-venture"
    "https://github.com/storyicon/comfyui_segment_anything"
    "https://github.com/kijai/ComfyUI-Florence2"
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/hay86/ComfyUI_LatentSync"
    "https://github.com/pamparamm/sd-perturbed-attention"
    "https://github.com/WASasquatch/was-node-suite-comfyui"
)

WORKFLOWS=(
	"https://github.com/kingaigfcash/aigfcash-runpod-template.git"
)

# Initialize empty arrays for models
CHECKPOINT_MODELS=(
    "https://huggingface.co/kingcashflow/modelcheckpoints/resolve/main/AIIM_Realism.safetensors"
    "https://huggingface.co/kingcashflow/modelcheckpoints/resolve/main/AIIM_Realism_FAST.safetensors"
    "https://huggingface.co/kingcashflow/modelcheckpoints/resolve/main/uberRealisticPornMergePonyxl_ponyxlHybridV1.safetensors"
    "https://huggingface.co/AiWise/epiCRealism-XL-vXI-aBEAST/resolve/5c3950c035ce565d0358b76805de5ef2c74be919/epicrealismXL_vxiAbeast.safetensors"
)
UNET_MODELS=(
    
)
VAE_MODELS=(
    "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/diffusion_pytorch_model.safetensors"
)

CLIP_MODELS=(
)

LORA_MODELS=(
	"https://huggingface.co/kingcashflow/LoRas/resolve/main/depth_of_field_slider_v1.safetensors"
	"https://huggingface.co/kingcashflow/LoRas/resolve/main/zoom_slider_v1.safetensors"
	"https://huggingface.co/kingcashflow/LoRas/resolve/main/add_detail.safetensors"
    "https://huggingface.co/kingcashflow/underboobXL/resolve/main/UnderboobXL.safetensors"

)

CONTROLNET_MODELS=(
    "https://huggingface.co/xinsir/controlnet-openpose-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors"
    "https://huggingface.co/xinsir/controlnet-depth-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors"
)
ESRGAN_MODELS=()
INSIGHTFACE_MODELS=(
    "https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/inswapper_128.onnx"
)

# Ultralytics models (YOLOv8)
ULTRALYTICS_BBOX_MODELS=(
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
    "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8n.pt"
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8n_v2.pt"
    "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov9c.pt"
    "https://huggingface.co/kingcashflow/underboobXL/resolve/main/Eyeful_v2-Individual.pt"
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
        export MAMBA_BASE=true
    fi
    source /opt/ai-dock/etc/environment.sh
    source /opt/ai-dock/bin/venv-set.sh comfyui

    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages

    # Create model directories
    mkdir -p "${WORKSPACE}/ComfyUI/models/checkpoints"
    mkdir -p "${WORKSPACE}/ComfyUI/models/ultralytics/bbox"
    mkdir -p "${WORKSPACE}/ComfyUI/models/ultralytics/segm"
    mkdir -p "${WORKSPACE}/ComfyUI/models/sams"
    mkdir -p "${WORKSPACE}/ComfyUI/models/insightface"

    # Download models to appropriate directories
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/checkpoints" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/clip" \
        "${CLIP_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/lora" \
        "${LORA_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/ultralytics/bbox" \
        "${ULTRALYTICS_BBOX_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/ultralytics/segm" \
        "${ULTRALYTICS_SEGM_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/sams" \
        "${SAM_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/insightface" \
        "${INSIGHTFACE_MODELS[@]}"
    provisioning_get_workflows
    provisioning_print_end
    start_additional_downloads
}

function pip_install() {
    if [[ -z $MAMBA_BASE ]]; then
            "$COMFYUI_VENV_PIP" install --no-cache-dir "$@"
        else
            micromamba run -n comfyui pip install --no-cache-dir "$@"
        fi
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip_install ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_nodes() {
    printf "Installing build tools...\n"
    sudo apt-get update && sudo apt-get install -y build-essential

    pip_install --upgrade pip setuptools wheel

    printf "Installing torchsde, a dependency for sd-perturbed-attention...\n"
    pip_install torchsde

    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${WORKSPACE}/ComfyUI/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        
        # Update existing node
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip_install -r "$requirements"
                fi
                if [[ -e "${path}/pyproject.toml" ]] || [[ -e "${path}/setup.py" ]]; then
                    printf "Installing package in: %s\n" "${path}"
                    pip_install "${path}"
                fi
            fi
        # Download new node
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip_install -r "$requirements"
            fi
            if [[ -e "${path}/pyproject.toml" ]] || [[ -e "${path}/setup.py" ]]; then
                printf "Installing package in: %s\n" "${path}"
                pip_install "${path}"
            fi
        fi
    done

    printf "Updating comfyui-frontend-package...\n"
    pip_install --upgrade comfyui-frontend-package
}

function provisioning_get_workflows() {
    for repo in "${WORKFLOWS[@]}"; do
        dir=$(basename "$repo" .git)
        temp_path="/tmp/${dir}"
        target_path="${WORKSPACE}/ComfyUI/user/default/workflows"
        
        # Clone or update the repository
        if [[ -d "$temp_path" ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating workflows: %s...\n" "${repo}"
                ( cd "$temp_path" && git pull )
            fi
        else
            printf "Cloning workflows: %s...\n" "${repo}"
            git clone "$repo" "$temp_path"
        fi
        
        # Create workflows directory if it does not exist
        mkdir -p "$target_path"
        
        # Copy workflow files to the target directory
        if [[ -d "$temp_path/workflows" ]]; then
            cp -r "$temp_path/workflows"/* "$target_path/"
            printf "Copied workflows to: %s\n" "$target_path"
        fi
    done
}

function provisioning_get_default_workflow() {
    if [[ -n $DEFAULT_WORKFLOW ]]; then
        workflow_json=$(curl -s "$DEFAULT_WORKFLOW")
        if [[ -n $workflow_json ]]; then
            echo "export const defaultGraph = $workflow_json;" > "${WORKSPACE}/ComfyUI/web/scripts/defaultGraph.js"
        fi
    fi
}

function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi
    dir=$(normalize_path "$1")
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

# Normalize path to remove any double slashes
normalize_path() {
    echo "${1//\/\///}"
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        printf "WARNING: Your allocated disk size (%sGB) is below the recommended %sGB - Some models will not be downloaded\n" "$DISK_GB_ALLOCATED" "$DISK_GB_REQUIRED"
    fi
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Web UI will start now\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    local url="$1"
    local target_dir="$2"
    local auth_token=""
    local filename=""

    # Normalize target directory path
    target_dir=$(normalize_path "$target_dir")
    
    # Set up authentication if needed
    if [[ $url =~ ^https://huggingface.co ]]; then
        auth_token="$HF_TOKEN"
        echo "Using HuggingFace token"
    elif [[ $url =~ ^https://civitai.com ]]; then
        auth_token="$CIVITAI_TOKEN"
        echo "Using CivitAI token"
        
        # For CivitAI, get the actual filename from headers
        if [[ $url =~ /api/download/models/([0-9]+) ]]; then
            local model_id="${BASH_REMATCH[1]}"
            echo "Detected CivitAI model ID: $model_id"
            
            # Get the filename from Content-Disposition header
            local headers=$(curl -sI -H "Authorization: Bearer $CIVITAI_TOKEN" "$url")
            if [[ $headers =~ Content-Disposition:.*filename=\"?([^\";\r\n]+) ]]; then
                filename="${BASH_REMATCH[1]}"
            else
                # Fallback: Try to get filename from redirect URL
                local redirect_url=$(curl -sI -H "Authorization: Bearer $CIVITAI_TOKEN" "$url" | grep -i "^location:" | cut -d' ' -f2 | tr -d '\r')
                if [[ -n "$redirect_url" ]]; then
                    filename=$(basename "$redirect_url")
                else
                    # Last resort fallback
                    filename="model_${model_id}.safetensors"
                fi
            fi
            echo "Will save as: $filename"
        fi
    fi

    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"

    # Get filename from URL if not already set (for non-CivitAI URLs)
    if [[ -z $filename ]]; then
        filename=$(basename "$url")
        if [[ -z $filename ]]; then
            echo "ERROR: Could not determine filename from URL"
            return 1
        fi
    fi

    # Full path to target file
    local target_file="$target_dir/$filename"
    
    # Check if file already exists and has content
    if [[ -f "$target_file" ]] && [[ -s "$target_file" ]]; then
        echo "File already exists and is not empty: $target_file"
        echo "Skipping download..."
        return 0
    fi

    # Download the file using curl with minimal output
    echo "Downloading to: $target_file"
    if [[ -n $auth_token ]]; then
        echo "Downloading with authentication..."
        curl -sS -L -H "Authorization: Bearer $auth_token" -o "$target_file" "$url"
    else
        echo "Downloading without authentication..."
        curl -sS -L -o "$target_file" "$url"
    fi

    # Verify the download
    if [[ ! -f "$target_file" ]] || [[ ! -s "$target_file" ]]; then
        echo "ERROR: Download failed or file is empty"
        return 1
    fi

    echo "Download completed successfully"
    return 0
}

if provisioning_has_valid_hf_token; then
    echo "Downloading bbox models..."
    for url in "${ULTRALYTICS_BBOX_MODELS[@]}"; do
        filename="face_yolov8m.pt"  # Fixed filename for bbox
        target_dir="$WORKSPACE/ComfyUI/models/ultralytics/bbox"
        if ! provisioning_download "$url" "$target_dir"; then
            echo "ERROR: Failed to download bbox model"
            continue
        fi
    done

    echo "Downloading segm models..."
    for url in "${ULTRALYTICS_SEGM_MODELS[@]}"; do
        filename="yolov8m-seg.pt"  # Fixed filename for segm
        target_dir="$WORKSPACE/ComfyUI/models/ultralytics/segm"
        if ! provisioning_download "$url" "$target_dir"; then
            echo "ERROR: Failed to download segm model"
            continue
        fi
    done

    echo "Starting SAM models download..."
    echo "Downloading $(echo ${SAM_MODELS[@]} | wc -w) model(s) to $WORKSPACE/ComfyUI/models/sams..."
    for url in "${SAM_MODELS[@]}"; do
        provisioning_download "$url" "$WORKSPACE/ComfyUI/models/sams"
    done
    
    echo "Starting Insightface models download..."
    echo "Downloading $(echo ${INSIGHTFACE_MODELS[@]} | wc -w) model(s) to $WORKSPACE/ComfyUI/models/insightface..."
    for url in "${INSIGHTFACE_MODELS[@]}"; do
        provisioning_download "$url" "$WORKSPACE/ComfyUI/models/insightface"
    done
else
    echo "ERROR: Invalid Hugging Face token. Cannot download models."
fi

provisioning_start