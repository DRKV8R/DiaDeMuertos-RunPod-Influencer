#!/bin/bash

# 🎭 DDM Shared Library - Common functions for all deployment scripts
# Version: 2.0.0 - Optimized and minimal

# Color definitions
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export NC='\033[0m'

# Global configuration
export WORKSPACE_DIR="${WORKSPACE_DIR:-/workspace}"
export COMFYUI_REPO="https://github.com/comfyanonymous/ComfyUI"
export COMFYUI_DIR="${WORKSPACE_DIR}/ComfyUI"
export MODELS_DIR="${COMFYUI_DIR}/models"
export CUSTOM_NODES_DIR="${COMFYUI_DIR}/custom_nodes"

# Logging functions
log_info() { echo -e "${CYAN}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Common Python packages for all deployments
COMMON_PYTHON_PACKAGES=(
    # PyTorch ecosystem - Latest stable
    "torch==2.4.0+cu121 torchvision==0.19.0+cu121 torchaudio==2.4.0+cu121 --extra-index-url https://download.pytorch.org/whl/cu121"
    "xformers==0.0.27.post2"
    "accelerate>=0.33.0"
    
    # Core AI libraries
    "transformers>=4.44.0"
    "diffusers>=0.30.0"
    "safetensors>=0.4.4"
    "huggingface_hub>=0.24.0"
    
    # Essential utilities
    "numpy>=1.26.0"
    "Pillow>=10.4.0"
    "opencv-python>=4.10.0"
    "requests>=2.32.0"
    "tqdm>=4.66.0"
    "aiohttp>=3.10.0"
    "pyyaml==6.0.1"
)

# Essential ComfyUI nodes for all deployments
ESSENTIAL_NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/WASasquatch/was-node-suite-comfyui"
)

# Core model URLs
CORE_MODELS=(
    # Essential CLIP and VAE
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors:clip/clip_l.safetensors"
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors:vae/ae.safetensors"
    
    # Basic upscaler
    "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x-UltraSharp.pth:upscale_models/4x-UltraSharp.pth"
)

# Utility functions
check_command() {
    if ! command -v "$1" &> /dev/null; then
        log_error "Command '$1' not found"
        return 1
    fi
    return 0
}

setup_workspace() {
    log_info "🏗️ Setting up workspace..."
    mkdir -p "$WORKSPACE_DIR" "$MODELS_DIR" "$CUSTOM_NODES_DIR"
    cd "$WORKSPACE_DIR"
    log_success "Workspace ready at $WORKSPACE_DIR"
}

install_system_deps() {
    log_info "📦 Installing system dependencies..."
    apt-get update -qq
    apt-get install -y git python3-pip python3-venv python3-dev build-essential \
                      curl wget ffmpeg libgl1 libsm6 libxext6 &>/dev/null
    log_success "System dependencies installed"
}

setup_python_env() {
    log_info "🐍 Setting up Python environment..."
    
    if [ ! -d "${WORKSPACE_DIR}/venv" ]; then
        python3 -m venv "${WORKSPACE_DIR}/venv"
    fi
    
    source "${WORKSPACE_DIR}/venv/bin/activate"
    pip install --upgrade pip setuptools wheel --quiet
    log_success "Python environment ready"
}

install_python_packages() {
    local packages=("${COMMON_PYTHON_PACKAGES[@]}" "$@")
    
    log_info "📚 Installing Python packages..."
    source "${WORKSPACE_DIR}/venv/bin/activate"
    
    for package in "${packages[@]}"; do
        log_info "Installing: $(echo $package | cut -d'=' -f1 | cut -d' ' -f1)"
        pip install $package --no-cache-dir --quiet
    done
    
    log_success "Python packages installed"
}

clone_comfyui() {
    if [ ! -d "$COMFYUI_DIR" ]; then
        log_info "⬇️ Cloning ComfyUI..."
        git clone "$COMFYUI_REPO" "$COMFYUI_DIR" --quiet
        cd "$COMFYUI_DIR"
        source "${WORKSPACE_DIR}/venv/bin/activate"
        pip install -r requirements.txt --no-cache-dir --quiet
        log_success "ComfyUI cloned and configured"
    else
        log_info "ComfyUI already exists, updating..."
        cd "$COMFYUI_DIR"
        git pull --quiet
        log_success "ComfyUI updated"
    fi
}

install_node() {
    local node_url="$1"
    local node_name=$(basename "$node_url" .git)
    
    cd "$CUSTOM_NODES_DIR"
    
    if [ ! -d "$node_name" ]; then
        git clone "$node_url" "$node_name" --quiet
    else
        cd "$node_name" && git pull --quiet && cd ..
    fi
    
    # Install node requirements
    if [ -f "$node_name/requirements.txt" ]; then
        source "${WORKSPACE_DIR}/venv/bin/activate"
        pip install -r "$node_name/requirements.txt" --no-cache-dir --quiet
    fi
}

install_nodes() {
    local nodes=("${ESSENTIAL_NODES[@]}" "$@")
    
    log_info "🔌 Installing ComfyUI nodes..."
    
    for node_url in "${nodes[@]}"; do
        install_node "$node_url"
    done
    
    log_success "ComfyUI nodes installed"
}

download_model() {
    local model_info="$1"
    local url=$(echo "$model_info" | cut -d':' -f1)
    local path=$(echo "$model_info" | cut -d':' -f2)
    local full_path="$MODELS_DIR/$path"
    
    if [ ! -f "$full_path" ]; then
        log_info "Downloading: $(basename "$path")"
        mkdir -p "$(dirname "$full_path")"
        wget -q --show-progress -O "$full_path" "$url" || {
            log_warning "Failed to download $(basename "$path"), skipping..."
            rm -f "$full_path"
        }
    fi
}

download_models() {
    local models=("${CORE_MODELS[@]}" "$@")
    
    log_info "📥 Downloading models..."
    
    for model_info in "${models[@]}"; do
        download_model "$model_info"
    done
    
    log_success "Models downloaded"
}

start_comfyui() {
    local port="${1:-8188}"
    local host="${2:-0.0.0.0}"
    
    log_info "🚀 Starting ComfyUI on $host:$port"
    cd "$COMFYUI_DIR"
    source "${WORKSPACE_DIR}/venv/bin/activate"
    
    # Start ComfyUI with optimizations
    python main.py --listen "$host" --port "$port" \
                   --disable-smart-memory \
                   --preview-method auto &
    
    local comfyui_pid=$!
    echo $comfyui_pid > "$WORKSPACE_DIR/comfyui.pid"
    
    log_success "ComfyUI started (PID: $comfyui_pid)"
    log_info "🌐 Access ComfyUI at: http://localhost:$port"
}

cleanup_deployment() {
    log_info "🧹 Cleaning up..."
    
    # Kill ComfyUI if running
    if [ -f "$WORKSPACE_DIR/comfyui.pid" ]; then
        local pid=$(cat "$WORKSPACE_DIR/comfyui.pid")
        kill "$pid" 2>/dev/null || true
        rm -f "$WORKSPACE_DIR/comfyui.pid"
    fi
    
    log_success "Cleanup complete"
}

# Trap for cleanup
trap cleanup_deployment EXIT

# Display system info
show_system_info() {
    log_info "🖥️ System Information:"
    echo "  OS: $(uname -s) $(uname -r)"
    echo "  Python: $(python3 --version 2>/dev/null || echo 'Not found')"
    
    if command -v nvidia-smi &> /dev/null; then
        echo "  GPU: $(nvidia-smi --query-gpu=name --format=csv,noheader,nounits | head -1)"
    else
        echo "  GPU: Not detected"
    fi
}

# Main deployment function that can be called by specific scripts
ddm_deploy() {
    local script_name="${1:-DDM Universal}"
    local additional_packages=("${@:2}")
    
    echo -e "${PURPLE}"
    cat << "EOF"
    ╔═══════════════════════════════════════════════════════════════╗
    ║                    🎭 Día de Muertos                          ║
    ║                   RunPod AI Deployment                       ║
    ║                     Shared Library v2.0                     ║
    ╚═══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    
    log_info "🚀 Starting $script_name deployment..."
    show_system_info
    
    setup_workspace
    install_system_deps
    setup_python_env
    install_python_packages "${additional_packages[@]}"
    clone_comfyui
    install_nodes
    download_models
    start_comfyui
    
    log_success "🎉 $script_name deployment complete!"
}

# Export functions for use in other scripts
export -f log_info log_success log_warning log_error
export -f setup_workspace install_system_deps setup_python_env
export -f install_python_packages clone_comfyui install_nodes download_models
export -f start_comfyui cleanup_deployment show_system_info ddm_deploy