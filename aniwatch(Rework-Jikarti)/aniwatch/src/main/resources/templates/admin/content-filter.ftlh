<#import "admin-layout.ftlh" as layout>

<@layout.adminLayout title="Content Filter" activeTab="content-filter" additionalStyles="
    .filter-card {
        background-color: var(--card-bg);
        border-radius: 12px;
        border: 1px solid var(--border-color);
        transition: all 0.2s ease;
        overflow: hidden;
    }

    .filter-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }

    .filter-header {
        background-color: rgba(42, 42, 64, 0.5);
        padding: 1.25rem 1.5rem;
        font-weight: 600;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid var(--border-color);
    }

    .filter-body {
        padding: 1.5rem;
    }

    .form-switch {
        padding-left: 3.5em;
    }

    .form-switch .form-check-input {
        width: 3em;
        height: 1.5em;
    }

    .form-switch .form-check-input:checked {
        background-color: var(--primary);
        border-color: var(--primary);
    }

    .filter-option {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem;
        border-radius: 8px;
        margin-bottom: 0.75rem;
        background-color: rgba(255, 255, 255, 0.03);
        transition: all 0.2s;
    }

    .filter-option:hover {
        background-color: rgba(255, 255, 255, 0.05);
    }

    .filter-option-left {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .severity-indicator {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        display: inline-block;
        margin-right: 8px;
    }

    .severity-low {
        background-color: var(--warning);
    }

    .severity-medium {
        background-color: var(--secondary);
    }

    .severity-high {
        background-color: var(--danger);
    }
">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">Content Filtering Settings</h4>

        <button class="btn btn-primary" id="saveFiltersBtn">
            <i class="fas fa-save me-2"></i> Save Settings
        </button>
    </div>

    <div class="alert alert-info mb-4">
        <div class="d-flex">
            <div class="me-3">
                <i class="fas fa-info-circle fa-2x"></i>
            </div>
            <div>
                <h5 class="alert-heading">About Content Filters</h5>
                <p class="mb-0">Content filters help maintain community standards by flagging potentially inappropriate content for review. Admins please, enable or disable filters as needed.</p>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-lg-6">
            <div class="filter-card">
                <div class="filter-header">
                    <div>
                        <i class="fas fa-comment-slash me-2"></i>
                        Comment Filtering
                    </div>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="commentFilterEnabled" checked>
                    </div>
                </div>
                <div class="filter-body">
                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-low"></span>
                                Profanity Filter
                            </div>
                            <span class="badge bg-light text-dark">Low</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="profanityFilter" checked>
                        </div>
                    </div>

                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-medium"></span>
                                Harassment Detection
                            </div>
                            <span class="badge bg-secondary">Medium</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="harassmentFilter" checked>
                        </div>
                    </div>

                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-high"></span>
                                Hate Speech Detection
                            </div>
                            <span class="badge bg-danger">High</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="hateSpeechFilter" checked>
                        </div>
                    </div>

                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-high"></span>
                                Explicit Content Detection
                            </div>
                            <span class="badge bg-danger">High</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="explicitFilter" checked>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="filter-card">
                <div class="filter-header">
                    <div>
                        <i class="fas fa-image me-2"></i>
                        Image Filtering
                    </div>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="imageFilterEnabled" checked>
                    </div>
                </div>
                <div class="filter-body">
                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-medium"></span>
                                NSFW Image Detection
                            </div>
                            <span class="badge bg-secondary">Medium</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="nsfwImageFilter" checked>
                        </div>
                    </div>

                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-high"></span>
                                Explicit Content Detection
                            </div>
                            <span class="badge bg-danger">High</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="explicitImageFilter" checked>
                        </div>
                    </div>

                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-medium"></span>
                                Violence Detection
                            </div>
                            <span class="badge bg-secondary">Medium</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="violenceImageFilter" checked>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="filter-card">
                <div class="filter-header">
                    <div>
                        <i class="fas fa-list me-2"></i>
                        Watchlist Filtering
                    </div>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="watchlistFilterEnabled" checked>
                    </div>
                </div>
                <div class="filter-body">
                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-low"></span>
                                Title Filter
                            </div>
                            <span class="badge bg-light text-dark">Low</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="titleFilter" checked>
                        </div>
                    </div>

                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-medium"></span>
                                Description Filter
                            </div>
                            <span class="badge bg-secondary">Medium</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="descriptionFilter" checked>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="filter-card">
                <div class="filter-header">
                    <div>
                        <i class="fas fa-user-shield me-2"></i>
                        User Profile Filtering
                    </div>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="userProfileFilterEnabled" checked>
                    </div>
                </div>
                <div class="filter-body">
                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-low"></span>
                                Username Filter
                            </div>
                            <span class="badge bg-light text-dark">Low</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="usernameFilter" checked>
                        </div>
                    </div>

                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-medium"></span>
                                Bio Filter
                            </div>
                            <span class="badge bg-secondary">Medium</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="bioFilter" checked>
                        </div>
                    </div>

                    <div class="filter-option">
                        <div class="filter-option-left">
                            <div>
                                <span class="severity-indicator severity-medium"></span>
                                Profile Image Check
                            </div>
                            <span class="badge bg-secondary">Medium</span>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="profileImageFilter" checked>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <#assign additionalScripts>
        // Everything here simulates the idea, but not the actual functionality
        document.getElementById('saveFiltersBtn').addEventListener('click', function() {
            this.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> Saving...';
            this.disabled = true;

            setTimeout(() => {
                this.innerHTML = '<i class="fas fa-check me-2"></i> Saved!';

                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-success alert-dismissible fade show mt-3';
                alertDiv.innerHTML = `
                    <div class="d-flex align-items-center">
                        <i class="fas fa-check-circle me-2"></i>
                        <div>
                            <strong>Success!</strong> Content filter settings have been saved successfully.
                        </div>
                        <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                `;

                const contentWrapper = document.querySelector('.content-wrapper');
                contentWrapper.insertBefore(alertDiv, contentWrapper.firstChild);

                setTimeout(() => {
                    this.innerHTML = '<i class="fas fa-save me-2"></i> Save Settings';
                    this.disabled = false;

                    setTimeout(() => {
                        bootstrap.Alert.getOrCreateInstance(alertDiv).close();
                    }, 3000);
                }, 1000);
            }, 1500);
        });
    </#assign>
</@layout.adminLayout>