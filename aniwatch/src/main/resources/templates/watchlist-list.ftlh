<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AniWatch - Watchlists</title>
    <link rel="stylesheet" href="/css/create-service.css">
    <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        #viewMoreContainer {
            width: 100%;
            display: flex;
            justify-content: center;
        }

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
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
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
            <a href="/browse-anime">Browse Anime</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container my-5">
            <h2 class="text-center mb-4">Browse Watchlists</h2>
            <p class="text-center mb-4">Discover curated anime watchlists from our community!</p>

            <!-- Search Bar -->
            <div class="search-bar mb-5">
                <input type="text" id="searchInput" class="form-control" placeholder="Search watchlists by name, genre, or type...">
            </div>

            <#if watchlists?has_content>
                <div class="row" id="watchlistContainer">
                    <#assign count = 0>
                    <#list watchlists?sort_by("watchlistId")?reverse as watchlist>
                        <#if count < 9>
                            <div class="col-md-4 mb-4 watchlist-item">
                                <div class="random-anime-card bg-secondary text-light">
                                    <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="Watchlist Thumbnail" class="watchlist-thumbnail">
                                    <div class="random-anime-card-body">
                                            <div class="provider-info">
                                                <h5 class="random-anime-card-title">${watchlist.title}</h5>
                                                <img src="${watchlist.avatar}" alt="Profile Image" class="profile-image">
                                                    <p class="random-anime-card-text mb-0">By: <a href="/customer/${watchlist.providerUsername}-profile" class="text-light">${watchlist.providerUsername}</a></p>
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
                                            <button class="btn btn-primary">Subscribe</button>
                                            <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">View List</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <#else>
                            <div class="col-md-4 mb-4 watchlist-item hidden-watchlist" style="display: none;">
                                <div class="random-anime-card bg-secondary text-light">
                                    <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="Watchlist Thumbnail" class="watchlist-thumbnail">
                                    <div class="random-anime-card-body">
                                        <div class="provider-info">
                                            <h5 class="random-anime-card-title">${watchlist.title}</h5>
                                            <img src="${watchlist.avatar}" alt="Profile Image" class="profile-image">
                                            <p class="random-anime-card-text mb-0">By: <a href="/customer/${watchlist.providerUsername}-profile" class="text-light">${watchlist.providerUsername}</a></p>
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
                                            <button class="btn btn-primary">Subscribe</button>
                                            <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">View List</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </#if>
                        <#assign count = count + 1>
                    </#list>
                </div>

                <!-- No search results message -->
                <div id="noSearchResults" style="display: none;" class="alert alert-info text-center mt-4 w-100">
                    <i class="fas fa-search fa-2x mb-3"></i>
                    <p>No watchlists found matching your search. Try different keywords.</p>
                </div>

                <#if watchlists?size gt 9>
                    <div class="text-center mt-4 mb-5" id="viewMoreContainer">
                        <button id="viewMoreBtn" class="btn btn-lg btn-outline-primary">View More Watchlists</button>
                    </div>
                </#if>
            <#else>
                <div class="alert alert-info text-center w-100">
                    <i class="fas fa-list-alt fa-3x mb-3"></i>
                    <p>No watchlists found. Create one to get started!</p>
                </div>
            </#if>
        </div>
    </div>

    <!-- Footer -->
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
        <p>© 2025 AniWatch</p>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Search and View More Functionality -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    if (!searchInput) return;

    const watchlistContainer = document.getElementById('watchlistContainer');
    if (!watchlistContainer) return;

    const viewMoreContainer = document.getElementById('viewMoreContainer');

    // Store original HTML and visibility state
    const originalHTML = watchlistContainer.innerHTML;
    const originalViewMoreDisplay = viewMoreContainer ? viewMoreContainer.style.display : 'none';

    setupViewMore(); // Initial setup

    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase().trim();
        const allItems = Array.from(watchlistContainer.querySelectorAll('.watchlist-item'));
        const noResultsMsg = document.getElementById('noSearchResults');

        // If search is cleared, restore original state
        if (searchTerm === '') {
            watchlistContainer.innerHTML = originalHTML;
            if (noResultsMsg) noResultsMsg.style.display = 'none';

            // Restore view more button
            if (viewMoreContainer) {
                viewMoreContainer.style.display = originalViewMoreDisplay;
            }

            setupViewMore(); // Reattach event listeners
            return;
        }

        // Handle search
        watchlistContainer.innerHTML = '';

        const matchingItems = allItems.filter(item => {
            const titleElement = item.querySelector('.random-anime-card-title');
            const usernameElement = item.querySelector('.random-anime-card-text');

            if (!titleElement) return false;

            const title = titleElement.textContent.toLowerCase();
            const username = usernameElement ? usernameElement.textContent.toLowerCase() : '';

            return title.includes(searchTerm) || username.includes(searchTerm);
        });

        matchingItems.forEach(item => {
            watchlistContainer.appendChild(item);
            item.style.display = 'block';
        });

        // Show/hide no results message
        if (noResultsMsg) {
            noResultsMsg.style.display = matchingItems.length > 0 ? 'none' : 'block';
        }

        // Hide view more button during search
        if (viewMoreContainer) {
            viewMoreContainer.style.display = 'none';
        }
    });

    function setupViewMore() {
        const viewMoreBtn = document.getElementById('viewMoreBtn');
        if (!viewMoreBtn) return;

        // Remove existing event listeners by cloning and replacing
        const newViewMoreBtn = viewMoreBtn.cloneNode(true);
        viewMoreBtn.parentNode.replaceChild(newViewMoreBtn, viewMoreBtn);

        newViewMoreBtn.addEventListener('click', function() {
            const hiddenItems = document.querySelectorAll('.watchlist-item.hidden-watchlist');
            const batchSize = 6;
            let shown = 0;

            hiddenItems.forEach(function(item) {
                if (shown < batchSize) {
                    item.style.display = 'block';
                    item.classList.remove('hidden-watchlist');
                    shown++;
                }
            });

            if (document.querySelectorAll('.watchlist-item.hidden-watchlist').length === 0) {
                this.style.display = 'none';
            }
        });
    }
});
</script>
</body>
</html>