const express = require('express');
const { Server } = require('socket.io');
const http = require('http');
const path = require('path');
const { spawn } = require('child_process');
const fs = require('fs').promises;
// const chalk = require('chalk'); // ES module issue, use simple console colors
const chalk = {
    green: (text) => `\x1b[32m${text}\x1b[0m`,
    yellow: (text) => `\x1b[33m${text}\x1b[0m`,
    bold: { green: (text) => `\x1b[1m\x1b[32m${text}\x1b[0m` }
};

class DDMInterface {
    constructor() {
        this.app = express();
        this.server = http.createServer(this.app);
        this.io = new Server(this.server);
        this.port = process.env.PORT || 3000;
        this.deployments = new Map();
        this.setupMiddleware();
        this.setupRoutes();
        this.setupWebSocket();
    }

    setupMiddleware() {
        this.app.use(express.static(path.join(__dirname, 'static')));
        this.app.use(express.static(path.join(__dirname, 'dist')));
        this.app.use(express.json());
        this.app.use(express.urlencoded({ extended: true }));
    }

    setupRoutes() {
        // Main interface
        this.app.get('/', (req, res) => {
            res.sendFile(path.join(__dirname, 'templates', 'index.html'));
        });

        // API endpoints
        this.app.get('/api/scripts', async (req, res) => {
            try {
                const scripts = await this.getAvailableScripts();
                res.json(scripts);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });

        this.app.post('/api/deploy', async (req, res) => {
            try {
                const { script, config } = req.body;
                const deploymentId = await this.startDeployment(script, config);
                res.json({ deploymentId, status: 'started' });
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });

        this.app.get('/api/deployments/:id/status', (req, res) => {
            const deployment = this.deployments.get(req.params.id);
            if (!deployment) {
                return res.status(404).json({ error: 'Deployment not found' });
            }
            res.json(deployment);
        });
    }

    setupWebSocket() {
        this.io.on('connection', (socket) => {
            console.log(chalk.green('🔗 Client connected'));
            
            socket.on('subscribe-deployment', (deploymentId) => {
                socket.join(`deployment-${deploymentId}`);
            });

            socket.on('disconnect', () => {
                console.log(chalk.yellow('🔌 Client disconnected'));
            });
        });
    }

    async getAvailableScripts() {
        const scriptsPath = path.join(__dirname, '..');
        const files = await fs.readdir(scriptsPath);
        const scripts = files
            .filter(file => file.endsWith('.sh'))
            .map(file => ({
                name: file,
                displayName: this.formatScriptName(file),
                description: this.getScriptDescription(file)
            }));
        return scripts;
    }

    formatScriptName(filename) {
        return filename
            .replace(/\.sh$/, '')
            .replace(/_/g, ' ')
            .replace(/\b\w/g, l => l.toUpperCase());
    }

    getScriptDescription(filename) {
        const descriptions = {
            'ddm_optimized.sh': 'Optimized Día de Muertos ComfyUI deployment with latest models',
            'ddm_modern_deploy.sh': '🎭 Modern DDM deployment with @DRKV8R/ENDS agent and dark interface',
            'default.sh': 'Standard ComfyUI deployment with essential nodes',
            'skyreels_installer.sh': 'Video-focused deployment with SkyReels integration',
            'i2v_hunyuan.sh': 'Image-to-video generation with HunyuanVideo',
            'wan21_img2vid.sh': 'WAN 2.1 video generation workflow',
            'videoworkflow.sh': 'Comprehensive video workflow setup',
            'civitai.sh': 'CivitAI model integration and management',
            'kohya.sh': 'Kohya training environment setup'
        };
        return descriptions[filename] || 'ComfyUI deployment script';
    }

    async startDeployment(scriptName, config) {
        const deploymentId = Date.now().toString();
        const scriptPath = path.join(__dirname, '..', scriptName);
        
        const deployment = {
            id: deploymentId,
            script: scriptName,
            config,
            status: 'running',
            startTime: new Date(),
            logs: []
        };

        this.deployments.set(deploymentId, deployment);

        // Start the deployment process
        const process = spawn('bash', [scriptPath], {
            env: { ...process.env, ...config }
        });

        process.stdout.on('data', (data) => {
            const log = data.toString();
            deployment.logs.push({ type: 'stdout', message: log, timestamp: new Date() });
            this.io.to(`deployment-${deploymentId}`).emit('deployment-log', { type: 'stdout', message: log });
        });

        process.stderr.on('data', (data) => {
            const log = data.toString();
            deployment.logs.push({ type: 'stderr', message: log, timestamp: new Date() });
            this.io.to(`deployment-${deploymentId}`).emit('deployment-log', { type: 'stderr', message: log });
        });

        process.on('close', (code) => {
            deployment.status = code === 0 ? 'completed' : 'failed';
            deployment.endTime = new Date();
            this.io.to(`deployment-${deploymentId}`).emit('deployment-status', { status: deployment.status, code });
        });

        return deploymentId;
    }

    start() {
        this.server.listen(this.port, () => {
            console.log(chalk.bold.green(`
🎭 Día de Muertos RunPod Interface
🚀 Server running on port ${this.port}
🌐 Open http://localhost:${this.port}
            `));
        });
    }
}

// Start server if run directly
if (require.main === module) {
    const interface = new DDMInterface();
    interface.start();
}

module.exports = DDMInterface;