#!/bin/bash

# 🎭 Día de Muertos RunPod Influencer - Modern Optimized Deployment
# Enhanced with @DRKV8R/ENDS automation and latest dependencies
# Version: 2.0.0

set -euo pipefail

# Color output for better UX
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${CYAN}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Configuration
COMFYUI_REPO="https://github.com/comfyanonymous/ComfyUI"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="/workspace"
COMFYUI_DIR="${WORKSPACE_DIR}/ComfyUI"
MODELS_DIR="${COMFYUI_DIR}/models"
CUSTOM_NODES_DIR="${COMFYUI_DIR}/custom_nodes"

# Latest Python packages with optimized versions
PYTHON_PACKAGES=(
    # PyTorch ecosystem - Latest stable with CUDA 12.1
    "torch==2.4.0+cu121 torchvision==0.19.0+cu121 torchaudio==2.4.0+cu121 --extra-index-url https://download.pytorch.org/whl/cu121"
    "xformers==0.0.27.post2"
    "accelerate>=0.33.0"
    
    # Core ML libraries
    "transformers>=4.44.0"
    "diffusers>=0.30.0"
    "safetensors>=0.4.4"
    "tokenizers>=0.19.1"
    "sentencepiece==0.2.0"
    "huggingface_hub>=0.24.0"
    
    # Scientific computing
    "numpy>=1.26.0"
    "scipy>=1.14.0"
    "opencv-python>=4.10.0"
    "Pillow>=10.4.0"
    "matplotlib>=3.9.0"
    "einops==0.8.0"
    "kornia>=0.7.3"
    
    # Utilities and performance
    "aiohttp>=3.10.0"
    "requests>=2.32.0"
    "tqdm>=4.66.0"
    "psutil>=6.0.0"
    "pyyaml==6.0.1"
    "rich>=13.7.1"
    "websockets>=12.0"
)

# Essential ComfyUI nodes for DDM workflow
COMFYUI_NODES=(
    # Core management
    "https://github.com/ltdrdata/ComfyUI-Manager"
    
    # Portrait and face processing
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/chflame163/ComfyUI_LayerStyle"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/Gourieff/ComfyUI-ReActor"
    "https://github.com/cubiq/ComfyUI_FaceAnalysis"
    "https://github.com/Ryuukeisyou/comfyui_face_parsing"
    
    # Image enhancement and upscaling
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    "https://github.com/Jordach/ComfyUI-Detail-Daemon"
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
    "https://github.com/ltdrdata/ComfyUI-Impact-Subpack"
    
    # Control and workflow
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/WASasquatch/was-node-suite-comfyui"
    
    # AI analysis and captioning
    "https://github.com/1038lab/ComfyUI-JoyCaption"
    "https://github.com/kijai/ComfyUI-Florence2"
    "https://github.com/pythongosssss/ComfyUI-WD14-Tagger"
    
    # Video capabilities
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/kijai/ComfyUI-WanVideoWrapper"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    
    # Utilities
    "https://github.com/crystian/ComfyUI-Crystools"
    "https://github.com/giriss/comfy-image-saver"
    "https://github.com/yolain/ComfyUI-Easy-Use"
)

# Essential models for DDM influencer generation
ESSENTIAL_MODELS=(
    # FLUX models
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors:checkpoints/flux1-dev.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors:clip/clip_l.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors:clip/t5xxl_fp16.safetensors"
    
    # VAE
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors:vae/ae.safetensors"
    
    # ControlNet for poses
    "https://huggingface.co/lllyasviel/control_v11p_sd15_openpose/resolve/main/diffusion_pytorch_model.safetensors:controlnet/control_v11p_sd15_openpose.safetensors"
    
    # Upscaler models
    "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x-UltraSharp.pth:upscale_models/4x-UltraSharp.pth"
)

# Functions
print_banner() {
    echo -e "${PURPLE}"
    cat << "EOF"
    ╔══════════════════════════════════════════════════════════════╗
    ║                  🎭 Día de Muertos RunPod                    ║
    ║                   AI Influencer Platform                     ║
    ║                      Version 2.0.0                          ║
    ║                                                              ║
    ║              Enhanced with @DRKV8R/ENDS Agent               ║
    ╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
}

check_gpu() {
    log_info "🔍 Checking GPU availability..."
    if command -v nvidia-smi &> /dev/null; then
        nvidia-smi --list-gpus
        log_success "GPU detected and available"
    else
        log_warning "No GPU detected or nvidia-smi not available"
    fi
}

setup_python_environment() {
    log_info "🐍 Setting up Python environment..."
    
    # Update system packages
    apt-get update -qq
    apt-get install -y python3-pip python3-venv python3-dev build-essential \
                      git curl wget ffmpeg libgl1 libsm6 libxext6 \
                      libglib2.0-0 libxrender1 libgomp1
    
    # Create virtual environment if it doesn't exist
    if [ ! -d "${WORKSPACE_DIR}/venv" ]; then
        python3 -m venv "${WORKSPACE_DIR}/venv"
    fi
    
    source "${WORKSPACE_DIR}/venv/bin/activate"
    
    # Upgrade pip
    pip install --upgrade pip setuptools wheel
    
    log_success "Python environment ready"
}

install_python_packages() {
    log_info "📦 Installing Python packages..."
    
    source "${WORKSPACE_DIR}/venv/bin/activate"
    
    # Install packages with progress
    for package in "${PYTHON_PACKAGES[@]}"; do
        log_info "Installing: $(echo $package | cut -d'=' -f1)"
        pip install $package --no-cache-dir
    done
    
    log_success "All Python packages installed"
}

clone_comfyui() {
    log_info "⬇️ Setting up ComfyUI..."
    
    if [ ! -d "$COMFYUI_DIR" ]; then
        git clone "$COMFYUI_REPO" "$COMFYUI_DIR"
        cd "$COMFYUI_DIR"
        
        # Install ComfyUI requirements
        source "${WORKSPACE_DIR}/venv/bin/activate"
        pip install -r requirements.txt --no-cache-dir
    else
        log_info "ComfyUI already exists, updating..."
        cd "$COMFYUI_DIR"
        git pull
    fi
    
    log_success "ComfyUI setup complete"
}

install_custom_nodes() {
    log_info "🔌 Installing custom nodes..."
    
    cd "$CUSTOM_NODES_DIR"
    source "${WORKSPACE_DIR}/venv/bin/activate"
    
    for node_url in "${COMFYUI_NODES[@]}"; do
        node_name=$(basename "$node_url" .git)
        log_info "Installing node: $node_name"
        
        if [ ! -d "$node_name" ]; then
            git clone "$node_url" "$node_name"
        else
            log_info "Node $node_name already exists, updating..."
            cd "$node_name"
            git pull
            cd ..
        fi
        
        # Install node requirements if they exist
        if [ -f "$node_name/requirements.txt" ]; then
            pip install -r "$node_name/requirements.txt" --no-cache-dir
        fi
        
        # Install with setup.py if available
        if [ -f "$node_name/setup.py" ]; then
            cd "$node_name"
            pip install -e . --no-cache-dir
            cd ..
        fi
    done
    
    log_success "Custom nodes installation complete"
}

download_models() {
    log_info "📥 Downloading essential models..."
    
    mkdir -p "$MODELS_DIR"/{checkpoints,clip,vae,controlnet,upscale_models,loras}
    
    for model_info in "${ESSENTIAL_MODELS[@]}"; do
        url=$(echo "$model_info" | cut -d':' -f1)
        path=$(echo "$model_info" | cut -d':' -f2)
        full_path="$MODELS_DIR/$path"
        
        if [ ! -f "$full_path" ]; then
            log_info "Downloading: $(basename "$path")"
            mkdir -p "$(dirname "$full_path")"
            wget -q --show-progress -O "$full_path" "$url"
        else
            log_info "Model already exists: $(basename "$path")"
        fi
    done
    
    log_success "Essential models downloaded"
}

setup_interface() {
    log_info "🌐 Setting up web interface..."
    
    cd "$SCRIPT_DIR"
    
    # Install Node.js if not present
    if ! command -v node &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
        apt-get install -y nodejs
    fi
    
    # Install interface dependencies
    if [ -f "package.json" ]; then
        npm install
        
        # Build CSS and JS
        npx tailwindcss -i interface/src/styles.css -o interface/dist/styles.css --minify
        cp interface/src/app.js interface/dist/app.js
    fi
    
    log_success "Web interface ready"
}

start_ends_agent() {
    log_info "🤖 Starting @DRKV8R/ENDS automation agent..."
    
    cd "$SCRIPT_DIR"
    source "${WORKSPACE_DIR}/venv/bin/activate"
    
    # Start ENDS agent in background
    python3 agents/ends_agent.py &
    echo $! > agents/ends.pid
    
    log_success "@DRKV8R/ENDS agent started"
}

start_services() {
    log_info "🚀 Starting services..."
    
    cd "$SCRIPT_DIR"
    source "${WORKSPACE_DIR}/venv/bin/activate"
    
    # Start web interface
    node interface/server.js &
    echo $! > interface/server.pid
    
    # Start ComfyUI
    cd "$COMFYUI_DIR"
    python main.py --listen 0.0.0.0 --port 8188 &
    echo $! > comfyui.pid
    
    log_success "All services started"
    log_info "🌐 Web Interface: http://localhost:3000"
    log_info "🎨 ComfyUI: http://localhost:8188"
}

cleanup() {
    log_info "🧹 Cleaning up..."
    
    # Kill background processes
    [ -f agents/ends.pid ] && kill $(cat agents/ends.pid) 2>/dev/null || true
    [ -f interface/server.pid ] && kill $(cat interface/server.pid) 2>/dev/null || true
    [ -f "$COMFYUI_DIR/comfyui.pid" ] && kill $(cat "$COMFYUI_DIR/comfyui.pid") 2>/dev/null || true
    
    log_success "Cleanup complete"
}

# Trap signals for cleanup
trap cleanup EXIT

# Main execution
main() {
    print_banner
    check_gpu
    setup_python_environment
    install_python_packages
    clone_comfyui
    install_custom_nodes
    download_models
    setup_interface
    start_ends_agent
    start_services
    
    log_success "🎉 Día de Muertos RunPod deployment complete!"
    log_info "📖 Check the web interface for deployment status and logs"
    
    # Keep script running
    wait
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi