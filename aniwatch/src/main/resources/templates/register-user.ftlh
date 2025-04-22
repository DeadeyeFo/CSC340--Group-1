<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AniWatch - Register</title>
    <link rel="stylesheet" href="/css/style2.css">
    <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light">
    <div class="topnav">
        <a href="/home" class="logo-link">
            <h1 class="logo">AniWatch</h1>
        </a>
        <div class="nav-links">
            <a href="/watchlists/watchlist-list">Watchlists library</a>
            <a href="/browse-anime">Browse Anime</a>
        </div>
    </div>

    <div class="content">
        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card bg-secondary">
                        <div class="card-header">
                            <h2 class="text-center">Register as User</h2>
                        </div>
                        <div class="card-body">
                            <#if error??>
                                <div class="alert alert-danger">
                                    ${error}
                                </div>
                            </#if>
                            <form action="/register/user" method="post">
                                <#if _csrf??>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                </#if>

                                <div class="mb-3">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Register</button>
                                </div>
                            </form>
                            <div class="mt-3 text-center">
                                <p>Already have an account? <a href="/login">Login</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer-section">
        <div class="social-links">
            <a href="https://discord.com/" target="_blank">
                <img src="/pics/discord-logo.png" alt="Discord">
            </a>
            <a href="https://www.instagram.com/" target="_blank">
                <img src="/pics/instagram-logo.png" alt="Instagram">
            </a>
            <a href="https://www.reddit.com/" target="_blank">
                <img src="/pics/reddit-logo.jpeg" alt="Reddit">
            </a>
            <a href="https://twitter.com/" target="_blank">
                <img src="/pics/x-logo.jpeg" alt="Twitter">
            </a>
        </div>
        <p>&copy; 2025 AniWatch</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>