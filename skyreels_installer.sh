cd /workspace

git clone https://github.com/comfyanonymous/ComfyUI
cd ComfyUI
apt-get update
apt-get -y install aria2
python -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu124

git clone https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager
pip install -r custom_nodes/ComfyUI-Manager/requirements.txt

git clone https://github.com/kijai/ComfyUI-KJNodes custom_nodes/ComfyUI-KJNodes
pip install -r custom_nodes/ComfyUI-KJNodes/requirements.txt

git clone https://github.com/city96/ComfyUI-GGUF custom_nodes/ComfyUI-GGUF
pip install -r custom_nodes/ComfyUI-GGUF/requirements.txt

git clone https://github.com/yolain/ComfyUI-Easy-Use.git custom_nodes/ComfyUI-Easy-Use
pip install -r custom_nodes/ComfyUI-Easy-Use/requirements.txt

git clone https://github.com/crystian/ComfyUI-Crystools custom_nodes/ComfyUI-Crystools
pip install -r custom_nodes/ComfyUI-Crystools/requirements.txt

git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git custom_nodes/ComfyUI-VideoHelperSuite
pip install -r custom_nodes/ComfyUI-VideoHelperSuite/requirements.txt

git clone https://github.com/kijai/ComfyUI-HunyuanVideoWrapper custom_nodes/ComfyUI-HunyuanVideoWrapper
pip install -r custom_nodes/ComfyUI-HunyuanVideoWrapper/requirements.txt

git clone https://github.com/kijai/ComfyUI-WanVideoWrapper custom_nodes/ComfyUI-WanVideoWrapper
pip install -r custom_nodes/ComfyUI-WanVideoWrapper/requirements.txt

cd custom_nodes
git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale --recursive
cd ..

git clone https://github.com/kijai/ComfyUI-Florence2 custom_nodes/ComfyUI-Florence2
pip install -r custom_nodes/ComfyUI-Florence2/requirements.txt
mkdir models/LLM

git clone https://github.com/chengzeyi/Comfy-WaveSpeed custom_nodes/Comfy-WaveSpeed

# Downloading text encoder and VAE
mkdir -p ComfyUI/models/text_encoders
aria2c -c -x 16 -s 16 https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors -d ComfyUI/models/text_encoders -o umt5_xxl_fp8_e4m3fn_scaled.safetensors

mkdir -p ComfyUI/models/vae
aria2c -c -x 16 -s 16 https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/wan_2.1_vae.safetensors -d ComfyUI/models/vae -o wan_2.1_vae.safetensors

# Downloading video models
mkdir -p ComfyUI/models/diffusion_models
aria2c -c -x 16 -s 16 https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_t2v_1.3B_fp16.safetensors -d ComfyUI/models/diffusion_models -o wan2.1_t2v_1.3B_fp16.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_i2v_720p_14B_fp16.safetensors -d ComfyUI/models/diffusion_models -o wan2.1_i2v_720p_14B_fp16.safetensors

aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_720_cfgdistill_bf16.safetensors -d models/diffusion_models -o hunyuan_video_720_cfgdistill_bf16.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_720_cfgdistill_fp8_e4m3fn.safetensors -d models/diffusion_models -o hunyuan_video_720_cfgdistill_fp8_e4m3fn.safetensors

#aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_FastVideo_720_fp8_e4m3fn.safetensors -d models/diffusion_models -o hunyuan_video_FastVideo_720_fp8_e4m3fn.safetensors
#aria2c -c -x 16 -s 16 https://huggingface.co/tencent/HunyuanVideo/resolve/main/hunyuan-video-t2v-720p/transformers/mp_rank_00_model_states_fp8.pt -d models/diffusion_models -o mp_rank_00_model_states_fp8.pt
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_vae_bf16.safetensors -d models/vae -o hunyuan_video_vae_bf16.safetensors
#aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/HunyuanVideo_comfy/resolve/main/hunyuan_video_vae_fp32.safetensors -d models/vae -o hunyuan_video_vae_fp32.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/SkyReels-V1-Hunyuan_comfy/resolve/main/skyreels_hunyuan_i2v_bf16.safetensors -d models/diffusion_models -o skyreels_hunyuan_i2v_bf16.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/SkyReels-V1-Hunyuan_comfy/resolve/main/skyreels_hunyuan_t2v_bf16.safetensors -d models/diffusion_models -o skyreels_hunyuan_t2v_bf16.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/SkyReels-V1-Hunyuan_comfy/resolve/main/skyreels_hunyuan_i2v_fp8_e4m3fn.safetensors -d models/diffusion_models -o skyreels_hunyuan_i2v_fp8_e4m3fn.safetensors


aria2c -c -x 16 -s 16 https://huggingface.co/calcuis/hunyuan-gguf/resolve/main/hunyuan-video-t2v-720p-q8_0.gguf -d models/unet -o hunyuan-video-t2v-720p-q8_0.gguf
aria2c -c -x 16 -s 16 https://huggingface.co/calcuis/hunyuan-gguf/resolve/main/hunyuan-video-t2v-720p-q3_k_m.gguf -d models/unet -o hunyuan-video-t2v-720p-q3_k_m.gguf

aria2c -c -x 16 -s 16 https://huggingface.co/toyxyz/HunyuanVideo_Lora/resolve/main/testanime02_epoch53.safetensors -d models/loras -o anime.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/leapfusion-image2vid-test/image2vid-960x544/resolve/main/img2vid544p.safetensors -d models/loras -o img2vid960x544.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/leapfusion-image2vid-test/image2vid-512x320/resolve/main/img2vid.safetensors -d models/loras -o img2vid512x320.safetensors

mkdir models/clip/clip-vit-large-patch14
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/config.json -d models/clip/clip-vit-large-patch14 -o config.json
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/merges.txt -d models/clip/clip-vit-large-patch14 -o merges.txt
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/model.safetensors -d models/clip/clip-vit-large-patch14 -o model.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/preprocessor_config.json -d models/clip/clip-vit-large-patch14 -o preprocessor_config.json
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/README.md -d models/clip/clip-vit-large-patch14 -o README.md
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/special_tokens_map.json -d models/clip/clip-vit-large-patch14 -o special_tokens_map.json
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/tokenizer_config.json -d models/clip/clip-vit-large-patch14 -o tokenizer_config.json
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/tokenizer.json -d models/clip/clip-vit-large-patch14 -o tokenizer.json
aria2c -c -x 16 -s 16 https://huggingface.co/openai/clip-vit-large-patch14/resolve/main/vocab.json -d models/clip/clip-vit-large-patch14 -o vocab.json

mkdir models/LLM/llava-llama-3-8b-text-encoder-tokenizer
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/config.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o config.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/generation_config.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o generation_config.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model-00001-of-00004.safetensors -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model-00001-of-00004.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model-00002-of-00004.safetensors -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model-00002-of-00004.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model-00003-of-00004.safetensors -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model-00003-of-00004.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model-00004-of-00004.safetensors -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model-00004-of-00004.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model.safetensors.index.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model.safetensors.index.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/special_tokens_map.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o special_tokens_map.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/tokenizer_config.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o tokenizer_config.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/tokenizer.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o tokenizer.json

mkdir models/text_encoders
aria2c -c -x 16 -s 16 https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/text_encoders/clip_l.safetensors -d models/text_encoders -o clip_l.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/text_encoders/llava_llama3_fp8_scaled.safetensors -d models/text_encoders -o llava_llama3_fp8_scaled.safetensors

mkdir models/LLM/clip
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/config.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o config.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/generation_config.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o generation_config.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model-00001-of-00004.safetensors -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model-00001-of-00004.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model-00002-of-00004.safetensors -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model-00002-of-00004.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model-00003-of-00004.safetensors -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model-00003-of-00004.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model-00004-of-00004.safetensors -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model-00004-of-00004.safetensors
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/model.safetensors.index.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o model.safetensors.index.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/special_tokens_map.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o special_tokens_map.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/tokenizer_config.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o tokenizer_config.json
aria2c -c -x 16 -s 16 https://huggingface.co/Kijai/llava-llama-3-8b-text-encoder-tokenizer/resolve/main/tokenizer.json -d models/LLM/llava-llama-3-8b-text-encoder-tokenizer -o tokenizer.json

pip install sageattention
python -m pip install bitsandbytes
pip uninstall -y accelerate transformers
python -m pip install accelerate==1.2.0
python -m pip install transformers==4.47.0

python main.py --listen --port 3000

### All Resolutions below are tested with 1 Lora in workflow. If adding or removing Loras, or adding the resolution possibilities may change ###
## Resolutions may change slightly from setup to setup. You may have to modify # of frames to 
### Teacache and Enhance-A-Video also slightly change VRAM requirements ###

## Hunyuan Wrapper *note, there are a lot of settings to change in the wrapper. Adjusting quantization settings will have a large impact on size of generation you can fit into your GPU
## If your RunPod instance or your Linux Instance is locking up, it probably means you are running out of RAM. The RAM requirements are very high for this, at least 48GB. More for small VRAM Sizes.
## Torch compile unfortunately only works with RTX40XX cards, disable that node if you have an older card.
## reduce single blocks, then double blocksto get faster generations, but sacrifice how long the videos can be, 

# 4GB VRAM # # #
# blockswap: 20 double, 40 single
# fp8:
# Res: 960x544x21frames
#      736x432x29frames
# bf16: (Must use fp8 quantization for this to work)
# Res: 960x544x21frames
#      736x432x29frames

# 6GB VRAM # # #
# blockswap: 20 double, 40 single
# fp8:
# Res: 960x544x27frames
#      736x432x69frames
# bf16: (Must use fp8 quantization for this to work)
# Res: 960x544x27frames (used exactly 6GB VRAM)
#      736x432x65frames

# 10GB VRAM # # #
# blockswap: 20 double, 40 single
# fp8:
# Res: 1280x720x37frames
#      960x544x81frames
#      736x432x109frames
#      
# bf16: (Must use fp8 quantization for this to work)
# Res: 1280x720x33frames
#      960x544x77frames
#      736x432x105frames

# 12GB VRAM # # #
# RTX4070 can use torch compile, 3080 cannot use torch compile, therefore 4070 can use slightly higher frames than listed below, or swap less blocks
# blockswap: 20 double, 40 single
# fp8:
# Res: 1280x720x45frames
#      960x544x77frames
#      736x432x129frames
# bf16: (Must use fp8 quantization for this to work)
# Res: 1280x720x45frames
#      960x544x77frames
#      736x432x129frames

# 16GB VRAM # # #
# Most 16GB cards do support torch compile, so I will be using it here
# blockswap: 20 double, 20 single
# fp8:
# Res: 1280x720x61frames
#      960x544x117frames
#      736x432x201frames
# bf16: (Must use fp8 quantization for this to work)
# Res: 1280x720x45frames
#      960x544x93frames
#      736x432x169frames

# 20GB VRAM # # #
# Most 20GB cards do support torch compile, so I will be using it here, you get an error, bypass the torch compile node 
# blockswap: 20 double, 20 single (can drop to 20 double, 0 single for 736x432)
# fp8:
# Res: 1280x720x93frames
#      960x544x133frames
#      736x432x201frames
# bf16:
# Res: 1280x720x89frames
#      960x544x129frames
#      736x432x201frames

# 24GB VRAM # # #
# I tested this with torch compile, if you are using an RTX3090, you will need to increase blockswap to filt the resolutions below
# fp8:
# Res: 1280x720x121frames # blockswap: 20 double, 30 single
#      960x544x121frames # blockswap: 5 double, 0 single
#      736x432x201frames #blockswap: 0 double, 0 single
# bf16:
# Res: 1280x720x121frames # blockswap: 20 double, 30 single
#      960x544x129frames # blockswap: 5 double, 0 single
#      736x432x201frames # blockswap: 0 double, 0 single

## Native **Not Recommended** There are issues with memory management. Recommend to use Kijai's Wrapper so the block swap works correctly. Can't use as high of resolution with native, but it is slightly faster##

# 6GB VRAM # # #
# q3 GGUF (bf16 quantized):
# Res:736x432x53frames

# 10GB VRAM # # #
# q3 GGUF (bf16 quantized):
# Res: 960x544x37frames
#      736x432x81frames
#
# q8 GGUF (bf16 quantized) or fp8:
# Res: 960x544x21frames
#      736x432x41frames
# 
# bf16:
# Res: 736x432x21frames

# 12GB VRAM # # #
# q3 GGUF (bf16 quantized):
# Res: 960x544x61frames
#      736x432x105frames
#
# q8 GGUF (bf16 quantized) or fp8:
# Res: 960x544x25frames
#      736x432x45frames
# 
# bf16:
# Res: 736x432x25frames


# 16GB VRAM # # #
# q3 GGUF (bf16 quantized):
# Res: 960x544x101frames
#      736x432x149frames
#
# q8 GGUF (bf16 quantized) or fp8:
# Res: 960x544x41frames
#      736x432xframes
# 
# bf16:
# Res: 736x432xframes

# 20GB VRAM # # #
# q3 GGUF (bf16 quantized):
# Res: 960x544xframes
#      736x432xframes
#
# q8 GGUF (bf16 quantized) or fp8:
# Res: 960x544xframes
#      736x432xframes
# 
# bf16:
# Res: 736x432xframes

# 24GB VRAM # # #
# q3 GGUF (bf16 quantized):
# Res: 960x544xframes
#      736x432xframes
#
# q8 GGUF (bf16 quantized) or fp8:
# Res: 960x544xframes
#      736x432xframes
# 
# bf16:
# Res: 736x432xframes