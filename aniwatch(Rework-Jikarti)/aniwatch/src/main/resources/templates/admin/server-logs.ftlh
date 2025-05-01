<#import "admin-layout.ftlh" as layout>

<@layout.adminLayout title="Server Logs" activeTab="server-logs" additionalStyles="
    .log-container {
        background-color: var(--darker);
        border-radius: 10px;
        height: 600px;
        overflow-y: auto;
        font-family: 'Consolas', 'Monaco', monospace;
        font-size: 0.9rem;
        border: 1px solid var(--border-color);
    }

    .log-entry {
        padding: 0.75rem 1rem;
        border-bottom: 1px solid var(--border-color);
        transition: background-color 0.2s;
    }

    .log-entry:hover {
        background-color: rgba(255, 255, 255, 0.03);
    }

    .log-time {
        color: var(--muted-text);
        margin-right: 10px;
        white-space: nowrap;
    }

    .log-level {
        display: inline-block;
        padding: 0.15rem 0.5rem;
        border-radius: 4px;
        margin-right: 10px;
        font-weight: 500;
        font-size: 0.7rem;
        width: 70px;
        text-align: center;
    }

    .log-info {
        background-color: rgba(58, 134, 255, 0.2);
        color: var(--primary);
    }

    .log-warning {
        background-color: rgba(255, 190, 11, 0.2);
        color: var(--warning);
    }

    .log-error {
        background-color: rgba(239, 71, 111, 0.2);
        color: var(--danger);
    }

    .log-debug {
        background-color: rgba(6, 214, 160, 0.2);
        color: var(--success);
    }

    .log-message {
        white-space: pre-wrap;
        word-break: break-word;
    }

    .log-filter-btn {
        border-radius: 50px;
        padding: 0.4rem 1rem;
        font-size: 0.85rem;
        font-weight: 500;
        border: none;
    }

    .log-filter-btn.active {
        box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.2);
    }
">
    <div class="row mb-4">
        <div class="col-lg-8">
            <div class="d-flex flex-wrap gap-2">
                <button class="log-filter-btn bg-secondary bg-opacity-25 text-light active" data-level="all">
                    All Logs
                </button>
                <button class="log-filter-btn bg-primary bg-opacity-25 text-primary" data-level="info">
                    <i class="fas fa-info-circle me-1"></i> Info
                </button>
                <button class="log-filter-btn bg-warning bg-opacity-25 text-warning" data-level="warning">
                    <i class="fas fa-exclamation-triangle me-1"></i> Warning
                </button>
                <button class="log-filter-btn bg-danger bg-opacity-25 text-danger" data-level="error">
                    <i class="fas fa-times-circle me-1"></i> Error
                </button>
                <button class="log-filter-btn bg-success bg-opacity-25 text-success" data-level="debug">
                    <i class="fas fa-bug me-1"></i> Debug
                </button>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search logs..." id="logSearch">
                <button class="btn btn-primary" type="button" id="searchBtn">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-header d-flex justify-content-between align-items-center text-light">
            <h5 class="m-0">System Logs</h5>
            <span class="badge bg-secondary rounded-pill">${.now?string("yyyy-MM-dd HH:mm:ss")}</span>
        </div>
        <div class="log-container">
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:15:32</span>
                <span class="log-level log-info text-light">INFO</span>
                <span class="log-message text-light">Application started successfully</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:15:35</span>
                <span class="log-level log-debug text-light">DEBUG</span>
                <span class="log-message text-light">Loaded 24 anime entries from database</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:16:42</span>
                <span class="log-level log-info text-light">INFO</span>
                <span class="log-message text-light">User Primordial logged in successfully</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:17:55</span>
                <span class="log-level log-warning text-light">WARNING</span>
                <span class="log-message text-light">Rate limit exceeded for Jikan API calls to external service</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:18:33</span>
                <span class="log-level log-error text-light">ERROR</span>
                <span class="log-message text-light">Failed to fetch seasonal anime: Connection timeout</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:20:15</span>
                <span class="log-level log-info text-light">INFO</span>
                <span class="log-message text-light">New user registered: anime_fan69</span>
            </div>
            <div class="log-entry text-light">
                <span class="log-time text-light">2025-04-28 08:21:37</span>
                <span class="log-level log-debug text-light">DEBUG</span>
                <span class="log-message text-light">Cache hit ratio: 78.5%</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:23:01</span>
                <span class="log-level log-info text-light">INFO</span>
                <span class="log-message text-light">Provider AnimeExpert created new watchlist "Must Watch Spring 2025"</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:24:55</span>
                <span class="log-level log-warning text-light">WARNING</span>
                <span class="log-message text-light">Content filter flagged comment ID 13 for review</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:26:12</span>
                <span class="log-level log-error text-light">ERROR</span>
                <span class="log-message text-light">Database connection timeout during peak traffic</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:28:30</span>
                <span class="log-level log-info text-light">INFO</span>
                <span class="log-message text-light">Database connection restored, operations resuming</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:30:15</span>
                <span class="log-level log-debug text-light">DEBUG</span>
                <span class="log-message text-light">Memory usage: 2.4GB / 8GB allocated</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:32:40</span>
                <span class="log-level log-info text-light">INFO</span>
                <span class="log-message text-light">User anime_guru logged in from new IP address: 192.168.1.105</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:35:22</span>
                <span class="log-level log-debug text-light">DEBUG</span>
                <span class="log-message text-light">API request completed in 450ms</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:37:15</span>
                <span class="log-level log-warning text-light">WARNING</span>
                <span class="log-message text-light">Failed login attempt for username: admin (IP: 203.0.113.42)</span>
            </div>
            <div class="log-entry">
                <span class="log-time text-light">2025-04-28 08:40:08</span>
                <span class="log-level log-info text-light">INFO</span>
                <span class="log-message text-light">Admin user logged in successfully</span>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <button class="btn btn-primary w-100" id="refreshLogsBtn">
                <i class="fas fa-sync-alt me-2"></i> Refresh Logs
            </button>
        </div>
        <div class="col-md-6">
            <button class="btn btn-outline-primary w-100" id="downloadLogsBtn">
                <i class="fas fa-download me-2"></i> Download Logs
            </button>
        </div>
    </div>

    <#assign additionalScripts>
        //add scripts here
    </#assign>
</@layout.adminLayout>