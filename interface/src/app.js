class DDMInterface {
    constructor() {
        this.socket = io();
        this.currentDeployment = null;
        this.currentSection = 'dashboard';
        this.startTime = Date.now();
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.loadAvailableScripts();
        this.setupWebSocket();
        this.animatePageLoad();
        this.startSystemMonitoring();
        this.updateUptime();
    }

    setupEventListeners() {
        const form = document.getElementById('deploymentForm');
        const scriptSelect = document.getElementById('scriptSelect');
        
        form.addEventListener('submit', this.handleDeployment.bind(this));
        scriptSelect.addEventListener('change', this.handleScriptChange.bind(this));
        
        // Theme toggle
        document.getElementById('themeToggle').addEventListener('click', this.toggleTheme.bind(this));
        
        // Mobile menu toggle
        document.getElementById('mobileMenuToggle').addEventListener('click', this.toggleMobileMenu.bind(this));
        
        // Navigation
        document.querySelectorAll('.nav-link, .nav-link-mobile').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const section = e.target.closest('a').dataset.section;
                this.switchSection(section);
            });
        });
        
        // Quick deploy buttons
        document.querySelectorAll('.quick-deploy-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const script = e.currentTarget.dataset.script;
                this.quickDeploy(script);
            });
        });
    }

    toggleMobileMenu() {
        const mobileNav = document.getElementById('mobileNav');
        mobileNav.classList.toggle('hidden');
    }

    switchSection(section) {
        // Hide all sections
        document.querySelectorAll('.dashboard-section').forEach(sec => {
            sec.classList.add('hidden');
        });
        
        // Show selected section
        document.getElementById(`${section}-section`).classList.remove('hidden');
        
        // Update navigation
        document.querySelectorAll('.nav-link, .nav-link-mobile').forEach(link => {
            const isActive = link.dataset.section === section;
            if (link.classList.contains('nav-link')) {
                // Desktop navigation
                if (isActive) {
                    link.className = 'nav-link text-dia-orange border-b-2 border-dia-orange';
                } else {
                    link.className = 'nav-link text-gray-300 hover:text-dia-orange transition-all';
                }
            } else {
                // Mobile navigation
                if (isActive) {
                    link.className = 'nav-link-mobile text-dia-orange bg-dia-orange/10 px-4 py-2 rounded-lg';
                } else {
                    const colors = {
                        deployments: 'hover:text-dia-purple hover:bg-dia-purple/10',
                        monitoring: 'hover:text-dia-gold hover:bg-dia-gold/10',
                        system: 'hover:text-dia-orange hover:bg-dia-orange/10'
                    };
                    const colorClass = colors[link.dataset.section] || 'hover:text-dia-orange hover:bg-dia-orange/10';
                    link.className = `nav-link-mobile text-gray-300 ${colorClass} px-4 py-2 rounded-lg transition-all`;
                }
            }
        });
        
        this.currentSection = section;
        
        // Hide mobile menu after selection
        document.getElementById('mobileNav').classList.add('hidden');
        
        // Section-specific initialization
        if (section === 'monitoring') {
            this.updateSystemMetrics();
        } else if (section === 'system') {
            this.updateSystemInfo();
        }
    }

    quickDeploy(script) {
        // Switch to deployments section
        this.switchSection('deployments');
        
        // Set the script in the dropdown
        document.getElementById('scriptSelect').value = script;
        
        // Trigger change event to show description
        document.getElementById('scriptSelect').dispatchEvent(new Event('change'));
        
        // Show notification
        this.showNotification(`Quick deploy selected: ${script.replace('.sh', '').replace(/_/g, ' ')}`, 'info');
    }

    startSystemMonitoring() {
        setInterval(() => {
            this.updateSystemMetrics();
            this.updateUptime();
        }, 5000);
    }

    updateSystemMetrics() {
        // Simulate system metrics (in a real app, these would come from the server)
        const metrics = {
            memory: (Math.random() * 40 + 30).toFixed(1) + '%',
            cpu: (Math.random() * 60 + 20).toFixed(1) + '%',
            gpu: (Math.random() * 80 + 10).toFixed(1) + '%'
        };
        
        const memoryEl = document.getElementById('memoryUsage');
        const cpuEl = document.getElementById('cpuUsage');
        const gpuEl = document.getElementById('gpuUsage');
        
        if (memoryEl) memoryEl.textContent = metrics.memory;
        if (cpuEl) cpuEl.textContent = metrics.cpu;
        if (gpuEl) gpuEl.textContent = metrics.gpu;
    }

    updateSystemInfo() {
        // Update version information (since process is not available in browser, use static values)
        const nodeEl = document.getElementById('nodeVersion');
        const pythonEl = document.getElementById('pythonVersion');
        
        if (nodeEl) nodeEl.textContent = 'v18.x';
        if (pythonEl) pythonEl.textContent = '3.11.x';
    }

    updateUptime() {
        const uptimeEl = document.getElementById('uptime');
        if (uptimeEl) {
            const uptime = Date.now() - this.startTime;
            const hours = Math.floor(uptime / (1000 * 60 * 60));
            const minutes = Math.floor((uptime % (1000 * 60 * 60)) / (1000 * 60));
            uptimeEl.textContent = `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
        }
    }

    addRecentActivity(message, type = 'info') {
        const container = document.getElementById('recentActivity');
        if (!container) return;
        
        // Remove placeholder if present
        const placeholder = container.querySelector('.text-center');
        if (placeholder) {
            placeholder.remove();
        }
        
        const activity = document.createElement('div');
        activity.className = 'flex items-center space-x-3 p-3 bg-dia-darker/50 rounded-lg border-l-4';
        
        const colors = {
            info: 'border-dia-orange text-dia-orange',
            success: 'border-green-400 text-green-400',
            error: 'border-red-400 text-red-400',
            warning: 'border-yellow-400 text-yellow-400'
        };
        
        const icons = {
            info: 'info-circle',
            success: 'check-circle',
            error: 'exclamation-circle',
            warning: 'exclamation-triangle'
        };
        
        activity.className += ` ${colors[type] || colors.info}`;
        
        activity.innerHTML = `
            <i class="fas fa-${icons[type] || icons.info}"></i>
            <div class="flex-1">
                <p class="text-white text-sm">${message}</p>
                <p class="text-gray-500 text-xs">${new Date().toLocaleTimeString()}</p>
            </div>
        `;
        
        container.insertBefore(activity, container.firstChild);
        
        // Keep only last 5 activities
        while (container.children.length > 5) {
            container.removeChild(container.lastChild);
        }
    }

    setupWebSocket() {
        this.socket.on('deployment-log', (data) => {
            this.appendLog(data.message, data.type);
        });

        this.socket.on('deployment-status', (data) => {
            this.updateDeploymentStatus(data.status, data.code);
        });
    }

    async loadAvailableScripts() {
        try {
            const response = await fetch('/api/scripts');
            const scripts = await response.json();
            this.populateScriptSelect(scripts);
            document.getElementById('totalScripts').textContent = scripts.length;
        } catch (error) {
            console.error('Failed to load scripts:', error);
            this.showNotification('Failed to load available scripts', 'error');
        }
    }

    populateScriptSelect(scripts) {
        const select = document.getElementById('scriptSelect');
        select.innerHTML = '<option value="">Choose a deployment script...</option>';
        
        scripts.forEach(script => {
            const option = document.createElement('option');
            option.value = script.name;
            option.textContent = script.displayName;
            option.dataset.description = script.description;
            select.appendChild(option);
        });
    }

    handleScriptChange(event) {
        const select = event.target;
        const description = document.getElementById('scriptDescription');
        const selectedOption = select.options[select.selectedIndex];
        
        if (selectedOption && selectedOption.dataset.description) {
            description.innerHTML = `
                <div class="flex items-start space-x-3">
                    <i class="fas fa-info-circle text-dia-orange mt-1"></i>
                    <div>
                        <h4 class="font-semibold text-dia-orange">${selectedOption.textContent}</h4>
                        <p class="text-gray-300 mt-1">${selectedOption.dataset.description}</p>
                    </div>
                </div>
            `;
            description.classList.remove('hidden');
        } else {
            description.classList.add('hidden');
        }
    }

    async handleDeployment(event) {
        event.preventDefault();
        
        const formData = new FormData(event.target);
        const scriptSelect = document.getElementById('scriptSelect');
        const script = scriptSelect.value;
        
        if (!script) {
            this.showNotification('Please select a deployment script', 'warning');
            return;
        }

        const config = {
            script: script,
            gpu: formData.get('gpu') || 'RTX4090',
            size: formData.get('size') || 'small'
        };

        try {
            const response = await fetch('/api/deploy', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ script, config })
            });

            const result = await response.json();
            
            if (response.ok) {
                this.currentDeployment = result.deploymentId;
                this.socket.emit('subscribe-deployment', result.deploymentId);
                this.clearLogs();
                this.appendLog(`🚀 Starting deployment: ${script}`, 'info');
                this.updateActiveDeployments();
                this.showNotification('Deployment started successfully', 'success');
                this.addRecentActivity(`Started deployment: ${script.replace('.sh', '').replace(/_/g, ' ')}`, 'info');
            } else {
                throw new Error(result.error);
            }
        } catch (error) {
            console.error('Deployment failed:', error);
            this.showNotification(`Deployment failed: ${error.message}`, 'error');
            this.addRecentActivity(`Deployment failed: ${error.message}`, 'error');
        }
    }

    clearLogs() {
        const container = document.getElementById('logContainer');
        container.innerHTML = '';
    }

    appendLog(message, type = 'stdout') {
        const container = document.getElementById('logContainer');
        const logEntry = document.createElement('div');
        logEntry.className = `mb-1 ${type === 'stderr' ? 'text-red-400' : type === 'info' ? 'text-dia-gold' : 'text-gray-300'}`;
        
        const timestamp = new Date().toLocaleTimeString();
        logEntry.innerHTML = `
            <span class="text-gray-500 text-xs">[${timestamp}]</span> 
            <span>${this.escapeHtml(message)}</span>
        `;
        
        container.appendChild(logEntry);
        container.scrollTop = container.scrollHeight;
    }

    updateDeploymentStatus(status, code) {
        const statusColor = status === 'completed' ? 'text-green-400' : status === 'failed' ? 'text-red-400' : 'text-yellow-400';
        this.appendLog(`📊 Deployment ${status} (exit code: ${code})`, 'info');
        
        if (status === 'completed' || status === 'failed') {
            this.currentDeployment = null;
            this.updateActiveDeployments();
            this.addRecentActivity(`Deployment ${status}`, status === 'completed' ? 'success' : 'error');
        }
    }

    updateActiveDeployments() {
        const count = this.currentDeployment ? 1 : 0;
        document.getElementById('activeDeployments').textContent = count;
    }

    showNotification(message, type = 'info') {
        // Create notification element
        const notification = document.createElement('div');
        notification.className = `
            fixed top-4 right-4 z-50 max-w-sm w-full bg-dia-dark border-l-4 p-4 rounded-lg shadow-lg transform translate-x-full transition-transform duration-300
            ${type === 'success' ? 'border-green-400' : type === 'error' ? 'border-red-400' : type === 'warning' ? 'border-yellow-400' : 'border-dia-orange'}
        `;
        
        const icon = type === 'success' ? 'check-circle' : type === 'error' ? 'exclamation-circle' : type === 'warning' ? 'exclamation-triangle' : 'info-circle';
        const iconColor = type === 'success' ? 'text-green-400' : type === 'error' ? 'text-red-400' : type === 'warning' ? 'text-yellow-400' : 'text-dia-orange';
        
        notification.innerHTML = `
            <div class="flex items-center">
                <i class="fas fa-${icon} ${iconColor} mr-3"></i>
                <span class="text-white">${message}</span>
                <button class="ml-auto text-gray-400 hover:text-white" onclick="this.parentElement.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        `;
        
        document.body.appendChild(notification);
        
        // Animate in
        setTimeout(() => {
            notification.classList.remove('translate-x-full');
        }, 100);
        
        // Auto remove after 5 seconds
        setTimeout(() => {
            notification.classList.add('translate-x-full');
            setTimeout(() => notification.remove(), 300);
        }, 5000);
    }

    toggleTheme() {
        const html = document.documentElement;
        const icon = document.querySelector('#themeToggle i');
        
        if (html.classList.contains('dark')) {
            html.classList.remove('dark');
            icon.className = 'fas fa-sun';
        } else {
            html.classList.add('dark');
            icon.className = 'fas fa-moon';
        }
    }

    animatePageLoad() {
        // Animate cards on load
        const cards = document.querySelectorAll('.animate-slide-up');
        cards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new DDMInterface();
});