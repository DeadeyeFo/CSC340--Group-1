<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AniWatch - Browse Anime</title>

  <!-- Stylesheets -->
  <link rel="stylesheet" href="/css/browse-anime-new1.css" />
  <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

  <!-- Inline Styles -->
  <style>
    .dropdown {
      position: relative;
      display: inline-block;
    }

    .dropdown-menu {
      display: none;
      position: absolute;
      background-color: #343a40;
      min-width: 160px;
      box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
      z-index: 1;
      border-radius: 8px;
      margin-top: 10px;
      margin-right: -74px;
    }

    .dropdown:hover .dropdown-menu {
      display: block;
    }

    .dropdown-menu a {
      color: white;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
    }

    .dropdown-menu a:hover {
      background-color: #495057;
    }

    .fa-user {
      margin-top: 14.5px;
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
      <#if isAuthenticated?? && isAuthenticated>
        <div class="dropdown">
          <a href="#" class="dropbtn">
            <i class="fas fa-user"></i> ${username!}
          </a>
          <div class="dropdown-menu">
            <#if isProvider?? && isProvider>
              <a href="/provider-profile/${providerId!}">My Profile</a>
              <a href="/watchlists/new">Create Watchlist</a>
            <#else>
              <a href="/user-profile">My Profile</a>
            </#if>
            <a href="/logout">Logout</a>
          </div>
        </div>
      <#else>
        <a href="/login">Login</a>
      </#if>
      <a href="/watchlists/watchlist-list">Watchlist library</a>
    </div>
  </div>

  <!-- Main Content -->
  <div class="content">
    <div class="container my-5">
      <h2 class="text-center mb-4">Browse Anime</h2>
      <p class="text-center mb-4">Discover anime to add to a watchlist</p>

      <!-- Search Bar -->
      <div class="search-bar">
        <input type="text" id="searchInput" class="form-control" placeholder="Search anime..." />
      </div>

      <h2 class="suggestion-text">Your Anime Suggestions</h2>

      <div class="swiper mySwiper">
        <div class="swiper-wrapper">
          <#if animeList?has_content>
            <#list animeList as anime>
              <div class="swiper-slide col-md-4 mb-4">
                <div class="card bg-secondary text-light">
                  <img src="${anime.imageUrl}" class="card-img-top" alt="${anime.title}" />
                  <div class="card-body">
                    <h5 class="card-title">${anime.title}</h5>
                    <p class="card-text">Alternate Title: ${anime.alternateTitle}</p>
                  </div>
                </div>
              </div>
            </#list>
          <#else>
            <div class="col-12 text-center">
              <p>No anime available at the moment.</p>
            </div>
          </#if>
        </div>
      </div>

      <div class="swiper-button-next btn"></div>
      <div class="swiper-button-prev btn"></div>
    </div>

    <!-- Genres Section -->
    <div class="genres-section">
      <h2 class="genre-text">Genres</h2>
      <div class="genres-grid">
        <a href="#"><span>></span>Action</a>
        <a href="#"><span>></span>Adventure</a>
        <a href="#"><span>></span>Avant Garde</a>
        <a href="#"><span>></span>Award Winning</a>
        <a href="#"><span>></span>Boys Love</a>
        <a href="#"><span>></span>Comedy</a>
        <a href="#"><span>></span>Drama</a>
        <a href="#"><span>></span>Fantasy</a>
        <a href="#"><span>></span>Girls Love</a>
        <a href="#"><span>></span>Gourmet</a>
        <a href="#"><span>></span>Horror</a>
        <a href="#"><span>></span>Mystery</a>
        <a href="#"><span>></span>Romance</a>
        <a href="#"><span>></span>Sci-Fi</a>
        <a href="#"><span>></span>Slice of Life</a>
        <a href="#"><span>></span>Sports</a>
        <a href="#"><span>></span>Supernatural</a>
        <a href="#"><span>></span>Suspense</a>
        <a href="#"><span>></span>Isekai</a>
        <a href="#"><span>></span>Place-holder</a>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer-section">
    <div class="social-links">
      <a href="https://discord.com/" target="_blank">
        <img src="/pics/discord-logo.png" alt="Discord" />
      </a>
      <a href="https://www.instagram.com/" target="_blank">
        <img src="/pics/instagram-logo.png" alt="Instagram" />
      </a>
      <a href="https://www.reddit.com/" target="_blank">
        <img src="/pics/reddit-logo.jpeg" alt="Reddit" />
      </a>
      <a href="https://twitter.com/" target="_blank">
        <img src="/pics/x-logo.jpeg" alt="Twitter" />
      </a>
    </div>
    <p>&copy; 2025 AniWatch</p>
  </footer>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="/js/main.js"></script>
</body>
</html>
