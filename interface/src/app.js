class DDMInterface {
    constructor() {
        this.socket = io();
        this.currentDeployment = null;
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.loadAvailableScripts();
        this.setupWebSocket();
        this.animatePageLoad();
    }

    setupEventListeners() {
        const form = document.getElementById('deploymentForm');
        const scriptSelect = document.getElementById('scriptSelect');
        
        form.addEventListener('submit', this.handleDeployment.bind(this));
        scriptSelect.addEventListener('change', this.handleScriptChange.bind(this));
        
        // Theme toggle
        document.getElementById('themeToggle').addEventListener('click', this.toggleTheme.bind(this));
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
            } else {
                throw new Error(result.error);
            }
        } catch (error) {
            console.error('Deployment failed:', error);
            this.showNotification(`Deployment failed: ${error.message}`, 'error');
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