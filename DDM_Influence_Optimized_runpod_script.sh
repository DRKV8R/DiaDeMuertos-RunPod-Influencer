# T5 Encoder GGUF Models - Memory Optimized (NEW)
T5_GGUF_MODELS=(
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q3_K_S.gguf"
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q4_K_M.gguf"
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q5_K_S.gguf"
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q6_K.gguf"
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q8_0.gguf"
)

# UMT5 Encoder GGUF Models - For VACE (NEW)
UMT5_GGUF_MODELS=(
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q3_K_S.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_M.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_S.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q5_K_M.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q5_K_S.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q6_K.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q8_0.gguf"
)

# CLIP Vision Models for Redux + VACE
CLIP_VISION_MODELS=(
    "https://huggingface.co/comfyanonymous/sigclip_vision_384/resolve/main/sigclip_vision_patch14# Portrait Master FLUX.1 RunPod Template
# Based on optimized RunPod provisioning structure

# https://github.com/your-repo/portrait-master-runpod-template

DEFAULT_WORKFLOW="https://raw.githubusercontent.com/Revmagi/DiaDeMuertos-RunPod-Influencer/refs/heads/main/workflows/PortraitMaster/PortraitMaster_Flux1_Full-body.json"

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
    "huggingface_hub[cli]>=0.20.0"
    "accelerate"
    "opencv-python"
    "matplotlib"
    "requests"
)

# Merged NODES array - Original + Portrait Master + Additional from ComfyUI_Installer
NODES=(
    # Essential Management
    "https://github.com/ltdrdata/ComfyUI-Manager"
    
    # Core Portrait Master Nodes
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/chflame163/ComfyUI_LayerStyle"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"
    "https://github.com/Jordach/ComfyUI-Detail-Daemon"
    "https://github.com/crystian/ComfyUI-Crystools"
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/MinusZoneAI/ComfyUI-MXToolkit"
    "https://github.com/WASasquatch/was-node-suite-comfyui"
    "https://github.com/adieyal/comfyui-dynamicprompts"
    
    # Optional Portrait Master Nodes
    "https://github.com/chflame163/ComfyUI_LayerStyle_Advance"
    "https://github.com/1038lab/ComfyUI-JoyCaption"
    "https://github.com/yolain/ComfyUI-Easy-Use"
    "https://github.com/WaveNodeStudio/ComfyUI-WaveNodes"
    
    # Core ComfyUI Enhancement Nodes
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
    "https://github.com/ltdrdata/ComfyUI-Impact-Subpack"
    "https://github.com/ltdrdata/ComfyUI-Inspire-Pack"
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/pythongosssss/ComfyUI-WD14-Tagger"
    
    # Video and Animation Nodes
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/Fannovel16/ComfyUI-Frame-Interpolation"
    "https://github.com/kijai/ComfyUI-WanVideoWrapper"
    
    # Advanced Portrait and Face Nodes
    "https://github.com/cubiq/ComfyUI_FaceAnalysis"
    "https://github.com/Ryuukeisyou/comfyui_face_parsing"
    "https://github.com/BadCafeCode/masquerade-nodes-comfyui"
    "https://github.com/PowerHouseMan/ComfyUI-AdvancedLivePortrait"
    "https://github.com/Gourieff/ComfyUI-ReActor"
    
    # AI Analysis and Captioning
    "https://github.com/kijai/ComfyUI-Florence2"
    "https://github.com/EvilBT/ComfyUI_SLK_joy_caption_two"
    "https://github.com/Pixelailabs/Save_Florence2_Bulk_Prompts"
    
    # Utility and Workflow Enhancement
    "https://github.com/giriss/comfy-image-saver"
    "https://github.com/mpiquero1111/ComfyUI-SaveImgPrompt"
    "https://github.com/hylarucoder/comfyui-copilot"
    "https://github.com/jamesWalker55/comfyui-various"
    "https://github.com/chrisgoringe/cg-use-everywhere"
    "https://github.com/TinyTerra/ComfyUI_tinyterraNodes"
    
    # Advanced Processing and Effects
    "https://github.com/melMass/comfy_mtb"
    "https://github.com/KoreTeknology/ComfyUI-Universal-Styler"
    "https://github.com/shiimizu/ComfyUI-TiledDiffusion"
    "https://github.com/EllangoK/ComfyUI-post-processing-nodes"
    "https://github.com/sipherxyz/comfyui-art-venture"
    "https://github.com/storyicon/comfyui_segment_anything"
    
    # Model Format Support
    "https://github.com/city96/ComfyUI_ExtraModels"
    "https://github.com/city96/ComfyUI-GGUF"
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/0xbitches/ComfyUI-LCM"
    
    # Advanced Technical Nodes
    "https://github.com/un-seen/comfyui-tensorops"
    "https://github.com/hay86/ComfyUI_LatentSync"
    "https://github.com/pamparamm/sd-perturbed-attention"
    "https://github.com/orssorbit/ComfyUI-wanBlockswap"
    
    # Audio and TTS Nodes
    "https://github.com/1038lab/ComfyUI-SparkTTS"
    "https://github.com/christian-byrne/audio-separation-nodes-comfyui"
    
    # Upscaling and Enhancement
    "https://github.com/flowtyone/ComfyUI-Flowty-LDSR"
    "https://github.com/if-ai/ComfyUI_IF_AI_LoadImages"
    
    # General Enhancement Nodes
    "https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes"
    "https://github.com/glifxyz/ComfyUI-GlifNodes"
    "https://github.com/jakechai/ComfyUI-JakeUpgrade"
)

WORKFLOWS=(
    "https://github.com/your-repo/portrait-master-runpod-template.git"
)

# FLUX.1 and Portrait Master Models + SDXL Models
CHECKPOINT_MODELS=(
    # Keep original checkpoints for compatibility
    "https://huggingface.co/kingcashflow/modelcheckpoints/resolve/main/AIIM_Realism.safetensors"
    "https://huggingface.co/kingcashflow/modelcheckpoints/resolve/main/AIIM_Realism_FAST.safetensors"
    "https://huggingface.co/kingcashflow/modelcheckpoints/resolve/main/uberRealisticPornMergePonyxl_ponyxlHybridV1.safetensors"
    "https://huggingface.co/AiWise/epiCRealism-XL-vXI-aBEAST/resolve/5c3950c035ce565d0358b76805de5ef2c74be919/epicrealismXL_vxiAbeast.safetensors"
    
    # Additional checkpoints from GGUF script
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/epicrealism_naturalSinRC1VAE.safetensors"
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/epicrealism_pureEvolutionV3.safetensors"
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/epicrealismXL_vxviLastfameRealism.safetensors"
    
    # NEW: SDXL Models from NSFW script
    "https://huggingface.co/simwalo/SDXL/resolve/main/bigLust_v16.safetensors"
    "https://huggingface.co/simwalo/SDXL/resolve/main/analogMadnessSDXL_xl2.safetensors"
)

# FLUX.1 UNET Models (gated - requires HF_TOKEN) + GGUF Models
UNET_MODELS=(
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors"
)

# FLUX.1 GGUF Models - Memory Optimized (NEW)
FLUX_GGUF_8GB=(
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-dev-Q3_K_S.gguf"
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q3_K_M.gguf"
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q4_0.gguf"
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q4_1.gguf"
)

FLUX_GGUF_12GB=(
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q4_K_M.gguf"
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q4_K_S.gguf"
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q5_0.gguf"
)

FLUX_GGUF_16GB=(
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q5_1.gguf"
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q5_K_M.gguf"
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q5_K_S.gguf"
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q6_K.gguf"
)

FLUX_GGUF_24GB=(
    "https://huggingface.co/QuantStack/FLUX.1-Kontext-dev-GGUF/resolve/main/flux1-kontext-dev-Q8_0.gguf"
)

# VACE GGUF Models - Video Creation and Editing (NEW)
VACE_GGUF_12GB=(
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q3_K_S.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q4_0.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q4_1.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q4_K_M.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q4_K_S.gguf"
)

VACE_GGUF_16GB=(
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q5_0.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q5_1.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q5_K_M.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q5_K_S.gguf"
)

VACE_GGUF_24GB=(
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q6_K.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-Q8_0.gguf"
)

VACE_GGUF_32GB=(
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-BF16.gguf"
    "https://huggingface.co/QuantStack/Wan2.1_14B_VACE-GGUF/resolve/main/Wan2.1_14B_VACE-F16.gguf"
)

# FLUX.1 VAE Models + VACE VAE
VAE_MODELS=(
    "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/diffusion_pytorch_model.safetensors"
    "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors"
    
    # Additional VAE from GGUF script
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/ae.safetensors"
    
    # NEW: VACE VAE Models
    "https://huggingface.co/simwalo/Wan2.1_SkyreelsV2/resolve/main/wan_2.1_vae.safetensors"
)

# FLUX.1 CLIP Models + T5 GGUF Models (NEW)
CLIP_MODELS=(
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
    "https://huggingface.co/zer0int/CLIP-GmP-ViT-L-14/resolve/main/ViT-L-14-TEXT-detail-improved-hiT-GmP-TE-only-HF.safetensors"
    
    # Additional CLIP models from GGUF script
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/clip_l.safetensors"
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/ViT-L-14-TEXT-detail-improved-hiT-GmP-TE-only-HF.safetensors"
)

# T5 Encoder GGUF Models - Memory Optimized (NEW)
T5_GGUF_MODELS=(
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q3_K_S.gguf"
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q4_K_M.gguf"
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q5_K_S.gguf"
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q6_K.gguf"
    "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q8_0.gguf"
)

# UMT5 Encoder GGUF Models - For VACE (NEW)
UMT5_GGUF_MODELS=(
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q3_K_S.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_M.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_S.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q5_K_M.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q5_K_S.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q6_K.gguf"
    "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q8_0.gguf"
)

# CLIP Vision Models for Redux + VACE + IPAdapter
CLIP_VISION_MODELS=(
    "https://huggingface.co/comfyanonymous/sigclip_vision_384/resolve/main/sigclip_vision_patch14_384.safetensors"
    
    # NEW: VACE CLIP Vision
    "https://huggingface.co/simwalo/Wan2.1_SkyreelsV2/resolve/main/clip_vision_h.safetensors"
)

# Style Models for Redux
STYLE_MODELS=(
    "https://huggingface.co/black-forest-labs/FLUX.1-Redux-dev/resolve/main/flux1-redux-dev.safetensors"
)

# Portrait Master LoRAs + IPAdapter LoRAs + VACE LoRAs
LORA_MODELS=(
    # Original LoRAs
    "https://huggingface.co/kingcashflow/LoRas/resolve/main/depth_of_field_slider_v1.safetensors"
    "https://huggingface.co/kingcashflow/LoRas/resolve/main/zoom_slider_v1.safetensors"
    "https://huggingface.co/kingcashflow/LoRas/resolve/main/add_detail.safetensors"
    "https://huggingface.co/kingcashflow/underboobXL/resolve/main/UnderboobXL.safetensors"
    
    # Portrait Master Character LoRA
    "https://huggingface.co/sergio75/Lya/resolve/main/Lya01_ep08_rp01_step800_bf16.safetensors"
    
    # Additional LoRAs from GGUF script
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/comfyui_portrait_lora64.safetensors"
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/Maya_Lora_v1_000002500.safetensors"
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/more_details.safetensors"
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/FameGrid_Bold_SDXL_V1.safetensors"
    
    # NEW: SDXL and IPAdapter LoRAs
    "https://huggingface.co/simwalo/SDXL/resolve/main/Touch_of_Realism_SDXL_V2.safetensors"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15_lora.safetensors"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15_lora.safetensors"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sdxl_lora.safetensors"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl_lora.safetensors"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plus_sd15_lora.safetensors"
    
    # NEW: VACE Video LoRAs
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_CausVid_14B_T2V_lora_rank32_v2.safetensors"
)

CONTROLNET_MODELS=(
    "https://huggingface.co/xinsir/controlnet-openpose-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors"
    "https://huggingface.co/xinsir/controlnet-depth-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors"
    
    # Additional ControlNet models from GGUF script
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/Flux-Union-Pro2.safetensors"
    "https://huggingface.co/datasets/simwalo/FluxDevFP8/resolve/main/Flux1-controlnet-upscaler-Jasperai-fp8.safetensors"
    
    # NEW: Additional SDXL ControlNet
    "https://huggingface.co/simwalo/SDXL/resolve/main/Depth-SDXL-xinsir.safetensors"
)

# IPAdapter Models - Complete IPAdapter Ecosystem (NEW)
IPADAPTER_MODELS=(
    # Core IPAdapter Models
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15_light_v11.bin"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus-face_sd15.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-full-face_sd15.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15_vit-G.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl_vit-h.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus-face_sdxl_vit-h.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15_light.safetensors"
    
    # FaceID Models
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-portrait-v11_sd15.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sdxl.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-portrait_sdxl.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-portrait_sdxl_unnorm.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plus_sd15.bin"
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-portrait_sd15.bin"
    
    # Community Models
    "https://huggingface.co/ostris/ip-composition-adapter/resolve/main/ip_plus_composition_sd15.safetensors"
    "https://huggingface.co/ostris/ip-composition-adapter/resolve/main/ip_plus_composition_sdxl.safetensors"
    "https://huggingface.co/Kwai-Kolors/Kolors-IP-Adapter-Plus/resolve/main/ip_adapter_plus_general.bin"
    "https://huggingface.co/Kwai-Kolors/Kolors-IP-Adapter-FaceID-Plus/resolve/main/ipa-faceid-plus.bin"
)

# IPAdapter CLIP Vision Models (NEW)
IPADAPTER_CLIP_VISION_MODELS=(
    "https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/image_encoder/model.safetensors"
    "https://huggingface.co/Kwai-Kolors/Kolors-IP-Adapter-Plus/resolve/main/image_encoder/pytorch_model.bin"
)

# Portrait Master Upscale Models + Additional Upscalers
ESRGAN_MODELS=(
    "https://github.com/Phhofm/models/raw/main/4xFaceUpDAT/4xFaceUpDAT.pth"
    "https://github.com/Phhofm/models/raw/main/4xFaceUpSharpDAT/4xFaceUpSharpDAT.pth"
    
    # NEW: Additional high-quality upscalers
    "https://huggingface.co/lokCX/4x-Ultrasharp/resolve/main/4x-UltraSharp.pth"
    "https://huggingface.co/skbhadra/ClearRealityV1/resolve/main/4x-ClearRealityV1.pth"
)

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
    # NEW: Advanced face segmentation model
    "https://huggingface.co/24xx/segm/resolve/main/face_yolov8n-seg2_60.pt"
)

SAM_MODELS=(
    "https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth"
)

# ZIP Files with Models and Custom Nodes (will be extracted)
ZIP_DOWNLOADS=(
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/PersonMaskUltraV2.zip"
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/insightface.zip"
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/liveportrait.zip"
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/rembg.zip"
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/LLM.zip"
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/sams.zip"
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/ComfyUI-LatentSyncWrapper.zip"
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/comfyui-reactor.zip"
    "https://huggingface.co/datasets/simwalo/custom_nodes/resolve/main/Joy_caption_two.zip"
    
    # NEW: Additional custom nodes from NSFW script
    "https://huggingface.co/simwalo/SDXL/resolve/main/comfyui_controlnet_aux.zip"
    "https://huggingface.co/simwalo/SDXL/resolve/main/Text_Processor_By_Aiconomist.zip"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

# VRAM Selection Function (NEW) - Enhanced with VACE support
function select_flux_models_by_vram() {
    echo ""
    echo "🎯 MODEL SELECTION BY VRAM"
    echo "=============================="
    echo "Select models based on your VRAM:"
    echo "1. 8GB VRAM (FLUX Q3_K_S, Q4_0, Q4_1 - Fastest)"
    echo "2. 12GB VRAM (FLUX Q4_K_M, Q5_0 + VACE Q3-Q4 - Balanced)"
    echo "3. 16GB VRAM (FLUX Q5_K_M, Q6_K + VACE Q5 - High Quality)"
    echo "4. 24GB VRAM (FLUX Q8_0 + VACE Q6_K, Q8_0 - Highest Quality)"
    echo "5. 32GB+ VRAM (All models including VACE FP16/BF16)"
    echo "6. Download All GGUF Variants (Requires significant storage)"
    echo "7. Skip GGUF Models (Download standard FLUX only)"
    echo ""
    
    read -p "Enter choice (1-7): " vram_choice
    
    case $vram_choice in
        1) 
            echo "✅ Selected: 8GB VRAM optimized models (FLUX only)"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_8GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q3_K_S.gguf")
            SELECTED_VACE_GGUF=()
            SELECTED_UMT5_GGUF=()
            ;;
        2) 
            echo "✅ Selected: 12GB VRAM optimized models (FLUX + VACE)"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_12GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q4_K_M.gguf")
            SELECTED_VACE_GGUF=("${VACE_GGUF_12GB[@]}")
            SELECTED_UMT5_GGUF=("https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_M.gguf")
            ;;
        3) 
            echo "✅ Selected: 16GB VRAM optimized models (FLUX + VACE)"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_16GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q5_K_S.gguf")
            SELECTED_VACE_GGUF=("${VACE_GGUF_16GB[@]}")
            SELECTED_UMT5_GGUF=("https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q5_K_M.gguf")
            ;;
        4) 
            echo "✅ Selected: 24GB VRAM optimized models (FLUX + VACE)"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_24GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q8_0.gguf")
            SELECTED_VACE_GGUF=("${VACE_GGUF_24GB[@]}")
            SELECTED_UMT5_GGUF=("https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q8_0.gguf")
            ;;
        5) 
            echo "✅ Selected: 32GB+ VRAM models (FLUX + VACE FP16/BF16)"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_24GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q8_0.gguf")
            SELECTED_VACE_GGUF=("${VACE_GGUF_32GB[@]}")
            SELECTED_UMT5_GGUF=("https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q8_0.gguf")
            ;;
        6) 
            echo "✅ Selected: All GGUF variants (Very large download)"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_8GB[@]}" "${FLUX_GGUF_12GB[@]}" "${FLUX_GGUF_16GB[@]}" "${FLUX_GGUF_24GB[@]}")
            SELECTED_T5_GGUF=("${T5_GGUF_MODELS[@]}")
            SELECTED_VACE_GGUF=("${VACE_GGUF_12GB[@]}" "${VACE_GGUF_16GB[@]}" "${VACE_GGUF_24GB[@]}" "${VACE_GGUF_32GB[@]}")
            SELECTED_UMT5_GGUF=("${UMT5_GGUF_MODELS[@]}")
            ;;
        7) 
            echo "⏭️  Skipping GGUF models (Standard FLUX only)"
            SELECTED_FLUX_GGUF=()
            SELECTED_T5_GGUF=()
            SELECTED_VACE_GGUF=()
            SELECTED_UMT5_GGUF=()
            ;;
        *) 
            echo "⚠️  Invalid choice, using 12GB VRAM default"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_12GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q4_K_M.gguf")
            SELECTED_VACE_GGUF=("${VACE_GGUF_12GB[@]}")
            SELECTED_UMT5_GGUF=("https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_M.gguf")
            ;;
    esac
}GGUF_12GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q4_K_M.gguf")
            ;;
        3) 
            echo "✅ Selected: 16GB VRAM optimized models"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_16GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q5_K_S.gguf")
            ;;
        4) 
            echo "✅ Selected: 24GB VRAM optimized models"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_24GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q8_0.gguf")
            ;;
        5) 
            echo "✅ Selected: All GGUF variants (Large download)"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_8GB[@]}" "${FLUX_GGUF_12GB[@]}" "${FLUX_GGUF_16GB[@]}" "${FLUX_GGUF_24GB[@]}")
            SELECTED_T5_GGUF=("${T5_GGUF_MODELS[@]}")
            ;;
        6) 
            echo "⏭️  Skipping GGUF models"
            SELECTED_FLUX_GGUF=()
            SELECTED_T5_GGUF=()
            ;;
        *) 
            echo "⚠️  Invalid choice, using 12GB VRAM default"
            SELECTED_FLUX_GGUF=("${FLUX_GGUF_12GB[@]}")
            SELECTED_T5_GGUF=("https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q4_K_M.gguf")
            ;;
    esac
}

function provisioning_start() {
    if [[ ! -d /opt/environments/python ]]; then 
        export MAMBA_BASE=true
    fi
    source /opt/ai-dock/etc/environment.sh
    source /opt/ai-dock/bin/venv-set.sh comfyui

    provisioning_print_header
    
    # NEW: VRAM-based model selection
    select_flux_models_by_vram
    
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages

    # Create model directories - Portrait Master structure + IPAdapter + VACE
    mkdir -p "${WORKSPACE}/ComfyUI/models/checkpoints"
    mkdir -p "${WORKSPACE}/ComfyUI/models/unet"
    mkdir -p "${WORKSPACE}/ComfyUI/models/vae"
    mkdir -p "${WORKSPACE}/ComfyUI/models/clip"
    mkdir -p "${WORKSPACE}/ComfyUI/models/clip_vision"
    mkdir -p "${WORKSPACE}/ComfyUI/models/style_models"
    mkdir -p "${WORKSPACE}/ComfyUI/models/loras"
    mkdir -p "${WORKSPACE}/ComfyUI/models/controlnet"
    mkdir -p "${WORKSPACE}/ComfyUI/models/upscale_models"
    mkdir -p "${WORKSPACE}/ComfyUI/models/ultralytics/bbox"
    mkdir -p "${WORKSPACE}/ComfyUI/models/ultralytics/segm"
    mkdir -p "${WORKSPACE}/ComfyUI/models/sams"
    mkdir -p "${WORKSPACE}/ComfyUI/models/insightface"
    mkdir -p "${WORKSPACE}/ComfyUI/models/LLM"
    mkdir -p "${WORKSPACE}/ComfyUI/models/rembg"
    mkdir -p "${WORKSPACE}/ComfyUI/models/liveportrait"
    mkdir -p "${WORKSPACE}/ComfyUI/models/ipadapter"
    mkdir -p "${WORKSPACE}/ComfyUI/custom_nodes/ComfyUI_LayerStyle/luts"

    # Download models to ComfyUI structure
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/checkpoints" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/unet" \
        "${UNET_MODELS[@]}"
    
    # NEW: Download selected GGUF models
    if [[ ${#SELECTED_FLUX_GGUF[@]} -gt 0 ]]; then
        echo "📥 Downloading selected FLUX GGUF models..."
        provisioning_get_models \
            "${WORKSPACE}/ComfyUI/models/unet" \
            "${SELECTED_FLUX_GGUF[@]}"
    fi
    
    # NEW: Download selected VACE GGUF models
    if [[ ${#SELECTED_VACE_GGUF[@]} -gt 0 ]]; then
        echo "📥 Downloading selected VACE GGUF models..."
        provisioning_get_models \
            "${WORKSPACE}/ComfyUI/models/unet" \
            "${SELECTED_VACE_GGUF[@]}"
    fi
    
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip" \
        "${CLIP_MODELS[@]}"
    
    # NEW: Download selected T5 GGUF models
    if [[ ${#SELECTED_T5_GGUF[@]} -gt 0 ]]; then
        echo "📥 Downloading selected T5 GGUF models..."
        provisioning_get_models \
            "${WORKSPACE}/ComfyUI/models/clip" \
            "${SELECTED_T5_GGUF[@]}"
    fi
    
    # NEW: Download selected UMT5 GGUF models
    if [[ ${#SELECTED_UMT5_GGUF[@]} -gt 0 ]]; then
        echo "📥 Downloading selected UMT5 GGUF models..."
        provisioning_get_models \
            "${WORKSPACE}/ComfyUI/models/clip" \
            "${SELECTED_UMT5_GGUF[@]}"
    fi
    
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip_vision" \
        "${CLIP_VISION_MODELS[@]}"
    
    # NEW: Download IPAdapter CLIP Vision models
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip_vision" \
        "${IPADAPTER_CLIP_VISION_MODELS[@]}"
    
    # NEW: Download IPAdapter models
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/ipadapter" \
        "${IPADAPTER_MODELS[@]}"
    
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip_vision" \
        "${CLIP_VISION_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/style_models" \
        "${STYLE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/loras" \
        "${LORA_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/upscale_models" \
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
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/custom_nodes/ComfyUI_LayerStyle/luts" \
        "${LUT_MODELS[@]}"
    provisioning_get_zip_models \
        "${WORKSPACE}/ComfyUI/models" \
        "${ZIP_DOWNLOADS[@]}"
        
    provisioning_get_workflows
    provisioning_print_end
