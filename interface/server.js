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

        // Content Management Routes
        this.app.get('/content-manager', (req, res) => {
            res.sendFile(path.join(__dirname, 'templates', 'content-manager.html'));
        });

        this.app.get('/api/content', async (req, res) => {
            try {
                const content = await this.getContentLibrary();
                res.json(content);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });

        this.app.post('/api/content/upload', async (req, res) => {
            try {
                // Handle file upload - simplified for demo
                const result = await this.handleContentUpload(req);
                res.json(result);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });

        this.app.post('/api/content/update', async (req, res) => {
            try {
                const result = await this.updateContent(req.body);
                res.json(result);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });

        this.app.post('/api/content/publish', async (req, res) => {
            try {
                const result = await this.publishToSocialPlatforms(req.body);
                res.json(result);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });

        this.app.delete('/api/content/:id', async (req, res) => {
            try {
                const result = await this.deleteContent(req.params.id);
                res.json(result);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
        });

        this.app.post('/api/content/bulk-action', async (req, res) => {
            try {
                const result = await this.executeBulkAction(req.body);
                res.json(result);
            } catch (error) {
                res.status(500).json({ error: error.message });
            }
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
        const deploymentProcess = spawn('bash', [scriptPath], {
            env: { ...process.env, ...config }
        });

        deploymentProcess.stdout.on('data', (data) => {
            const log = data.toString();
            deployment.logs.push({ type: 'stdout', message: log, timestamp: new Date() });
            this.io.to(`deployment-${deploymentId}`).emit('deployment-log', { type: 'stdout', message: log });
        });

        deploymentProcess.stderr.on('data', (data) => {
            const log = data.toString();
            deployment.logs.push({ type: 'stderr', message: log, timestamp: new Date() });
            this.io.to(`deployment-${deploymentId}`).emit('deployment-log', { type: 'stderr', message: log });
        });

        deploymentProcess.on('close', (code) => {
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

    // Content Management Methods
    async getContentLibrary() {
        // Mock data for demonstration - in production, this would query a database
        return [
            {
                id: '1',
                title: 'Día de Muertos Portrait 1',
                description: 'Beautiful AI-generated portrait with Day of the Dead themes',
                type: 'image',
                status: 'approved',
                rating: 'safe',
                url: '/generated/portrait1.jpg',
                thumbnail: '/generated/portrait1_thumb.jpg',
                createdAt: new Date(Date.now() - 86400000 * 2).toISOString(),
                views: 1250,
                platforms: ['instagram'],
                tags: ['portrait', 'dia-de-muertos', 'art']
            },
            {
                id: '2',
                title: 'Animated Skull Dance',
                description: 'Mesmerizing animated sequence of dancing skulls',
                type: 'video',
                status: 'pending',
                rating: 'safe',
                url: '/generated/animation1.mp4',
                thumbnail: '/generated/animation1_thumb.jpg',
                createdAt: new Date(Date.now() - 86400000).toISOString(),
                views: 890,
                platforms: [],
                tags: ['animation', 'skulls', 'dance']
            },
            {
                id: '3',
                title: 'Mystical Portrait Series',
                description: 'Sensual and artistic portrait with mystical elements',
                type: 'image',
                status: 'approved',
                rating: 'suggestive',
                url: '/generated/portrait2.jpg',
                thumbnail: '/generated/portrait2_thumb.jpg',
                createdAt: new Date(Date.now() - 86400000 * 3).toISOString(),
                views: 2340,
                platforms: ['onlyfans', 'fansly'],
                tags: ['portrait', 'mystical', 'artistic']
            },
            {
                id: '4',
                title: 'Adult Fantasy Art',
                description: 'Artistic adult content with fantasy themes',
                type: 'image',
                status: 'published',
                rating: 'adult',
                url: '/generated/adult1.jpg',
                thumbnail: '/generated/adult1_thumb.jpg',
                createdAt: new Date(Date.now() - 86400000 * 4).toISOString(),
                views: 5670,
                platforms: ['onlyfans', 'pornhub'],
                tags: ['fantasy', 'adult', 'artistic']
            },
            {
                id: '5',
                title: 'Halloween Special Video',
                description: 'Special Halloween-themed video content',
                type: 'video',
                status: 'scheduled',
                rating: 'safe',
                url: '/generated/halloween.mp4',
                thumbnail: '/generated/halloween_thumb.jpg',
                createdAt: new Date().toISOString(),
                views: 0,
                platforms: [],
                tags: ['halloween', 'special', 'video'],
                publishDate: new Date(Date.now() + 86400000).toISOString()
            },
            {
                id: '6',
                title: 'Fashion Portrait Collection',
                description: 'High-fashion inspired portrait series',
                type: 'image',
                status: 'approved',
                rating: 'safe',
                url: '/generated/fashion1.jpg',
                thumbnail: '/generated/fashion1_thumb.jpg',
                createdAt: new Date(Date.now() - 86400000 * 5).toISOString(),
                views: 3450,
                platforms: ['instagram', 'twitter'],
                tags: ['fashion', 'portrait', 'style']
            },
            {
                id: '7',
                title: 'Artistic Nude Study',
                description: 'Tasteful artistic nude photography',
                type: 'image',
                status: 'published',
                rating: 'adult',
                url: '/generated/nude1.jpg',
                thumbnail: '/generated/nude1_thumb.jpg',
                createdAt: new Date(Date.now() - 86400000 * 6).toISOString(),
                views: 8920,
                platforms: ['onlyfans', 'fansly'],
                tags: ['artistic', 'nude', 'photography']
            },
            {
                id: '8',
                title: 'Dance Performance Video',
                description: 'Captivating dance performance with special effects',
                type: 'video',
                status: 'approved',
                rating: 'suggestive',
                url: '/generated/dance1.mp4',
                thumbnail: '/generated/dance1_thumb.jpg',
                createdAt: new Date(Date.now() - 86400000 * 7).toISOString(),
                views: 2150,
                platforms: ['tiktok'],
                tags: ['dance', 'performance', 'entertainment']
            }
        ];
    }

    async handleContentUpload(req) {
        // Mock implementation - in production, handle actual file uploads
        console.log('Content upload requested');
        return { success: true, message: 'Files uploaded successfully' };
    }

    async updateContent(contentData) {
        // Mock implementation - in production, update database
        console.log('Content update requested:', contentData);
        
        // Emit update to connected clients
        this.io.emit('content-updated', contentData);
        
        return { success: true, message: 'Content updated successfully' };
    }

    async publishToSocialPlatforms(publishData) {
        console.log('Social media publish requested:', publishData);
        
        const { contentId, platforms, customCaption, publishOption, scheduleDate } = publishData;
        
        // Mock platform publishing
        for (const platform of platforms) {
            setTimeout(() => {
                this.io.emit('social-publish-status', {
                    contentId,
                    platform,
                    status: 'Published successfully',
                    success: true
                });
            }, Math.random() * 2000 + 1000); // Random delay 1-3 seconds
        }
        
        return { 
            success: true, 
            message: `Content ${publishOption === 'now' ? 'published' : 'scheduled'} to ${platforms.length} platform(s)` 
        };
    }

    async deleteContent(contentId) {
        // Mock implementation - in production, delete from database and storage
        console.log('Content deletion requested:', contentId);
        return { success: true, message: 'Content deleted successfully' };
    }

    async executeBulkAction(actionData) {
        console.log('Bulk action requested:', actionData);
        
        const { action, contentIds } = actionData;
        
        // Mock bulk action execution
        setTimeout(() => {
            this.io.emit('bulk-action-complete', {
                action,
                contentIds,
                success: true
            });
        }, 2000);
        
        return { success: true, message: `Bulk action "${action}" executed for ${contentIds.length} items` };
    }
}

// Start server if run directly
if (require.main === module) {
    const interface = new DDMInterface();
    interface.start();
}

module.exports = DDMInterface;