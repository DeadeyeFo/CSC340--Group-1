<!--Admin page with style layout-->
<#macro adminLayout title activeTab additionalStyles="" additionalScripts="">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - AniWatch Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #3a86ff;
            --primary-dark: #2667cc;
            --secondary: #8338ec;
            --success: #06d6a0;
            --warning: #ffbe0b;
            --danger: #ef476f;
            --dark: #1e1e2c;
            --darker: #141420;
            --light-text: #f8f9fa;
            --muted-text: #adb5bd;
            --border-color: #2d2d3a;
            --card-bg: #252536;
            --sidebar-width: 280px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--dark);
            color: var(--light-text);
            height: 100vh;
            display: flex;
            overflow-x: hidden;
        }

        .logo {
            font-weight: 700;
            font-size: 28px;
            color: var(--light-text);
            margin: 0;
            letter-spacing: 1px;
        }

        .logo span {
            color: var(--primary);
        }

        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background-color: var(--darker);
            position: fixed;
            left: 0;
            top: 0;
            padding: 1.5rem;
            z-index: 100;
            transition: all 0.3s ease;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .sidebar-header .admin-badge {
            background-color: var(--secondary);
            color: white;
            font-size: 12px;
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 20px;
            margin-left: 10px;
            white-space: nowrap;
        }

        /* Navigation sections */
        .nav-sections {
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow-y: auto;
        }

        .nav-section {
            margin-bottom: 1.5rem;
            flex-shrink: 0;
        }

        .nav-section-title {
            color: var(--muted-text);
            font-size: 0.8rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
            padding-left: 0.5rem;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            text-decoration: none;
            color: var(--light-text);
            font-weight: 400;
            transition: all 0.2s ease;
            margin-bottom: 0.25rem;
            position: relative;
        }

        .nav-item i {
            font-size: 1.2rem;
            margin-right: 0.75rem;
            transition: all 0.2s ease;
            width: 20px;
            text-align: center;
        }

        .nav-item span {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .nav-item.active {
            background-color: var(--primary);
            color: white;
            font-weight: 500;
            box-shadow: 0 4px 10px rgba(58, 134, 255, 0.3);
        }

        .nav-item:hover:not(.active) {
            background-color: rgba(255, 255, 255, 0.05);
            color: var(--primary);
        }

        .nav-item.active i {
            color: white;
        }

        .nav-item:hover:not(.active) i {
            color: var(--primary);
        }

        .main-content {
            margin-left: var(--sidebar-width);
            width: calc(100% - var(--sidebar-width));
            padding: 0;
            transition: all 0.3s ease;
        }

        .topbar {
            background-color: var(--darker);
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border-color);
        }

        .topbar-title {
            font-size: 1.5rem;
            font-weight: 600;
        }

        .topbar-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .content-wrapper {
            padding: 2rem;
        }

        .alert-wrapper {
            margin-bottom: 2rem;
        }

        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            transform: translateY(-5px);
        }

        .card-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .card-body {
            padding: 1.5rem;
        }

        .stat-card {
            border-radius: 0.75rem;
            padding: 1.5rem;
            height: 100%;
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
        }

        .stat-card .icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .stat-card .icon i {
            font-size: 1.5rem;
            color: white;
        }

        .stat-card .stat-value {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .stat-card .stat-label {
            color: var(--muted-text);
            font-size: 0.9rem;
        }

        .bg-users {
            background-color: rgba(58, 134, 255, 0.2);
        }

        .bg-users i {
            color: var(--primary) !important;
        }

        .bg-providers {
            background-color: rgba(131, 56, 236, 0.2);
        }

        .bg-providers i {
            color: var(--secondary) !important;
        }

        .bg-watchlists {
            background-color: rgba(6, 214, 160, 0.2);
        }

        .bg-watchlists i {
            color: var(--success) !important;
        }

        .bg-comments {
            background-color: rgba(255, 190, 11, 0.2);
        }

        .bg-comments i {
            color: var(--warning) !important;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .btn-outline-primary {
            border-color: var(--primary);
            color: var(--primary);
        }

        .btn-outline-primary:hover {
            background-color: var(--primary);
            color: white;
        }

        .badge {
            padding: 0.4rem 0.8rem;
            font-weight: 500;
            border-radius: 2rem;
        }

        .table {
            color: var(--light-text);
        }

        .table thead th {
            border-color: var(--border-color);
            font-size: 0.9rem;
            color: black;
        }

        .table tbody td {
            padding: 1rem;
            border-color: var(--border-color);
            vertical-align: middle;
        }

        .table-dark {
            background-color: var(--darker);
        }

        .table-dark td, .table-dark th {
            background-color: var(--card-bg);
        }

        .form-control {
            background-color: white;
            border-color: var(--border-color);
            color: black;
            padding: 0.75rem 1rem;
            font-size: 0.9rem;
        }

        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(58, 134, 255, 0.25);
            background-color: white;
            color: black;
        }

        .form-select {
            background-color: var(--darker);
            border-color: var(--border-color);
            color: var(--light-text);
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .footer {
            padding: 1rem 2rem;
            text-align: center;
            color: var(--muted-text);
            font-size: 0.85rem;
            border-top: 1px solid var(--border-color);
            margin-top: 2rem;
        }

        .access-warning {
            background-color: rgba(239, 71, 111, 0.1);
            border-left: 4px solid var(--danger);
            color: var(--light-text);
            padding: 1rem 1.5rem;
            border-radius: 0.5rem;
            margin-bottom: 2rem;
        }

        .grid-card {
            border-radius: 0.75rem;
            overflow: hidden;
            aspect-ratio: 1;
            position: relative;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .grid-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .grid-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all 0.3s ease;
        }

        .grid-card:hover img {
            transform: scale(1.05);
        }

        .grid-card-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 1.5rem;
            background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
            text-align: center;
        }

        .grid-card-title {
            font-weight: 600;
            font-size: 1.2rem;
            margin-bottom: 0.25rem;
        }

        .grid-card-subtitle {
            color: var(--muted-text);
            font-size: 0.9rem;
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                padding: 1rem 0.5rem;
            }

            .sidebar-header .logo,
            .sidebar-header .admin-badge,
            .nav-section-title {
                display: none;
            }

            .nav-item span {
                display: none;
            }

            .nav-item {
                justify-content: center;
                padding: 0.75rem;
            }

            .nav-item i {
                margin-right: 0;
                font-size: 1.4rem;
            }

            .main-content {
                margin-left: 80px;
                width: calc(100% - 80px);
            }

            /* Show tooltips on hover in mobile view */
            .nav-item:hover::after {
                content: attr(data-title);
                position: absolute;
                left: 100%;
                top: 50%;
                transform: translateY(-50%);
                background-color: var(--dark);
                color: var(--light-text);
                padding: 0.5rem 0.75rem;
                border-radius: 0.25rem;
                font-size: 0.8rem;
                white-space: nowrap;
                z-index: 1000;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }
        }

        .system {
            margin-top: auto;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }
    </style>

    <#if additionalStyles?has_content>
        <style>
            ${additionalStyles} //for more style content
        </style>
    </#if>
</head>

<body>
    <aside class="sidebar">
        <div class="sidebar-header">
            <h1 class="logo"><span>Ani</span>Watch</h1>
            <span class="admin-badge">Admin</span>
        </div>

        <div class="nav-section">
            <div class="nav-section-title">Main</div>
            <a href="/admin" class="nav-item ${(activeTab == 'dashboard')?then('active', '')}">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>
            <a href="/admin/users" class="nav-item ${(activeTab == 'users')?then('active', '')}">
                <i class="fas fa-users"></i>
                <span>Users</span>
            </a>
            <a href="/admin/providers" class="nav-item ${(activeTab == 'providers')?then('active', '')}">
                <i class="fas fa-user-tie"></i>
                <span>Providers</span>
            </a>
            <a href="/admin/watchlists" class="nav-item ${(activeTab == 'watchlists')?then('active', '')}">
                <i class="fas fa-list"></i>
                <span>Watchlists</span>
            </a>
        </div>

        <div class="nav-section">
            <div class="nav-section-title">Content</div>
            <a href="/admin/comments" class="nav-item ${(activeTab == 'comments')?then('active', '')}">
                <i class="fas fa-comments"></i>
                <span>Comments</span>
            </a>
            <a href="/admin/reported-comments" class="nav-item ${(activeTab == 'reported-comments')?then('active', '')}">
                <i class="fas fa-flag"></i>
                <span>Reports</span>
            </a>
            <a href="/admin/content-filter" class="nav-item ${(activeTab == 'content-filter')?then('active', '')}">
                <i class="fas fa-filter"></i>
                <span>Content Filter</span>
            </a>
        </div>

        <div class="nav-section">
            <div class="nav-section-title">System</div>
            <a href="/admin/server-logs" class="nav-item ${(activeTab == 'server-logs')?then('active', '')}">
                <i class="fas fa-file-alt"></i>
                <span>Server Logs</span>
            </a>
            <a href="" class="nav-item ${(activeTab == 'settings')?then('active', '')}">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
            </a>
        </div>

        <div class="nav-section mt-auto">
            <div class="nav-section-title">Account</div>
            <a href="/home" class="nav-item">
                <i class="fas fa-home"></i>
                <span>Back to Site</span>
            </a>
            <a href="/logout" class="nav-item">
                <i class="fas fa-sign-out-alt"></i>
                <span>Logout</span>
            </a>
        </div>
    </aside>

    <main class="main-content">
        <div class="topbar">
            <h2 class="topbar-title">${title}</h2>
            <div class="topbar-actions">
                <span class="text-muted">Admin Panel</span>
            </div>
        </div>

        <div class="content-wrapper">
            <div class="access-warning">
                <strong>WARNING:</strong> Unauthorized access to this system is prohibited. All activities are monitored and logged.
            </div>

            <#if success??>
                <div class="alert-wrapper">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
            </#if>

            <#if error??>
                <div class="alert-wrapper">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
            </#if>

            <#nested>

            <div class="footer">
                <p>AniWatch Admin Dashboard &copy; 2025. All rights reserved.</p>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <#if additionalScripts?has_content>
        <script>
            ${additionalScripts}
        </script>
    </#if>
</body>
</html>
</#macro>