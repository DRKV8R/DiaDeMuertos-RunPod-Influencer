(()=>{var l=class{constructor(){this.socket=io(),this.selectedContent=new Set,this.contentData=[],this.currentPage=1,this.itemsPerPage=12,this.init()}init(){this.setupEventListeners(),this.loadContent(),this.setupWebSocket()}setupEventListeners(){document.getElementById("searchContent").addEventListener("input",this.handleSearch.bind(this)),document.getElementById("contentTypeFilter").addEventListener("change",this.handleFilter.bind(this)),document.getElementById("statusFilter").addEventListener("change",this.handleFilter.bind(this)),document.getElementById("closeEditModal").addEventListener("click",this.closeEditModal.bind(this)),document.getElementById("closeSocialModal").addEventListener("click",this.closeSocialModal.bind(this)),document.getElementById("uploadBtn").addEventListener("click",this.handleUpload.bind(this)),document.getElementById("bulkActionsBtn").addEventListener("click",this.handleBulkActions.bind(this)),document.getElementById("editModal").addEventListener("click",e=>{e.target.id==="editModal"&&this.closeEditModal()}),document.getElementById("socialModal").addEventListener("click",e=>{e.target.id==="socialModal"&&this.closeSocialModal()})}setupWebSocket(){this.socket.on("content-updated",e=>{this.updateContentItem(e)}),this.socket.on("upload-progress",e=>{this.updateUploadProgress(e)}),this.socket.on("social-publish-status",e=>{this.updatePublishStatus(e)})}async loadContent(){try{let e=await fetch("/api/content");this.contentData=await e.json(),this.renderContentGrid(),this.updatePagination()}catch(e){console.error("Failed to load content:",e),this.showNotification("Failed to load content","error")}}renderContentGrid(){let e=document.getElementById("contentGrid"),t=(this.currentPage-1)*this.itemsPerPage,s=t+this.itemsPerPage,o=this.getFilteredContent().slice(t,s);e.innerHTML=o.map(a=>this.createContentCard(a)).join(""),e.querySelectorAll(".content-card").forEach(a=>{let n=a.dataset.contentId;a.querySelector(".edit-btn").addEventListener("click",()=>this.openEditModal(n)),a.querySelector(".social-btn").addEventListener("click",()=>this.openSocialModal(n)),a.querySelector(".delete-btn").addEventListener("click",()=>this.deleteContent(n)),a.querySelector(".select-checkbox").addEventListener("change",d=>{d.target.checked?this.selectedContent.add(n):this.selectedContent.delete(n),this.updateBulkActionsState()})})}createContentCard(e){let t={pending:"bg-yellow-500/20 text-yellow-400",approved:"bg-green-500/20 text-green-400",published:"bg-blue-500/20 text-blue-400",scheduled:"bg-purple-500/20 text-purple-400"},s={image:"fas fa-image",video:"fas fa-video",animation:"fas fa-play-circle"};return`
            <div class="content-card bg-dia-dark/60 backdrop-blur-sm rounded-xl border border-dia-orange/20 hover:border-dia-orange/40 transition-all transform hover:scale-105" data-content-id="${e.id}">
                <div class="relative">
                    <div class="aspect-w-16 aspect-h-9 rounded-t-xl overflow-hidden">
                        ${e.type==="video"?`<video src="${e.thumbnail||e.url}" class="w-full h-48 object-cover" muted></video>`:`<img src="${e.thumbnail||e.url}" alt="${e.title}" class="w-full h-48 object-cover">`}
                    </div>
                    <div class="absolute top-2 left-2">
                        <span class="${t[e.status]||"bg-gray-500/20 text-gray-400"} px-2 py-1 rounded-full text-xs font-semibold">
                            ${e.status.charAt(0).toUpperCase()+e.status.slice(1)}
                        </span>
                    </div>
                    <div class="absolute top-2 right-2">
                        <input type="checkbox" class="select-checkbox w-4 h-4 text-dia-orange rounded focus:ring-dia-orange">
                    </div>
                    <div class="absolute bottom-2 left-2">
                        <span class="bg-black/70 text-white px-2 py-1 rounded-full text-xs">
                            <i class="${s[e.type]||"fas fa-file"} mr-1"></i>
                            ${e.type.toUpperCase()}
                        </span>
                    </div>
                </div>
                
                <div class="p-4">
                    <h3 class="font-semibold text-white mb-2 truncate" title="${e.title}">${e.title}</h3>
                    <p class="text-gray-400 text-sm mb-3 line-clamp-2">${e.description||"No description"}</p>
                    
                    <div class="flex items-center justify-between text-xs text-gray-500 mb-3">
                        <span><i class="fas fa-calendar mr-1"></i>${new Date(e.createdAt).toLocaleDateString()}</span>
                        <span><i class="fas fa-eye mr-1"></i>${e.views||0} views</span>
                    </div>

                    ${e.platforms&&e.platforms.length>0?`
                        <div class="flex items-center space-x-1 mb-3">
                            ${e.platforms.map(i=>`
                                <span class="platform-badge ${i}" title="Published on ${i}">
                                    <i class="${this.getPlatformIcon(i)}"></i>
                                </span>
                            `).join("")}
                        </div>
                    `:""}
                    
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
        `}getPlatformIcon(e){return{instagram:"fab fa-instagram",onlyfans:"fas fa-crown",fansly:"fas fa-star",pornhub:"fas fa-video",twitter:"fab fa-twitter",tiktok:"fab fa-tiktok"}[e]||"fas fa-globe"}getFilteredContent(){let e=document.getElementById("searchContent").value.toLowerCase(),t=document.getElementById("contentTypeFilter").value,s=document.getElementById("statusFilter").value;return this.contentData.filter(i=>{let o=!e||i.title.toLowerCase().includes(e)||i.description&&i.description.toLowerCase().includes(e),a=!t||i.type===t,n=!s||i.status===s;return o&&a&&n})}handleSearch(){this.currentPage=1,this.renderContentGrid(),this.updatePagination()}handleFilter(){this.currentPage=1,this.renderContentGrid(),this.updatePagination()}openEditModal(e){let t=this.contentData.find(o=>o.id===e);if(!t)return;let s=document.getElementById("editModal"),i=document.getElementById("editModalContent");i.innerHTML=this.createEditForm(t),s.classList.remove("hidden"),this.setupEditFormListeners(t)}createEditForm(e){return`
            <form id="editForm" class="space-y-6">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Title</label>
                            <input type="text" id="editTitle" value="${e.title}" 
                                   class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                        </div>
                        
                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Description</label>
                            <textarea id="editDescription" rows="4" 
                                      class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">${e.description||""}</textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Tags</label>
                            <input type="text" id="editTags" value="${(e.tags||[]).join(", ")}" 
                                   placeholder="Enter tags separated by commas"
                                   class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Status</label>
                            <select id="editStatus" class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                                <option value="pending" ${e.status==="pending"?"selected":""}>Pending Review</option>
                                <option value="approved" ${e.status==="approved"?"selected":""}>Approved</option>
                                <option value="published" ${e.status==="published"?"selected":""}>Published</option>
                                <option value="scheduled" ${e.status==="scheduled"?"selected":""}>Scheduled</option>
                            </select>
                        </div>
                    </div>

                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Preview</label>
                            <div class="bg-dia-darker rounded-lg p-4 border border-gray-600">
                                ${e.type==="video"?`<video src="${e.url}" controls class="w-full rounded-lg max-h-64"></video>`:`<img src="${e.url}" alt="${e.title}" class="w-full rounded-lg max-h-64 object-cover">`}
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Content Rating</label>
                            <select id="editRating" class="w-full bg-dia-darker border border-gray-600 rounded-lg px-4 py-3 text-white focus:border-dia-orange focus:ring-1 focus:ring-dia-orange transition-all">
                                <option value="safe" ${e.rating==="safe"?"selected":""}>Safe (All Platforms)</option>
                                <option value="suggestive" ${e.rating==="suggestive"?"selected":""}>Suggestive (Limited Platforms)</option>
                                <option value="adult" ${e.rating==="adult"?"selected":""}>Adult (Adult Platforms Only)</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-300 mb-2">Publish Date/Time</label>
                            <input type="datetime-local" id="editPublishDate" value="${e.publishDate||""}"
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
        `}setupEditFormListeners(e){document.getElementById("cancelEdit").addEventListener("click",this.closeEditModal.bind(this)),document.getElementById("editForm").addEventListener("submit",t=>{t.preventDefault(),this.saveContentChanges(e.id)})}async saveContentChanges(e){let t={id:e,title:document.getElementById("editTitle").value,description:document.getElementById("editDescription").value,tags:document.getElementById("editTags").value.split(",").map(s=>s.trim()).filter(s=>s),status:document.getElementById("editStatus").value,rating:document.getElementById("editRating").value,publishDate:document.getElementById("editPublishDate").value};try{if((await fetch("/api/content/update",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify(t)})).ok)this.showNotification("Content updated successfully","success"),this.closeEditModal(),this.loadContent();else throw new Error("Failed to update content")}catch(s){console.error("Failed to save changes:",s),this.showNotification("Failed to save changes","error")}}openSocialModal(e){let t=this.contentData.find(o=>o.id===e);if(!t)return;let s=document.getElementById("socialModal"),i=document.getElementById("socialModalContent");i.innerHTML=this.createSocialForm(t),s.classList.remove("hidden"),this.setupSocialFormListeners(t)}createSocialForm(e){let s=[{id:"instagram",name:"Instagram",icon:"fab fa-instagram",color:"from-purple-500 to-pink-500",rating:["safe","suggestive"]},{id:"onlyfans",name:"OnlyFans",icon:"fas fa-crown",color:"from-blue-500 to-cyan-500",rating:["safe","suggestive","adult"]},{id:"fansly",name:"Fansly",icon:"fas fa-star",color:"from-indigo-500 to-purple-500",rating:["safe","suggestive","adult"]},{id:"pornhub",name:"PornHub",icon:"fas fa-video",color:"from-orange-500 to-red-500",rating:["adult"]},{id:"twitter",name:"Twitter/X",icon:"fab fa-twitter",color:"from-blue-400 to-blue-600",rating:["safe","suggestive","adult"]},{id:"tiktok",name:"TikTok",icon:"fab fa-tiktok",color:"from-pink-500 to-red-500",rating:["safe"]}].filter(i=>i.rating.includes(e.rating||"safe"));return`
            <form id="socialForm" class="space-y-6">
                <div class="bg-dia-darker/50 rounded-lg p-4 border border-dia-orange/20">
                    <h4 class="font-semibold text-dia-orange mb-2">Content Preview</h4>
                    <div class="flex items-start space-x-4">
                        <div class="w-20 h-20 rounded-lg overflow-hidden flex-shrink-0">
                            ${e.type==="video"?`<video src="${e.thumbnail||e.url}" class="w-full h-full object-cover"></video>`:`<img src="${e.thumbnail||e.url}" alt="${e.title}" class="w-full h-full object-cover">`}
                        </div>
                        <div>
                            <h5 class="font-semibold text-white">${e.title}</h5>
                            <p class="text-gray-400 text-sm">${e.description||"No description"}</p>
                            <div class="flex items-center space-x-2 mt-2">
                                <span class="px-2 py-1 bg-dia-orange/20 text-dia-orange rounded-full text-xs">${e.type.toUpperCase()}</span>
                                <span class="px-2 py-1 bg-gray-600/20 text-gray-400 rounded-full text-xs">${e.rating||"safe"}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <h4 class="font-semibold text-white mb-4">Select Platforms to Publish</h4>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        ${s.map(i=>`
                            <div class="platform-option bg-dia-darker/50 rounded-lg p-4 border border-gray-600 hover:border-dia-orange/40 transition-all cursor-pointer" data-platform="${i.id}">
                                <label class="flex items-center space-x-3 cursor-pointer">
                                    <input type="checkbox" name="platforms" value="${i.id}" class="w-4 h-4 text-dia-orange rounded focus:ring-dia-orange">
                                    <div class="flex items-center space-x-3">
                                        <div class="w-10 h-10 rounded-lg bg-gradient-to-r ${i.color} flex items-center justify-center">
                                            <i class="${i.icon} text-white"></i>
                                        </div>
                                        <div>
                                            <div class="font-semibold text-white">${i.name}</div>
                                            <div class="text-xs text-gray-400">Compatible with ${e.rating||"safe"} content</div>
                                        </div>
                                    </div>
                                </label>
                            </div>
                        `).join("")}
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
        `}setupSocialFormListeners(e){document.getElementById("cancelSocial").addEventListener("click",this.closeSocialModal.bind(this)),document.getElementById("publishOption").addEventListener("change",t=>{let s=document.getElementById("scheduleDateTime");t.target.value==="schedule"?s.classList.remove("hidden"):s.classList.add("hidden")}),document.querySelectorAll(".platform-option").forEach(t=>{t.addEventListener("click",s=>{if(s.target.type!=="checkbox"){let i=t.querySelector('input[type="checkbox"]');i.checked=!i.checked}t.classList.toggle("border-dia-orange",t.querySelector("input").checked)})}),document.getElementById("socialForm").addEventListener("submit",t=>{t.preventDefault(),this.publishToSocial(e.id)})}async publishToSocial(e){let t=Array.from(document.querySelectorAll('input[name="platforms"]:checked')).map(i=>i.value);if(t.length===0){this.showNotification("Please select at least one platform","warning");return}let s={contentId:e,platforms:t,customCaption:document.getElementById("customCaption").value,publishOption:document.getElementById("publishOption").value,scheduleDate:document.getElementById("scheduleDate").value};try{if((await fetch("/api/content/publish",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify(s)})).ok)this.showNotification(`Content ${s.publishOption==="now"?"published":"scheduled"} successfully`,"success"),this.closeSocialModal(),this.loadContent();else throw new Error("Failed to publish content")}catch(i){console.error("Failed to publish:",i),this.showNotification("Failed to publish content","error")}}closeEditModal(){document.getElementById("editModal").classList.add("hidden")}closeSocialModal(){document.getElementById("socialModal").classList.add("hidden")}async deleteContent(e){if(confirm("Are you sure you want to delete this content? This action cannot be undone."))try{if((await fetch(`/api/content/${e}`,{method:"DELETE"})).ok)this.showNotification("Content deleted successfully","success"),this.loadContent();else throw new Error("Failed to delete content")}catch(t){console.error("Failed to delete content:",t),this.showNotification("Failed to delete content","error")}}handleUpload(){let e=document.createElement("input");e.type="file",e.multiple=!0,e.accept="image/*,video/*",e.onchange=t=>{let s=Array.from(t.target.files);this.uploadFiles(s)},e.click()}async uploadFiles(e){let t=new FormData;e.forEach(s=>{t.append("files",s)});try{if((await fetch("/api/content/upload",{method:"POST",body:t})).ok)this.showNotification(`Uploaded ${e.length} file(s) successfully`,"success"),this.loadContent();else throw new Error("Failed to upload files")}catch(s){console.error("Failed to upload files:",s),this.showNotification("Failed to upload files","error")}}handleBulkActions(){if(this.selectedContent.size===0){this.showNotification("Please select content items first","warning");return}this.showBulkActionsMenu()}showBulkActionsMenu(){let e=["Approve Selected","Publish to Instagram","Publish to OnlyFans","Delete Selected"],t=prompt(`Select action for ${this.selectedContent.size} items:
${e.map((s,i)=>`${i+1}. ${s}`).join(`
`)}`);if(t){let s=parseInt(t)-1;s>=0&&s<e.length&&this.executeBulkAction(e[s])}}async executeBulkAction(e){let t=Array.from(this.selectedContent);try{if((await fetch("/api/content/bulk-action",{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify({action:e,contentIds:t})})).ok)this.showNotification(`Bulk action "${e}" completed successfully`,"success"),this.selectedContent.clear(),this.loadContent(),this.updateBulkActionsState();else throw new Error("Failed to execute bulk action")}catch(s){console.error("Failed to execute bulk action:",s),this.showNotification("Failed to execute bulk action","error")}}updateBulkActionsState(){let e=document.getElementById("bulkActionsBtn");this.selectedContent.size>0?(e.textContent=`Bulk Actions (${this.selectedContent.size})`,e.classList.add("bg-dia-gold","hover:bg-dia-gold/80"),e.classList.remove("bg-dia-purple","hover:bg-dia-purple/80")):(e.innerHTML='<i class="fas fa-tasks mr-2"></i>Bulk Actions',e.classList.remove("bg-dia-gold","hover:bg-dia-gold/80"),e.classList.add("bg-dia-purple","hover:bg-dia-purple/80"))}updatePagination(){let t=this.getFilteredContent().length,s=Math.ceil(t/this.itemsPerPage),i=(this.currentPage-1)*this.itemsPerPage+1,o=Math.min(this.currentPage*this.itemsPerPage,t);document.getElementById("showingRange").textContent=`${i}-${o}`,document.getElementById("totalItems").textContent=t}updateContentItem(e){let t=this.contentData.findIndex(s=>s.id===e.id);t!==-1&&(this.contentData[t]={...this.contentData[t],...e},this.renderContentGrid())}updateUploadProgress(e){console.log("Upload progress:",e)}updatePublishStatus(e){this.showNotification(`${e.platform}: ${e.status}`,e.success?"success":"error")}showNotification(e,t="info"){let s=document.createElement("div");s.className="fixed top-4 right-4 z-50 px-6 py-3 rounded-lg font-semibold transition-all transform translate-x-full opacity-0";let i={success:"bg-green-500 text-white",error:"bg-red-500 text-white",warning:"bg-yellow-500 text-black",info:"bg-blue-500 text-white"};s.className+=` ${i[t]||i.info}`,s.textContent=e,document.body.appendChild(s),setTimeout(()=>{s.classList.remove("translate-x-full","opacity-0")},100),setTimeout(()=>{s.classList.add("translate-x-full","opacity-0"),setTimeout(()=>{document.body.removeChild(s)},300)},3e3)}};document.addEventListener("DOMContentLoaded",()=>{new l});})();
