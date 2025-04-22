<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch</title>
  <link rel="stylesheet" href="/css/style2.css">
  <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

  <style>
    .watchlist-metadata {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
    }

    .views-counter {
      margin-bottom: -5px;
      font-size: 0.9rem;
      color: #aaa;
      display: flex;
      align-items: center;
    }

    .views-counter i {
      margin-right: 4px;
    }

    .rating-container {
      display: flex;
      align-items: center;
    }

    .dropdown {
      position: relative;
      display: inline-block;
    }

    .dropdown-menu {
      display: none;
      position: absolute;
      background-color: #343a40;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
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
  <div class="container">
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
        <a href="/watchlists/watchlist-list">Watchlists library</a>
        <a href="/browse-anime">Browse Anime</a>
      </div>
    </div>
  </div>

  <!-- Main Content -->
  <div class="content">
    <!-- Heading Section -->
    <div class="hero-section text-center py-5">
      <h1 class="display-4">Discover and track your favorite anime and manga!</h1>
    </div>
  </div>

  <!-- Anime Data Section -->
  <div class="container">
    <h2 class="text-center my-5">Popular ${currentSeason} Anime</h2>
    <div class="swiper mySwiper">
      <div class="swiper-wrapper">

        <div class="swiper-slide col-md-4 mb-4">
          <div class="card bg-secondary text-light">
            <img src="/pics/Solo-Leveling.jpg" class="card-img-top" alt="Anime Image">
            <div class="card-body">
              <h5 class="card-title">Solo Leveling</h5>
              <p class="card-text">Alternate Title: Ore dake Level Up na Ken</p>
            </div>
          </div>
        </div>

        <div class="swiper-slide col-md-4 mb-4">
          <div class="card bg-secondary text-light">
            <img src="/pics/The-Apothecary-Diaries.jpg" class="card-img-top" alt="Anime Image">
            <div class="card-body">
              <h5 class="card-title">The Apothecary Diaries</h5>
              <p class="card-text">Alternate Title: Kusuriya no Hitorigoto</p>
            </div>
          </div>
        </div>

        <div class="swiper-slide col-md-4 mb-4">
          <div class="card bg-secondary text-light">
            <img src="/pics/One-Piece.jpg" class="card-img-top" alt="Anime Image">
            <div class="card-body">
              <h5 class="card-title">One Piece</h5>
              <p class="card-text">Alternate Title: One Piece</p>
            </div>
          </div>
        </div>

        <div class="swiper-slide col-md-4 mb-4">
          <div class="card bg-secondary text-light">
            <img src="/pics/ReZero.jpg" class="card-img-top" alt="Anime Image">
            <div class="card-body">
              <h5 class="card-title">Re:ZERO - Starting Life in Another World</h5>
              <p class="card-text">Alternate Title: Re:Zero kara Hajimeru Isekai Seikatsu</p>
            </div>
          </div>
        </div>

        <div class="swiper-slide col-md-4 mb-4">
          <div class="card bg-secondary text-light">
            <img src="/pics/Orb.jpg" class="card-img-top" alt="Anime Image">
            <div class="card-body">
              <h5 class="card-title">Orb: On the Movements of the Earth</h5>
              <p class="card-text">Alternate Title: Chi. Chikyuu no Undou ni Tsuite</p>
            </div>
          </div>
        </div>

        <div class="swiper-slide col-md-4 mb-4">
          <div class="card bg-secondary text-light">
            <img src="/pics/Shangri-La-Frontier.jpg" class="card-img-top" alt="Anime Image">
            <div class="card-body">
              <h5 class="card-title">Shangri-La Frontier</h5>
              <p class="card-text">Alternate Title: Shangri-La Frontier: Kusoge Hunter, Kamige ni Idoman to su</p>
            </div>
          </div>
        </div>

        <div class="swiper-slide col-md-4 mb-4">
          <div class="card bg-secondary text-light">
            <img src="/pics/Dr.Stone.jpg" class="card-img-top" alt="Anime Image">
            <div class="card-body">
              <h5 class="card-title">Dr. Stone</h5>
              <p class="card-text">Alternate Title: Dr. Stone: Science Future</p>
            </div>
          </div>
        </div>

      </div>
    </div>
    <div class="swiper-button-next btn"></div>
    <div class="swiper-button-prev btn"></div>
  </div>

  <!-- Mini Welcome Header -->
  <div class="hero-section text-center py-5">
    <h2>Welcome to AniWatch</h2>
    <p>Find the Anime Watchlist that fits what you want!</p>
  </div>

  <!-- Featured Watchlists Section -->
  <div class="container">
    <h2 class="text-center my-5">Featured Watchlists</h2>
    <div class="swiper mySwiper2">
      <div class="swiper-wrapper">
        <#if featuredWatchlists?has_content>
          <#list featuredWatchlists as watchlist>
            <div class="swiper-slide col-md-4 mb-4 watchlist-item">
              <div class="random-anime-card bg-secondary text-light">
                <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="Watchlist Thumbnail" class="watchlist-thumbnail" onerror="this.src='/pics/default-watchlist.jpg';">
                <div class="random-anime-card-body">
                  <div class="provider-info">
                    <h5 class="random-anime-card-title">${watchlist.title}</h5>
                    <img src="${watchlist.avatar}" alt="Profile Image" class="profile-image">
                    <span class="random-anime-card-text mb-0">By: <a href="/customer/${watchlist.providerUsername}-profile" class="text-light">${watchlist.providerUsername}</a></span>
                  </div>
                  <div class="watchlist-metadata">
                    <p class="views-counter"><i class="fas fa-eye"></i> ${watchlist.views!'0'} views</p>
                    <div class="rating-container">
                      <span class="text-warning">
                        <#assign stars = (watchlist.rating?has_content && watchlist.rating gt 0)?then(watchlist.rating?round, 0)>
                        <#list 1..5 as i>
                          <#if i <= stars>★<#else>☆</#if>
                        </#list>
                      </span>
                      (${(watchlist.rating?has_content)?then(watchlist.rating?string("0.0"), "0.0")}/5)
                    </div>
                  </div>
                  <div class="btn-group">
                    <button class="btn btn-primary" data-watchlist-id="${watchlist.watchlistId}">Subscribe</button>
                    <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">View List</a>
                  </div>
                </div>
              </div>
            </div>
          </#list>
        <#else>
          <div class="col-12 text-center">
            <p>No watchlists available. <a href="/watchlists/new" class="btn btn-primary">Create one now!</a></p>
          </div>
        </#if>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="/js/main.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

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

</body>
</html>
