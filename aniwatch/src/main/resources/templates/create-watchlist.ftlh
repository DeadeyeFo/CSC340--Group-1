<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AniWatch - Create Watchlist</title>

    <!-- Stylesheets -->
    <link rel="stylesheet" href="/css/create-service.css">
    <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Inline Custom Styles -->
    <style>
        .thumbnail-preview {
            max-width: 300px;
            max-height: 200px;
            margin-top: 10px;
            border-radius: 5px;
            display: none;
        }

        .custom-file-upload {
            border: 1px solid #ccc;
            display: inline-block;
            padding: 6px 12px;
            cursor: pointer;
            background-color: #6c757d;
            color: white;
            border-radius: 4px;
        }

        input[type="file"] {
            display: none;
        }
    </style>
</head>

<body class="bg-dark text-light">
    <!-- Top Navigation Bar -->
    <div class="topnav">
        <a href="/home" class="logo-link">
            <h1 class="logo">AniWatch</h1>
        </a>
        <div class="nav-links">
            <a href="/profile">Profile</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container my-5">
            <h2 class="mb-4">Create a New Watchlist</h2>
            <form method="POST" action="/watchlists/create" enctype="multipart/form-data">
                <!-- Title -->
                <div class="mb-3">
                    <label for="title" class="form-label">Watchlist Title</label>
                    <input type="text" class="form-control bg-secondary text-light" id="title" name="title" required>
                </div>

                <!-- Description -->
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control bg-secondary text-light" id="description" name="description" rows="3"></textarea>
                </div>

                <!-- Thumbnail Upload -->
                <div class="mb-3">
                    <label for="thumbnailFile" class="form-label">Watchlist Thumbnail</label>
                    <div>
                        <label class="custom-file-upload">
                            <input type="file" id="thumbnailFile" name="thumbnailFile" accept="image/*" onchange="previewImage(this);">
                            Choose Image
                        </label>
                        <span id="fileNameDisplay" class="ms-2">No file chosen</span>
                    </div>
                    <img id="thumbnailPreview" src="#" alt="Thumbnail Preview" class="thumbnail-preview">
                </div>

                <!-- Buttons -->
                <button type="submit" class="btn btn-primary">Create Watchlist</button>
                <a href="/watchlists/watchlist-list" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer-section">
        <div class="social-links">
            <a href="https://discord.com/" target="_blank"><img src="/pics/discord-logo.png" alt="Discord"></a>
            <a href="https://www.instagram.com/" target="_blank"><img src="/pics/instagram-logo.png" alt="Instagram"></a>
            <a href="https://www.reddit.com/" target="_blank"><img src="/pics/reddit-logo.jpeg" alt="Reddit"></a>
            <a href="https://twitter.com/" target="_blank"><img src="/pics/x-logo.jpeg" alt="Twitter"></a>
        </div>
        <p>© 2025 AniWatch</p>
    </footer>

    <!-- JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(input) {
            const preview = document.getElementById('thumbnailPreview');
            const fileNameDisplay = document.getElementById('fileNameDisplay');

            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
                fileNameDisplay.textContent = input.files[0].name;
            } else {
                preview.style.display = 'none';
                fileNameDisplay.textContent = 'No file chosen';
            }
        }
    </script>
</body>
</html>
