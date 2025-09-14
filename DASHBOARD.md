# 🎭 Día de Muertos Dashboard Documentation

## Overview

The Día de Muertos RunPod Influencer dashboard provides a comprehensive interface for managing AI influencer deployments with real-time monitoring and intuitive navigation.

## Dashboard Sections

### 📊 Dashboard Overview
The main dashboard provides:
- **Active Deployments**: Current running instances count
- **Available Scripts**: Total deployment scripts ready to use
- **AI Agent Status**: @DRKV8R/ENDS agent health indicator
- **System Uptime**: Real-time server uptime counter

**Quick Deploy Options:**
- 🎭 **Modern DDM**: Latest Día de Muertos deployment
- 🎬 **SkyReels**: Video-focused deployment
- ⚡ **Standard**: Basic ComfyUI setup

**Recent Activity**: Live feed of deployment actions and system events

### 🚀 Deployments
Complete deployment management interface featuring:
- **Script Selection**: Choose from 13+ available deployment scripts
- **Configuration Options**: GPU type (RTX 4090, A100, H100) and instance size
- **Real-time Logs**: Live deployment progress monitoring
- **Active Deployments**: Overview of running instances

### 📈 Monitoring
Real-time system performance tracking:
- **Performance Metrics**: Memory, CPU, and GPU usage percentages
- **Network Status**: ComfyUI, RunPod API, and Model Download connectivity
- **Auto-refresh**: Metrics update every 5 seconds

### 🖥️ System
Environment and configuration information:
- **Environment**: Platform, Node.js, and Python version details
- **Configuration**: Server ports and agent status
- **Static Information**: System configuration overview

## Navigation

### Desktop Navigation
- Top navigation bar with 4 main sections
- Active section highlighting with Día de Muertos colors
- Smooth hover transitions and visual feedback

### Mobile Navigation
- Hamburger menu for screens < 768px
- Responsive design with touch-friendly interface
- Collapsible menu with section-specific styling

## Features

### 🎨 Theming
- **Dark Theme**: Día de Muertos color palette (Orange, Purple, Gold)
- **Responsive Design**: Works on desktop, tablet, and mobile
- **Smooth Animations**: CSS transitions and hover effects

### ⚡ Real-time Updates
- **WebSocket Integration**: Live deployment logs via Socket.IO
- **Auto-refresh Metrics**: System monitoring data updates
- **Live Activity Feed**: Real-time deployment event tracking

### 🔔 Notifications
- **Success/Error States**: Visual feedback for all actions
- **Auto-dismissing**: Notifications fade after 5 seconds
- **Color-coded**: Different colors for info, success, warning, error

## Quick Start

1. **Access Dashboard**: Navigate to `http://localhost:3000`
2. **Quick Deploy**: Click any quick deploy button for instant setup
3. **Custom Deploy**: Use Deployments section for detailed configuration
4. **Monitor Progress**: Watch real-time logs and system metrics
5. **System Info**: Check System section for environment details

## Technical Details

### Technology Stack
- **Frontend**: Vanilla JavaScript, TailwindCSS
- **Backend**: Express.js, Socket.IO
- **Build System**: esbuild, Tailwind CLI
- **Theme**: Custom Día de Muertos color palette

### File Structure
```
interface/
├── src/
│   ├── app.js          # Main dashboard logic
│   └── styles.css      # Custom styles and animations
├── templates/
│   └── index.html      # Main dashboard template
├── static/
│   ├── app.js          # Built JavaScript bundle
│   ├── styles.css      # Built CSS bundle
│   └── js/
│       └── socket.io.min.js  # WebSocket client
└── server.js           # Express server and API
```

### Development Commands
```bash
npm run dev              # Start development server
npm run build           # Build CSS and JavaScript
npm run build:css       # Build only CSS
npm run build:js        # Build only JavaScript
npm run build:css:watch # Watch mode for CSS development
```

## Customization

### Adding New Scripts
1. Add your `.sh` script to the repository root
2. Update the script descriptions in `server.js`
3. Optionally add to quick deploy buttons in the template

### Modifying Metrics
Update the `updateSystemMetrics()` function in `app.js` to integrate with real system monitoring APIs.

### Theme Customization
Modify the color palette in `tailwind.config.js`:
```javascript
colors: {
  'dia-orange': '#FF6B35',  // Primary accent
  'dia-purple': '#6B46C1',  // Secondary accent
  'dia-gold': '#F59E0B',    // Tertiary accent
  'dia-dark': '#0F0F0F',    // Dark background
  'dia-darker': '#050505'   // Darker background
}
```

## API Endpoints

- `GET /` - Main dashboard interface
- `GET /api/scripts` - Available deployment scripts
- `POST /api/deploy` - Start new deployment
- `GET /api/deployments/:id/status` - Deployment status

## Support

For issues or feature requests, please refer to the main repository documentation or create an issue on GitHub.

---

**🎭 ¡Viva el Día de Muertos!** - Celebrating life through AI artistry