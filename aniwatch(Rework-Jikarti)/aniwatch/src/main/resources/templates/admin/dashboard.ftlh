<#import "admin-layout.ftlh" as layout>

<@layout.adminLayout title="Dashboard" activeTab="dashboard">
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon bg-users">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value">${stats.totalUsers}</div>
                <div class="stat-label">Total Users</div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon bg-providers">
                    <i class="fas fa-user-tie"></i>
                </div>
                <div class="stat-value">${stats.totalProviders}</div>
                <div class="stat-label">Content Providers</div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon bg-watchlists">
                    <i class="fas fa-list"></i>
                </div>
                <div class="stat-value">${stats.totalWatchlists}</div>
                <div class="stat-label">Watchlists</div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon bg-comments">
                    <i class="fas fa-comments"></i>
                </div>
                <div class="stat-value">${stats.totalComments}</div>
                <div class="stat-label">Comments</div>
            </div>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center text-light">
                    <span>Recent Activity (Last 24 Hours)</span>
                    <span class="badge bg-primary">Today</span>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent border-bottom border-secondary text-light">
                            <span><i class="fas fa-user-plus me-2 text-primary"></i> New Users</span>
                            <span class="badge bg-primary rounded-pill">${stats.newUsersLast24Hours}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent border-bottom border-secondary text-light">
                            <span><i class="fas fa-list-alt me-2 text-success"></i> New Watchlists</span>
                            <span class="badge bg-success rounded-pill">${stats.newWatchlistsLast24Hours}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent text-light">
                            <span><i class="fas fa-comment-dots me-2 text-warning"></i> New Comments</span>
                            <span class="badge bg-warning text-dark rounded-pill">${stats.commentsLast24Hours}</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center text-light">
                    <span>Weekly Overview</span>
                    <span class="badge bg-secondary">Last 7 Days</span>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent border-bottom border-secondary text-light">
                            <span><i class="fas fa-user-plus me-2 text-primary"></i> New Users</span>
                            <span class="badge bg-primary rounded-pill">${stats.newUsersLastWeek}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent border-bottom border-secondary text-light">
                            <span><i class="fas fa-list-alt me-2 text-success"></i> New Watchlists</span>
                            <span class="badge bg-success rounded-pill">${stats.newWatchlistsLastWeek}</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent text-light">
                            <span><i class="fas fa-comment-dots me-2 text-warning"></i> New Comments</span>
                            <span class="badge bg-warning text-dark rounded-pill">${stats.commentsLastWeek}</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <h4 class="mb-3">Quick Access</h4>
    <div class="row g-4">
        <div class="col-lg-3 col-md-6">
            <a href="/admin/users" class="text-decoration-none">
                <div class="grid-card">
                    <img src="/pics/manage-users-icon.png" alt="Users" class="img-fluid">
                    <div class="grid-card-overlay">
                        <div class="grid-card-title">User Management</div>
                        <div class="grid-card-subtitle">Manage user accounts</div>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-3 col-md-6">
            <a href="/admin/providers" class="text-decoration-none">
                <div class="grid-card">
                    <img src="/pics/content-management.png" alt="Providers" class="img-fluid">
                    <div class="grid-card-overlay">
                        <div class="grid-card-title">Provider Management</div>
                        <div class="grid-card-subtitle">Manage content creators</div>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-3 col-md-6">
            <a href="/admin/watchlists" class="text-decoration-none">
                <div class="grid-card">
                    <img src="/pics/watchlist-icon.png" alt="Watchlists" class="img-fluid">
                    <div class="grid-card-overlay">
                        <div class="grid-card-title">Watchlist Management</div>
                        <div class="grid-card-subtitle">Review content watchlists</div>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-lg-3 col-md-6">
            <a href="/admin/content-filter" class="text-decoration-none">
                <div class="grid-card">
                    <img src="/pics/content-filter.png" alt="Content Filter" class="img-fluid">
                    <div class="grid-card-overlay">
                        <div class="grid-card-title">Content Filters</div>
                        <div class="grid-card-subtitle">Manage content policies</div>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <div class="text-light text-center mt-4">
        <p>Last updated:
        <#if stats.lastUpdated??>
            <#if stats.lastUpdated?is_date>
                ${stats.lastUpdated?string("yyyy-MM-dd HH:mm:ss")}
            <#else>
                ${stats.lastUpdated}
            </#if>
        <#else>
            ${.now?string("yyyy-MM-dd HH:mm:ss")}
        </#if>
        </p>
    </div>
</@layout.adminLayout>