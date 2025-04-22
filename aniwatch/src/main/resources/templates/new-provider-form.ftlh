<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Provider - AniWatch</title>
    <link rel="stylesheet" href="/css/manage-profile.css">
    <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light">
    <!-- Top Navigation Bar -->
    <div class="topnav">
        <a href="/" class="logo-link">
            <h1 class="logo">AniWatch</h1>
        </a>
        <div class="nav-links">
            <a href="/login">Login</a>
            <a href="/about">About</a>
        </div>
    </div>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow bg-secondary text-light">
                    <div class="card-header bg-primary text-white">
                        <h2 class="mb-0">Create New Provider Profile</h2>
                    </div>
                    <div class="card-body">
                        <form action="/provider-profile/create" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="providerUsername" class="form-label">Username</label>
                                <input type="text" class="form-control" id="providerUsername" name="providerUsername" required>
                                <div class="form-text text-light-50">Choose a unique username for your provider account.</div>
                            </div>

                            <div class="mb-3">
                                <label for="providerEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="providerEmail" name="providerEmail" required>
                            </div>

                            <div class="mb-3">
                                <label for="providerPassword" class="form-label">Password</label>
                                <input type="password" class="form-control" id="providerPassword" name="providerPassword" required>
                                <div class="form-text text-light-50">Password must be at least 8 characters long.</div>
                            </div>

                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            </div>

                            <div class="mb-3">
                                <label for="providerBio" class="form-label">Bio</label>
                                <textarea class="form-control" id="providerBio" name="providerBio" rows="4" placeholder="Tell us about yourself and what kind of anime content you'll be providing..."></textarea>
                            </div>

                            <div class="mb-4">
                                <label for="profileImage" class="form-label">Profile Image</label>
                                <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">
                                <div class="form-text text-light-50">Upload a profile image (optional). Maximum size: 5MB.</div>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">Create Provider Account</button>
                                <a href="/" class="btn btn-outline-light">Cancel</a>
                            </div>
                        </form>
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Form Validation Script -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            const password = document.getElementById('providerPassword');
            const confirmPassword = document.getElementById('confirmPassword');

            form.addEventListener('submit', function(event) {
                // Check if passwords match
                if (password.value !== confirmPassword.value) {
                    event.preventDefault();
                    alert('Passwords do not match!');
                    return false;
                }

                // Check password length
                if (password.value.length < 8) {
                    event.preventDefault();
                    alert('Password must be at least 8 characters long!');
                    return false;
                }

                return true;
            });
        });
    </script>
</body>
</html>