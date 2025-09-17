# 🎭 Día de Muertos RunPod Influencer

Modern AI influencer generation platform optimized for RunPod deployment with ComfyUI, featuring a dark-themed interface and intelligent automation.

## ✨ Features

- **🎭 Día de Muertos Theme**: Specialized AI influencer generation with cultural authenticity
- **🚀 Modern Interface**: Dark-themed, animated web interface for easy deployment
- **🤖 @DRKV8R/ENDS Agent**: Intelligent automation for resource optimization
- **⚡ Latest Dependencies**: PyTorch 2.4.0, CUDA 12.1, and optimized packages
- **🎨 ComfyUI Integration**: Full workflow management with custom nodes
- **📱 Responsive Design**: Works on desktop and mobile devices
- **🔄 Real-time Monitoring**: Live deployment logs and status updates

## 🚀 Quick Start

### Option 1: Interactive Deployment
```bash
python3 deploy.py
```

### Option 2: Quick Deploy (Modern)
```bash
python3 deploy.py --quick --script modern
```

### Option 3: Enhanced Video (WAN 2.2)
```bash
./wan22_enhanced_video.sh
```

### Option 4: Direct Script
```bash
./ddm_modern_deploy.sh
```

## 📋 Available Deployment Scripts

| Script | Description |
|--------|-------------|
| `modern` | 🎭 Modern DDM deployment with @DRKV8R/ENDS agent |
| `ddm_optimized` | 💀 Optimized Día de Muertos deployment with WAN 2.2 support |
| `wan22_enhanced_video` | 🚀 **NEW** Enhanced WAN 2.2 video generation with Lightning LoRAs |
| `skyreels_installer` | 🎬 Video-focused SkyReels deployment |
| `i2v_hunyuan` | 🎞️ Image-to-video with HunyuanVideo |
| `wan21_img2vid` | 🎯 WAN 2.1 video generation |
| `videoworkflow` | 🎥 Comprehensive video workflow |
| `civitai` | 🏛️ CivitAI model integration |

## 🌐 Web Interface

After deployment, access the modern web interface:

- **Main Interface**: http://localhost:3000
- **ComfyUI**: http://localhost:8188

### Interface Features

- 🎨 **Dark theme** with Día de Muertos color palette
- 📊 **Real-time dashboard** with deployment metrics
- 🔄 **Live logs** streaming from deployment processes
- 🎛️ **Easy configuration** for different GPU types
- 📱 **Mobile responsive** design

## 🤖 @DRKV8R/ENDS Agent

The Enhanced Neural Deployment System provides:

- **🎯 Resource Optimization**: Automatic GPU allocation and memory management
- **📊 Health Monitoring**: Continuous system health checks
- **🔄 Auto-scaling**: Dynamic resource allocation based on workload
- **📈 Performance Analytics**: Real-time performance metrics
- **🛠️ Automated Fixes**: Self-healing deployment capabilities

## 🛠️ Technology Stack

### Backend
- **Python 3.x** with modern async frameworks
- **PyTorch 2.4.0** with CUDA 12.1 support
- **ComfyUI** for AI workflow management
- **FastAPI/Flask** for API endpoints

### Frontend
- **TailwindCSS** for styling with custom DDM theme
- **Vanilla JavaScript** for lightweight interactions
- **Socket.IO** for real-time communication
- **Font Awesome** for icons

### Dependencies
- **Latest AI Models**: FLUX.1, WAN 2.2 Enhanced Video, ControlNet, VAE models
- **WAN 2.2 Features**: Fun Camera, Fun Control, Fun Inpaint, Sound-to-Video, Lightning LoRAs
- **Custom Nodes**: 20+ specialized ComfyUI nodes
- **Optimized Libraries**: XFormers, Accelerate, Transformers

## 🎬 WAN 2.2 Video Enhancement Features

### 🚀 **Major Upgrade from WAN 2.1**
- **⚡ Lightning LoRAs**: 4x faster video generation (4 steps vs 50+ steps)
- **🎥 Fun Camera Models**: Dynamic camera movements and cinematic effects
- **🎛️ Fun Control Models**: Precise motion and object control
- **✨ Fun Inpaint Models**: Advanced video editing and object removal
- **🎵 Sound-to-Video**: Generate videos from audio input
- **🖼️ Text+Image-to-Video**: Combined conditioning for precise control
- **🎨 Enhanced VAE**: Improved temporal consistency and quality

### 📊 Performance Comparison: FLUX 1 vs WAN 2.2
| Feature | FLUX 1 | WAN 2.2 |
|---------|--------|---------|
| **Primary Use** | Image Generation | Advanced Video Generation |
| **Generation Speed** | 2-8 seconds (images) | 10-30 seconds (videos with Lightning) |
| **Video Quality** | Limited | Professional-grade temporal consistency |
| **Camera Control** | ❌ | ✅ Fun Camera models |
| **Audio Integration** | ❌ | ✅ Sound-to-Video |
| **Video Editing** | ❌ | ✅ Fun Inpaint models |
| **Memory Options** | 8-24GB VRAM | 12-32GB VRAM optimal |

> 📖 **Detailed Comparison**: See [`FLUX_WAN22_COMPARISON.md`](FLUX_WAN22_COMPARISON.md) for comprehensive analysis

## 📦 Installation Requirements

### System Requirements
- **GPU**: NVIDIA RTX 4090, A100, or H100 recommended
- **RAM**: 32GB+ recommended
- **Storage**: 100GB+ free space
- **OS**: Ubuntu 20.04+ or compatible Linux

### Python Dependencies
All dependencies are automatically installed via `requirements.txt`:
- PyTorch ecosystem with CUDA support
- Latest transformers and diffusers
- ComfyUI-specific packages
- Web interface dependencies

## 🎨 Customization

### Theming
The interface uses a custom Día de Muertos color palette:
- **Orange**: `#FF6B35` (dia-orange)
- **Purple**: `#6B46C1` (dia-purple)  
- **Gold**: `#F59E0B` (dia-gold)
- **Dark**: `#0F0F0F` (dia-dark)

### Adding New Scripts
1. Create your deployment script in the root directory
2. Make it executable: `chmod +x your_script.sh`
3. Update the description in `deploy.py`

### Custom Workflows
Add your ComfyUI workflows to the `workflows/` directory:
- `workflows/PortraitMaster/` - Portrait generation workflows
- `workflows/pixelaiLabs/` - Advanced AI workflows
- `workflows/king_workflows/` - Video generation workflows

## 🔧 Configuration

### Environment Variables
Create a `.env` file:
```bash
# Server configuration
PORT=3000
COMFYUI_PORT=8188

# GPU configuration
CUDA_VISIBLE_DEVICES=0

# ENDS Agent settings
ENDS_AUTO_OPTIMIZE=true
ENDS_MONITORING_INTERVAL=30
```

### Agent Configuration
Edit `agents/ends_config.json` to customize the @DRKV8R/ENDS agent behavior.

## 📊 Monitoring

The system provides multiple monitoring interfaces:

1. **Web Dashboard**: Real-time metrics and logs
2. **ENDS Agent Console**: Rich terminal interface
3. **Log Files**: Detailed logging for debugging

## 🔒 Security

- Input validation on all API endpoints
- Secure file handling for uploads
- Process isolation for deployments
- Resource limits to prevent abuse

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details.

## 🙏 Credits

- **ComfyUI Team** for the amazing AI workflow platform
- **RunPod** for GPU infrastructure
- **Community Contributors** for custom nodes and models
- **@DRKV8R** for the ENDS automation system

---

**🎭 ¡Viva el Día de Muertos!** - Celebrating life through AI artistry