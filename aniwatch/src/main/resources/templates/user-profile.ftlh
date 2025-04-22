<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch - User Profile</title>
  <link rel="stylesheet" href="/css/manage-profile.css">
  <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Swiper JS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

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
  <div class="topnav">
    <a href="/home" class="logo-link">
      <h1 class="logo">AniWatch</h1>
    </a>
    <div class="nav-links">
      <#if isAuthenticated?? && isAuthenticated>
        <#if isOwnProfile?? && isOwnProfile>
          <div class="dropdown">
            <a href="#" class="dropbtn">
              <i class="fas fa-user"></i> ${username!}
            </a>
            <div class="dropdown-menu">
              <#if isProvider?? && isProvider>
                <a href="#" data-bs-toggle="modal" data-bs-target="#settingsModal">Profile Settings</a>
                <a href="/watchlists/new">Create Watchlist</a>
              <#else>
                <a href="#" data-bs-toggle="modal" data-bs-target="#settingsModal">Profile Settings</a>
              </#if>
              <a href="/logout">Logout</a>
            </div>
          </div>
        </#if>
        <a href="/watchlists/watchlist-list">Watchlists library</a>
        <a href="/browse-anime">Browse Anime</a>
      <#else>
        <a href="/login">Login</a>
      </#if>
    </div>
  </div>

  <!-- profile section -->
  <div class="content">
    <div class="container my-5">
      <div class="profile-background"> </div>
      <div class="text-center mb-5">
        <img id="profileImage" src="${(user.profileImage)!'/pics2/default-profile.jpg'}"
          alt="${user.username!''}" class="profile-img">
        <h2>${user.username!''}</h2>
      </div>
    </div>
  </div>

  <script src="/js/profile.js"></script>

  <h2 class="stats-title">Bio</h2>
  <div class="bio-bubble">
    <div class="bio-content">
      <p>${user.bio!'No bio available yet.'}</p>
    </div>
  </div>

  <!-- User Stats Section -->
  <div class="row">
    <div class="stats-container">
      <h2 class="stats-title">Statistics</h2>
      <div class="stats-box">
        <div class="stats-header">
          <h3>User Stats</h3>
          <a href="/user-profile/stats">View All Stats</a>
        </div>
        <div class="stats-details">
          <p><strong>Joined:</strong>
            <#if user.joinDate??>
              <span>${user.joinDate}</span>
            <#else>
              <span>-</span>
            </#if>
          </p>
          <p><strong>Activity Level: </strong>
            <span>Regular Viewer</span>
          </p>
          <div class="progress-bar"></div>
          <div class="stats-list">
            <span class="circle green"></span> Subscribed Lists <span>${subscriptionCount!'0'}</span>
            <span class="circle red"></span> Reviews Made <span>0</span>
            <span class="circle gray"></span> Comments <span>0</span>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="watchlist-bubble">
    <div class="stats-header">
      <h3>Subscribed Watchlists</h3>
      <a href="/watchlists/watchlist-list">View all watchlists</a>
    </div>
    <div class="content">
      <div class="container">
        <!-- Watchlist Cards -->
        <div class="swiper mySwiper2">
          <div class="swiper-wrapper">
            <!-- Display message if no watchlists -->
            <#if !subscribedWatchlists?? || subscribedWatchlists?size == 0>
              <div class="swiper-slide">
                <div class="random-anime-card bg-secondary text-light text-center">
                  <div class="random-anime-card-body p-5">
                    <h5>No subscribed watchlists yet</h5>
                    <a href="/watchlists/watchlist-list" class="btn btn-outline-light mt-3">Explore Watchlists</a>
                  </div>
                </div>
              </div>
            <#else>
              <!-- Loop through watchlists -->
              <#list subscribedWatchlists as watchlist>
                <div class="swiper-slide col-md-4 mb-4 watchlist-item" data-keywords="${(watchlist.tags)!'general'}">
                  <div class="random-anime-card bg-secondary text-light">
                    <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="Watchlist Thumbnail"
                      class="watchlist-thumbnail">
                    <div class="random-anime-card-body">
                      <div class="provider-info">
                        <h5 class="random-anime-card-title">${watchlist.title}</h5>
                        <img src="${watchlist.avatar!'/pics/default-profile.jpg'}" alt="Profile Image"
                          class="profile-image">
                        <p class="random-anime-card-text mb-0">
                          By:&nbsp;<a href="/provider-profile/${watchlist.providerId}" class="text-light">
                            ${watchlist.providerUsername!''}
                          </a>
                        </p>
                      </div>
                      <div class="watchlist-list-rating mb-2">
                        <span class="text-warning">
                          <#assign stars = (watchlist.rating?has_content && watchlist.rating gt 0)?then(watchlist.rating?round, 0)>
                          <#list 1..5 as i>
                            <#if i <= stars>★<#else>☆</#if>
                          </#list>
                        </span>
                        (${(watchlist.rating?has_content)?then(watchlist.rating?string("0.0"), "0.0")}/5)
                      </div>
                      <div class="btn-group">
                        <button class="btn btn-danger unsubscribe-btn"
                          data-watchlist-id="${watchlist.watchlistId}">Unsubscribe</button>
                        <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">View List</a>
                      </div>
                    </div>
                  </div>
                </div>
              </#list>
            </#if>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- User Settings Modal -->
  <div class="modal fade" id="settingsModal" tabindex="-1" aria-labelledby="settingsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="settingsModalLabel">Profile Settings</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form action="/user-profile/update" method="post" enctype="multipart/form-data">
            <!-- Include CSRF token if available -->
            <#if _csrf??>
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </#if>

            <div class="mb-3">
              <label for="username" class="form-label">Username</label>
              <input type="text" class="form-control" id="username" value="${user.username!''}" disabled>
              <div class="form-text text-light opacity-75">Username cannot be changed</div>
            </div>
            <div class="mb-3">
              <label for="bio" class="form-label">Bio</label>
              <textarea class="form-control" id="bio" name="bio" rows="3">${user.bio!''}</textarea>
            </div>
            <div class="mb-3">
              <label for="profileImage" class="form-label">Profile Picture</label>
              <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">

              <#if user.profileImage?? && user.profileImage?has_content>
                <div class="mt-2">
                  <p>Current profile image:</p>
                  <img src="${user.profileImage}" alt="Current Profile Image" class="img-thumbnail"
                    style="max-width: 150px;">
                </div>
              </#if>
            </div>

            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="/js/main.js"></script>

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
