class ContentManager {
    constructor() {
        this.socket = io();
        this.selectedContent = new Set();
        this.contentData = [];
        this.currentPage = 1;
        this.itemsPerPage = 12;
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.loadContent();
        this.setupWebSocket();
    }

    setupEventListeners() {
        // Search and filters
        document.getElementById('searchContent').addEventListener('input', this.handleSearch.bind(this));
        document.getElementById('contentTypeFilter').addEventListener('change', this.handleFilter.bind(this));
        document.getElementById('statusFilter').addEventListener('change', this.handleFilter.bind(this));

        // Modal controls
        document.getElementById('closeEditModal').addEventListener('click', this.closeEditModal.bind(this));
        document.getElementById('closeSocialModal').addEventListener('click', this.closeSocialModal.bind(this));

        // Action buttons
        document.getElementById('uploadBtn').addEventListener('click', this.handleUpload.bind(this));
        document.getElementById('bulkActionsBtn').addEventListener('click', this.handleBulkActions.bind(this));

        // Close modals on outside click
        document.getElementById('editModal').addEventListener('click', (e) => {
            if (e.target.id === 'editModal') this.closeEditModal();
        });
        document.getElementById('socialModal').addEventListener('click', (e) => {
            if (e.target.id === 'socialModal') this.closeSocialModal();
        });
    }

    setupWebSocket() {
        this.socket.on('content-updated', (data) => {
            this.updateContentItem(data);
        });

        this.socket.on('upload-progress', (data) => {
            this.updateUploadProgress(data);
        });

        this.socket.on('social-publish-status', (data) => {
            this.updatePublishStatus(data);
        });
    }

    async loadContent() {
        try {
            const response = await fetch('/api/content');
            this.contentData = await response.json();
            this.renderContentGrid();
            this.updatePagination();
        } catch (error) {
            console.error('Failed to load content:', error);
            this.showNotification('Failed to load content', 'error');
        }
    }

    renderContentGrid() {
        const grid = document.getElementById('contentGrid');
        const startIndex = (this.currentPage - 1) * this.itemsPerPage;
        const endIndex = startIndex + this.itemsPerPage;
        const filteredContent = this.getFilteredContent();
        const pageContent = filteredContent.slice(startIndex, endIndex);

        grid.innerHTML = pageContent.map(item => this.createContentCard(item)).join('');

        // Add event listeners to new cards
        grid.querySelectorAll('.content-card').forEach(card => {
            const contentId = card.dataset.contentId;
            
            card.querySelector('.edit-btn').addEventListener('click', () => this.openEditModal(contentId));
            card.querySelector('.social-btn').addEventListener('click', () => this.openSocialModal(contentId));
            card.querySelector('.delete-btn').addEventListener('click', () => this.deleteContent(contentId));
            card.querySelector('.select-checkbox').addEventListener('change', (e) => {
                if (e.target.checked) {
                    this.selectedContent.add(contentId);
                } else {
                    this.selectedContent.delete(contentId);
                }
                this.updateBulkActionsState();
            });
        });
    }

    createContentCard(item) {
        const statusColors = {
            'pending': 'bg-yellow-500/20 text-yellow-400',
            'approved': 'bg-green-500/20 text-green-400',
            'published': 'bg-blue-500/20 text-blue-400',
            'scheduled': 'bg-purple-500/20 text-purple-400'
        };

        const typeIcons = {
            'image': 'fas fa-image',
            'video': 'fas fa-video',
            'animation': 'fas fa-play-circle'
        };

        return `
            <div class="content-card bg-dia-dark/60 backdrop-blur-sm rounded-xl border border-dia-orange/20 hover:border-dia-orange/40 transition-all transform hover:scale-105" data-content-id="${item.id}">
                <div class="relative">
                    <div class="aspect-w-16 aspect-h-9 rounded-t-xl overflow-hidden">
                        ${item.type === 'video' ? 
                            `<video src="${item.thumbnail || item.url}" class="w-full h-48 object-cover" muted></video>` :
                            `<img src="${item.thumbnail || item.url}" alt="${item.title}" class="w-full h-48 object-cover">`
                        }
                    </div>
                    <div class="absolute top-2 left-2">
                        <span class="${statusColors[item.status] || 'bg-gray-500/20 text-gray-400'} px-2 py-1 rounded-full text-xs font-semibold">
                            ${item.status.charAt(0).toUpperCase() + item.status.slice(1)}
                        </span>
                    </div>
                    <div class="absolute top-2 right-2">
                        <input type="checkbox" class="select-checkbox w-4 h-4 text-dia-orange rounded focus:ring-dia-orange">
                    </div>
                    <div class="absolute bottom-2 left-2">
                        <span class="bg-black/70 text-white px-2 py-1 rounded-full text-xs">
                            <i class="${typeIcons[item.type] || 'fas fa-file'} mr-1"></i>
                            ${item.type.toUpperCase()}
                        </span>
                    </div>
                </div>
                
                <div class="p-4">
                    <h3 class="font-semibold text-white mb-2 truncate" title="${item.title}">${item.title}</h3>
                    <p class="text-gray-400 text-sm mb-3 line-clamp-2">${item.description || 'No description'}</p>
                    
                    <div class="flex items-center justify-between text-xs text-gray-500 mb-3">
                        <span><i class="fas fa-calendar mr-1"></i>${new Date(item.createdAt).toLocaleDateString()}</span>
                        <span><i class="fas fa-eye mr-1"></i>${item.views || 0} views</span>
                    </div>

                    ${item.platforms && item.platforms.length > 0 ? `
                        <div class="flex items-center space-x-1 mb-3">
                            ${item.platforms.map(platform => `
                                <span class="platform-badge ${platform}" title="Published on ${platform}">
                                    <i class="${this.getPlatformIcon(platform)}"></i>
                                </span>
                            `).join('')}
                        </div>
                    ` : ''}
                    
                    <div class="flex items-center space-x-2">
                        <button class="edit-btn flex-1 px-3 py-2 bg-dia-orange/20 hover:bg-dia-orange/40 text-dia-orange rounded-lg text-sm font-semibold transition-all">
                            <i class="fas fa-edit mr-1"></i>Edit
                        </button>
                        <button class="social-btn flex-1 px-3 py-2 bg-dia-purple/20 hover:bg-dia-purple/40 text-dia-purple rounded-lg text-sm font-semibold transition-all">
                            <i class="fas fa-share-alt mr-1"></i>Share
                        </button>
                        <button class="delete-btn px-3 py-2 bg-red-500/20 hover:bg-red-500/40 text-red-400 rounded-lg text-sm transition-all">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
            </div>
        `;
    }

    getPlatformIcon(platform) {
        const icons = {
            'instagram': 'fab fa-instagram',
            'onlyfans': 'fas fa-crown',
            'fansly': 'fas fa-star',
            'pornhub': 'fas fa-video',
            'twitter': 'fab fa-twitter',
            'tiktok': 'fab fa-tiktok'
        };
        return icons[platform] || 'fas fa-globe';
    }

    getFilteredContent() {
        const searchTerm = document.getElementById('searchContent').value.toLowerCase();
        const typeFilter = document.getElementById('contentTypeFilter').value;
        const statusFilter = document.getElementById('statusFilter').value;

        return this.contentData.filter(item => {
            const matchesSearch = !searchTerm || 
                item.title.toLowerCase().includes(searchTerm) ||
                (item.description && item.description.toLowerCase().includes(searchTerm));
            
            const matchesType = !typeFilter || item.type === typeFilter;
            const matchesStatus = !statusFilter || item.status === statusFilter;

            return matchesSearch && matchesType && matchesStatus;
        });
    }

    handleSearch() {
        this.currentPage = 1;
        this.renderContentGrid();
        this.updatePagination();
    }

    handleFilter() {
        this.currentPage = 1;
        this.renderContentGrid();
        this.updatePagination();
    }

    openEditModal(contentId) {
        const content = this.contentData.find(item => item.id === contentId);
        if (!content) return;

        const modal = document.getElementById('editModal');
        const modalContent = document.getElementById('editModalContent');

        modalContent.innerHTML = this.createEditForm(content);
        modal.classList.remove('hidden');

        // Setup edit form listeners
        this.setupEditFormListeners(content);
    }

    createEditForm(content) {
        return `
            <form id="editForm" class="space-y-6">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Title</label>
                            <input type="text" id="editTitle" value="${content.title}" 
                                   class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Description</label>
                            <textarea id="editDescription" rows="4" 
                                      class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">${content.description || ''}</textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Tags</label>
                            <input type="text" id="editTags" value="${(content.tags || []).join(', ')}" 
                                   placeholder="Enter tags separated by commas"
                                   class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Status</label>
                            <select id="editStatus" class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                                <option value="pending" ${content.status === 'pending' ? 'selected' : ''}>Pending Review</option>
                                <option value="approved" ${content.status === 'approved' ? 'selected' : ''}>Approved</option>
                                <option value="published" ${content.status === 'published' ? 'selected' : ''}>Published</option>
                                <option value="scheduled" ${content.status === 'scheduled' ? 'selected' : ''}>Scheduled</option>
                            </select>
                        </div>
                    </div>

                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Preview</label>
                            <div class="bg-dia-darker rounded-lg p-4 border border-gray-600">
                                ${content.type === 'video' ? 
                                    `<video src="${content.url}" controls class="w-full rounded-lg max-h-64"></video>` :
                                    `<img src="${content.url}" alt="${content.title}" class="w-full rounded-lg max-h-64 object-cover">`
                                }
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Content Rating</label>
                            <select id="editRating" class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                                <option value="safe" ${content.rating === 'safe' ? 'selected' : ''}>Safe (All Platforms)</option>
                                <option value="suggestive" ${content.rating === 'suggestive' ? 'selected' : ''}>Suggestive (Limited Platforms)</option>
                                <option value="adult" ${content.rating === 'adult' ? 'selected' : ''}>Adult (Adult Platforms Only)</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Publish Date/Time</label>
                            <input type="datetime-local" id="editPublishDate" value="${content.publishDate || ''}"
                                   class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                        </div>
                    </div>
                </div>

                <div class="flex items-center justify-end space-x-4 pt-6 border-t border-gray-600">
                    <button type="button" id="cancelEdit" class="px-6 py-3 bg-gray-600 hover:bg-gray-500 rounded-lg font-semibold transition-all">
                        Cancel
                    </button>
                    <button type="submit" class="px-6 py-3 bg-dia-orange hover:bg-dia-orange/80 rounded-lg font-semibold transition-all">
                        <i class="fas fa-save mr-2"></i>Save Changes
                    </button>
                </div>
            </form>
        `;
    }

    setupEditFormListeners(content) {
        document.getElementById('cancelEdit').addEventListener('click', this.closeEditModal.bind(this));
        document.getElementById('editForm').addEventListener('submit', (e) => {
            e.preventDefault();
            this.saveContentChanges(content.id);
        });
    }

    async saveContentChanges(contentId) {
        const formData = {
            id: contentId,
            title: document.getElementById('editTitle').value,
            description: document.getElementById('editDescription').value,
            tags: document.getElementById('editTags').value.split(',').map(tag => tag.trim()).filter(tag => tag),
            status: document.getElementById('editStatus').value,
            rating: document.getElementById('editRating').value,
            publishDate: document.getElementById('editPublishDate').value
        };

        try {
            const response = await fetch('/api/content/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                this.showNotification('Content updated successfully', 'success');
                this.closeEditModal();
                this.loadContent();
            } else {
                throw new Error('Failed to update content');
            }
        } catch (error) {
            console.error('Failed to save changes:', error);
            this.showNotification('Failed to save changes', 'error');
        }
    }

    openSocialModal(contentId) {
        const content = this.contentData.find(item => item.id === contentId);
        if (!content) return;

        const modal = document.getElementById('socialModal');
        const modalContent = document.getElementById('socialModalContent');

        modalContent.innerHTML = this.createSocialForm(content);
        modal.classList.remove('hidden');

        this.setupSocialFormListeners(content);
    }

    createSocialForm(content) {
        const platforms = [
            { id: 'instagram', name: 'Instagram', icon: 'fab fa-instagram', color: 'from-purple-500 to-pink-500', rating: ['safe', 'suggestive'] },
            { id: 'onlyfans', name: 'OnlyFans', icon: 'fas fa-crown', color: 'from-blue-500 to-cyan-500', rating: ['safe', 'suggestive', 'adult'] },
            { id: 'fansly', name: 'Fansly', icon: 'fas fa-star', color: 'from-indigo-500 to-purple-500', rating: ['safe', 'suggestive', 'adult'] },
            { id: 'pornhub', name: 'PornHub', icon: 'fas fa-video', color: 'from-orange-500 to-red-500', rating: ['adult'] },
            { id: 'twitter', name: 'Twitter/X', icon: 'fab fa-twitter', color: 'from-blue-400 to-blue-600', rating: ['safe', 'suggestive', 'adult'] },
            { id: 'tiktok', name: 'TikTok', icon: 'fab fa-tiktok', color: 'from-pink-500 to-red-500', rating: ['safe'] }
        ];

        const compatiblePlatforms = platforms.filter(platform => 
            platform.rating.includes(content.rating || 'safe')
        );

        return `
            <form id="socialForm" class="space-y-6">
                <div class="bg-dia-darker/50 rounded-lg p-4 border border-dia-orange/20">
                    <h4 class="font-semibold text-dia-orange mb-2">Content Preview</h4>
                    <div class="flex items-start space-x-4">
                        <div class="w-20 h-20 rounded-lg overflow-hidden flex-shrink-0">
                            ${content.type === 'video' ? 
                                `<video src="${content.thumbnail || content.url}" class="w-full h-full object-cover"></video>` :
                                `<img src="${content.thumbnail || content.url}" alt="${content.title}" class="w-full h-full object-cover">`
                            }
                        </div>
                        <div>
                            <h5 class="font-semibold text-white">${content.title}</h5>
                            <p class="text-gray-400 text-sm">${content.description || 'No description'}</p>
                            <div class="flex items-center space-x-2 mt-2">
                                <span class="px-2 py-1 bg-dia-orange/20 text-dia-orange rounded-full text-xs">${content.type.toUpperCase()}</span>
                                <span class="px-2 py-1 bg-gray-600/20 text-gray-400 rounded-full text-xs">${content.rating || 'safe'}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <h4 class="font-semibold text-white mb-4">Select Platforms to Publish</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        ${compatiblePlatforms.map(platform => `
                            <div class="platform-option bg-dia-darker/50 rounded-lg p-4 border border-gray-600 hover:border-dia-orange/40 transition-all cursor-pointer" data-platform="${platform.id}">
                                <label class="flex items-center space-x-3 cursor-pointer">
                                    <input type="checkbox" name="platforms" value="${platform.id}" class="w-4 h-4 text-dia-orange rounded focus:ring-dia-orange">
                                    <div class="flex items-center space-x-3">
                                        <div class="w-10 h-10 rounded-lg bg-gradient-to-r ${platform.color} flex items-center justify-center">
                                            <i class="${platform.icon} text-white"></i>
                                        </div>
                                        <div>
                                            <div class="font-semibold text-white">${platform.name}</div>
                                            <div class="text-xs text-gray-400">Compatible with ${content.rating || 'safe'} content</div>
                                        </div>
                                    </div>
                                </label>
                            </div>
                        `).join('')}
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-300 mb-2">Custom Caption (Optional)</label>
                    <textarea id="customCaption" rows="3" placeholder="Override the default description for social media..."
                              class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all"></textarea>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-300 mb-2">Publish Option</label>
                        <select id="publishOption" class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                            <option value="now">Publish Now</option>
                            <option value="schedule">Schedule for Later</option>
                        </select>
                    </div>
                    <div id="scheduleDateTime" class="hidden">
                        <label class="block text-sm font-medium text-gray-300 mb-2">Schedule Date/Time</label>
                        <input type="datetime-local" id="scheduleDate"
                               class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                    </div>
                </div>

                <div class="flex items-center justify-end space-x-4 pt-6 border-t border-gray-600">
                    <button type="button" id="cancelSocial" class="px-6 py-3 bg-gray-600 hover:bg-gray-500 rounded-lg font-semibold transition-all">
                        Cancel
                    </button>
                    <button type="submit" class="px-6 py-3 bg-dia-purple hover:bg-dia-purple/80 rounded-lg font-semibold transition-all">
                        <i class="fas fa-share-alt mr-2"></i>Publish Content
                    </button>
                </div>
            </form>
        `;
    }

    setupSocialFormListeners(content) {
        document.getElementById('cancelSocial').addEventListener('click', this.closeSocialModal.bind(this));
        document.getElementById('publishOption').addEventListener('change', (e) => {
            const scheduleDiv = document.getElementById('scheduleDateTime');
            if (e.target.value === 'schedule') {
                scheduleDiv.classList.remove('hidden');
            } else {
                scheduleDiv.classList.add('hidden');
            }
        });

        // Platform selection styling
        document.querySelectorAll('.platform-option').forEach(option => {
            option.addEventListener('click', (e) => {
                if (e.target.type !== 'checkbox') {
                    const checkbox = option.querySelector('input[type="checkbox"]');
                    checkbox.checked = !checkbox.checked;
                }
                option.classList.toggle('border-dia-orange', option.querySelector('input').checked);
            });
        });

        document.getElementById('socialForm').addEventListener('submit', (e) => {
            e.preventDefault();
            this.publishToSocial(content.id);
        });
    }

    async publishToSocial(contentId) {
        const selectedPlatforms = Array.from(document.querySelectorAll('input[name="platforms"]:checked'))
            .map(checkbox => checkbox.value);

        if (selectedPlatforms.length === 0) {
            this.showNotification('Please select at least one platform', 'warning');
            return;
        }

        const publishData = {
            contentId,
            platforms: selectedPlatforms,
            customCaption: document.getElementById('customCaption').value,
            publishOption: document.getElementById('publishOption').value,
            scheduleDate: document.getElementById('scheduleDate').value
        };

        try {
            const response = await fetch('/api/content/publish', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(publishData)
            });

            if (response.ok) {
                this.showNotification(`Content ${publishData.publishOption === 'now' ? 'published' : 'scheduled'} successfully`, 'success');
                this.closeSocialModal();
                this.loadContent();
            } else {
                throw new Error('Failed to publish content');
            }
        } catch (error) {
            console.error('Failed to publish:', error);
            this.showNotification('Failed to publish content', 'error');
        }
    }

    closeEditModal() {
        document.getElementById('editModal').classList.add('hidden');
    }

    closeSocialModal() {
        document.getElementById('socialModal').classList.add('hidden');
    }

    async deleteContent(contentId) {
        if (!confirm('Are you sure you want to delete this content? This action cannot be undone.')) {
            return;
        }

        try {
            const response = await fetch(`/api/content/${contentId}`, {
                method: 'DELETE'
            });

            if (response.ok) {
                this.showNotification('Content deleted successfully', 'success');
                this.loadContent();
            } else {
                throw new Error('Failed to delete content');
            }
        } catch (error) {
            console.error('Failed to delete content:', error);
            this.showNotification('Failed to delete content', 'error');
        }
    }

    handleUpload() {
        // Create file input dynamically
        const input = document.createElement('input');
        input.type = 'file';
        input.multiple = true;
        input.accept = 'image/*,video/*';
        
        input.onchange = (e) => {
            const files = Array.from(e.target.files);
            this.uploadFiles(files);
        };
        
        input.click();
    }

    async uploadFiles(files) {
        const formData = new FormData();
        files.forEach(file => {
            formData.append('files', file);
        });

        try {
            const response = await fetch('/api/content/upload', {
                method: 'POST',
                body: formData
            });

            if (response.ok) {
                this.showNotification(`Uploaded ${files.length} file(s) successfully`, 'success');
                this.loadContent();
            } else {
                throw new Error('Failed to upload files');
            }
        } catch (error) {
            console.error('Failed to upload files:', error);
            this.showNotification('Failed to upload files', 'error');
        }
    }

    handleBulkActions() {
        if (this.selectedContent.size === 0) {
            this.showNotification('Please select content items first', 'warning');
            return;
        }

        // Show bulk actions menu
        this.showBulkActionsMenu();
    }

    showBulkActionsMenu() {
        // Simple implementation - could be enhanced with a proper modal
        const actions = [
            'Approve Selected',
            'Publish to Instagram',
            'Publish to OnlyFans',
            'Delete Selected'
        ];

        const action = prompt(`Select action for ${this.selectedContent.size} items:\n${actions.map((a, i) => `${i + 1}. ${a}`).join('\n')}`);
        
        if (action) {
            const actionIndex = parseInt(action) - 1;
            if (actionIndex >= 0 && actionIndex < actions.length) {
                this.executeBulkAction(actions[actionIndex]);
            }
        }
    }

    async executeBulkAction(action) {
        const contentIds = Array.from(this.selectedContent);
        
        try {
            const response = await fetch('/api/content/bulk-action', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    action,
                    contentIds
                })
            });

            if (response.ok) {
                this.showNotification(`Bulk action "${action}" completed successfully`, 'success');
                this.selectedContent.clear();
                this.loadContent();
                this.updateBulkActionsState();
            } else {
                throw new Error('Failed to execute bulk action');
            }
        } catch (error) {
            console.error('Failed to execute bulk action:', error);
            this.showNotification('Failed to execute bulk action', 'error');
        }
    }

    updateBulkActionsState() {
        const bulkBtn = document.getElementById('bulkActionsBtn');
        if (this.selectedContent.size > 0) {
            bulkBtn.textContent = `Bulk Actions (${this.selectedContent.size})`;
            bulkBtn.classList.add('bg-dia-gold', 'hover:bg-dia-gold/80');
            bulkBtn.classList.remove('bg-dia-purple', 'hover:bg-dia-purple/80');
        } else {
            bulkBtn.innerHTML = '<i class="fas fa-tasks mr-2"></i>Bulk Actions';
            bulkBtn.classList.remove('bg-dia-gold', 'hover:bg-dia-gold/80');
            bulkBtn.classList.add('bg-dia-purple', 'hover:bg-dia-purple/80');
        }
    }

    updatePagination() {
        const filteredContent = this.getFilteredContent();
        const totalItems = filteredContent.length;
        const totalPages = Math.ceil(totalItems / this.itemsPerPage);
        const startIndex = (this.currentPage - 1) * this.itemsPerPage + 1;
        const endIndex = Math.min(this.currentPage * this.itemsPerPage, totalItems);

        document.getElementById('showingRange').textContent = `${startIndex}-${endIndex}`;
        document.getElementById('totalItems').textContent = totalItems;
    }

    updateContentItem(data) {
        const index = this.contentData.findIndex(item => item.id === data.id);
        if (index !== -1) {
            this.contentData[index] = { ...this.contentData[index], ...data };
            this.renderContentGrid();
        }
    }

    updateUploadProgress(data) {
        // Could implement a progress bar UI here
        console.log('Upload progress:', data);
    }

    updatePublishStatus(data) {
        this.showNotification(`${data.platform}: ${data.status}`, data.success ? 'success' : 'error');
    }

    showNotification(message, type = 'info') {
        // Simple notification system - could be enhanced
        const notification = document.createElement('div');
        notification.className = `fixed top-4 right-4 z-50 px-6 py-3 rounded-lg font-semibold transition-all transform translate-x-full opacity-0`;
        
        const colors = {
            'success': 'bg-green-500 text-white',
            'error': 'bg-red-500 text-white',
            'warning': 'bg-yellow-500 text-black',
            'info': 'bg-blue-500 text-white'
        };
        
        notification.className += ` ${colors[type] || colors.info}`;
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        // Animate in
        setTimeout(() => {
            notification.classList.remove('translate-x-full', 'opacity-0');
        }, 100);
        
        // Animate out and remove
        setTimeout(() => {
            notification.classList.add('translate-x-full', 'opacity-0');
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new ContentManager();
});