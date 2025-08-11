#!/bin/bash

# Portrait Master FLUX.1 RunPod Template
# Based on optimized RunPod provisioning structure

# https://github.com/your-repo/portrait-master-runpod-template

DEFAULT_WORKFLOW="https://raw.githubusercontent.com/your-repo/portrait-master-runpod-template/refs/heads/main/workflows/PortraitMaster_Flux1_Full-body.json"

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

# FLUX.1 UNET Models (gated - requires HF_TOKEN)
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
    mkdir -p "${WORKSPACE}/ComfyUI/models/ipadapter"

    # Download models to appropriate directories - using working optimized.sh structure
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/checkpoints" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${UNET_MODELS[@]}"
    
    # Download GGUF models to unet directory
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${FLUX_GGUF_8GB[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${FLUX_GGUF_12GB[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${FLUX_GGUF_16GB[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${FLUX_GGUF_24GB[@]}"
    
    # Download VACE GGUF models
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${VACE_GGUF_12GB[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${VACE_GGUF_16GB[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${VACE_GGUF_24GB[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/unet" \
        "${VACE_GGUF_32GB[@]}"
    
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/clip" \
        "${CLIP_MODELS[@]}"
    
    # Download T5 and UMT5 GGUF models to clip directory
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/clip" \
        "${T5_GGUF_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/clip" \
        "${UMT5_GGUF_MODELS[@]}"
    
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip_vision" \
        "${CLIP_VISION_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/style_models" \
        "${STYLE_MODELS[@]}"
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
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/ipadapter" \
        "${IPADAPTER_MODELS[@]}"
        
    provisioning_get_workflows
    provisioning_print_end
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

    # Configure Git to use GitHub token if available
    if [[ -n "$GITHUB_TOKEN" ]]; then
        printf "Configuring Git with GitHub token...\n"
        git config --global credential.helper store
        echo "https://token:${GITHUB_TOKEN}@github.com" > ~/.git-credentials
        printf "Git authentication configured successfully.\n"
    else
        printf "Warning: GITHUB_TOKEN not found. Some private repositories may fail to clone.\n"
    fi

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
                # Skip problematic setup.py installations
                if [[ -e "${path}/pyproject.toml" ]] || [[ -e "${path}/setup.py" ]]; then
                    if [[ "$dir" != "ComfyUI-Custom-Scripts" ]]; then
                        printf "Installing package in: %s\n" "${path}"
                        pip_install "${path}" || printf "Warning: Failed to install package in %s, continuing...\n" "${path}"
                    else
                        printf "Skipping problematic package installation for: %s\n" "${dir}"
                    fi
                fi
            fi
        # Download new node
        else
            printf "Downloading node: %s...\n" "${repo}"
            
            git clone "${repo}" "${path}" --recursive || {
                printf "Warning: Failed to clone %s, continuing...\n" "${repo}"
                continue
            }
            
            if [[ -e $requirements ]]; then
                pip_install -r "$requirements"
            fi
            
            # Skip problematic setup.py installations
            if [[ -e "${path}/pyproject.toml" ]] || [[ -e "${path}/setup.py" ]]; then
                if [[ "$dir" != "ComfyUI-Custom-Scripts" ]]; then
                    printf "Installing package in: %s\n" "${path}"
                    pip_install "${path}" || printf "Warning: Failed to install package in %s, continuing...\n" "${path}"
                else
                    printf "Skipping problematic package installation for: %s\n" "${dir}"
                fi
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

provisioning_start