<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AniWatch - Provider Registration</title>
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
            <a href="/login">Login</a>
        </div>
    </div>

    <div class="content">
        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card bg-secondary">
                        <div class="card-header">
                            <h2 class="text-center">Register as Provider</h2>
                        </div>
                        <div class="card-body">
                            <form action="/register/provider" method="post" enctype="multipart/form-data">
                                <div class="mb-3">
                                    <label for="providerUsername" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="providerUsername" name="providerUsername" required>
                                </div>
                                <div class="mb-3">
                                    <label for="providerEmail" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="providerEmail" name="providerEmail" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                                <div class="mb-3">
                                    <label for="providerBio" class="form-label">Bio</label>
                                    <textarea class="form-control" id="providerBio" name="providerBio" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="profileImage" class="form-label">Profile Image</label>
                                    <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">
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