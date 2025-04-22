<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch - Error</title>
  <link rel="stylesheet" href="/css/style2.css">
  <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .error-container {
      text-align: center;
      margin-top: 100px;
      padding: 30px;
      background-color: #343a40;
      border-radius: 10px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
    }

    .error-icon {
      font-size: 80px;
      margin-bottom: 20px;
      color: #dc3545;
    }

    .error-title {
      font-size: 28px;
      margin-bottom: 15px;
    }

    .error-message {
      font-size: 18px;
      margin-bottom: 30px;
      color: #adb5bd;
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
      <a href="/watchlists/watchlist-list">Watchlists library</a>
      <a href="/browse-anime">Browse Anime</a>
      <a href="/login">Login</a>
    </div>
  </div>

  <div class="content">
    <div class="container">
      <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h1 class="error-title">Oops! Something went wrong</h1>
        <p class="error-message">${error!'An unexpected error occurred. Please try again later.'}</p>
        <a href="/home" class="btn btn-primary">Go to Homepage</a>
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