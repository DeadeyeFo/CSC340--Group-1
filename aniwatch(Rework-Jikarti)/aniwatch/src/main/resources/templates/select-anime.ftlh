<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AniWatch - Select Anime</title>

  <!-- Stylesheets -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

  <style>
    :root {
      --primary-color: #3498db;
      --primary-dark: #2980b9;
      --secondary-color: #2c3e50;
      --dark-bg: #1a1e25;
      --card-bg: #2c3e50;
      --text-light: #ecf0f1;
      --text-muted: #bdc3c7;
      --success: #2ecc71;
      --warning: #f1c40f;
      --danger: #e74c3c;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #1a1e25 0%, #2c3e50 100%);
      color: var(--text-light);
      line-height: 1.6;
      min-height: 100vh;
    }

    /* Navigation Bar */
    .topnav {
      background-color: rgba(26, 30, 37, 0.9);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1000;
    }

    .logo {
      font-size: 28px;
      font-weight: 700;
      background: linear-gradient(90deg, #3498db, #9b59b6);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
      margin: 0;
    }

    .logo-link {
      text-decoration: none;
    }

    .nav-links {
      display: flex;
      gap: 20px;
      align-items: center;
    }

    .nav-links a {
      color: var(--text-light);
      text-decoration: none;
      font-weight: 500;
      transition: all 0.3s;
      position: relative;
      padding: 5px 0;
    }

    .nav-links a:before {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 0;
      height: 2px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
      transition: width 0.3s;
    }

    .nav-links a:hover:before {
      width: 100%;
    }

    .dropdown {
      position: relative;
      display: inline-block;
      margin-bottom: 11px;
    }

    .dropdown-menu {
      display: none;
      position: absolute;
      background-color: #222 !important;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
      z-index: 1;
      border-radius: 8px;
      margin-top: 4px !important;
      margin-right: -84px !important;
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

    /* Content Styles */
    .content {
      padding-top: 100px;
      padding-bottom: 50px;
    }

    /* Page Header */
    .page-header {
      text-align: center;
      margin-bottom: 40px;
      position: relative;
    }

    .page-header h2 {
      font-weight: 700;
      font-size: 36px;
      margin-bottom: 15px;
      position: relative;
      display: inline-block;
    }

    .page-header h2:after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 80px;
      height: 3px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
    }

    .page-header p {
      color: var(--text-muted);
      font-size: 18px;
      max-width: 600px;
      margin: 0 auto;
    }

    /* Back Button */
    .back-button {
      display: inline-flex;
      align-items: center;
      color: var(--primary-color);
      text-decoration: none;
      font-weight: 500;
      font-size: 16px;
      transition: all 0.3s;
      margin-bottom: 20px;
    }

    .back-button i {
      margin-right: 8px;
    }

    .back-button:hover {
      color: var(--primary-color);
      transform: translateX(-3px);
    }

    /* Search and Filter Section */
    .search-filter-section {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.3) 0%, rgba(52, 73, 94, 0.3) 100%);
      border-radius: 12px;
      padding: 25px;
      margin-bottom: 40px;
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .search-bar {
      width: 100%;
      position: relative;
      margin-bottom: 20px;
    }

    .search-bar .form-control {
      background-color: rgba(52, 73, 94, 0.3);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 50px;
      padding: 15px 25px;
      color: var(--text-light);
      font-size: 16px;
      transition: all 0.3s;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .search-bar .form-control:focus {
      background-color: rgba(52, 73, 94, 0.5);
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
    }

    .search-bar .form-control::placeholder {
      color: rgba(255, 255, 255, 0.5);
    }

    .search-bar:before {
      content: '\f002';
      font-family: 'Font Awesome 5 Free';
      font-weight: 900;
      position: absolute;
      right: 20px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--primary-color);
      font-size: 20px;
      z-index: 1;
    }

    .filter-section {
      display: flex;
      flex-wrap: wrap;
      gap: 15px;
    }

    .filter-section select {
      background-color: rgba(52, 73, 94, 0.3);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 8px;
      padding: 10px 15px;
      color: var(--text-light);
      font-size: 14px;
      transition: all 0.3s;
      min-width: 150px;
    }

    .filter-section select:focus {
      background-color: rgba(52, 73, 94, 0.5);
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
    }

    .filter-section select option {
      background-color: var(--dark-bg);
    }

    /* Selection Counter */
    .selection-counter {
      position: fixed;
      bottom: 20px;
      right: 20px;
      background: linear-gradient(135deg, rgba(52, 152, 219, 0.9) 0%, rgba(41, 128, 185, 0.9) 100%);
      border-radius: 8px;
      padding: 15px 20px;
      box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
      display: flex;
      align-items: center;
      justify-content: space-between;
      min-width: 280px;
      z-index: 100;
      backdrop-filter: blur(5px);
    }

    .counter-info {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .counter-badge {
      background: rgba(255, 255, 255, 0.2);
      border-radius: 50px;
      padding: 5px 15px;
      font-weight: 600;
    }

    .done-btn {
      background: white;
      color: var(--primary-dark);
      border: none;
      border-radius: 8px;
      padding: 8px 16px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
      display: flex;
      align-items: center;
      gap: 5px;
    }

    .done-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
    }

    /* Anime Grid */
    .anime-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 25px;
    }

    .anime-card {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      overflow: hidden;
      position: relative;
      transition: all 0.3s ease;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      cursor: pointer;
      height: 100%;
    }

    .anime-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      border-color: rgba(52, 152, 219, 0.3);
    }

    .anime-card img {
      width: 100%;
      height: 280px;
      object-fit: cover;
      transition: all 0.5s;
    }

    .anime-card:hover img {
      transform: scale(1.05);
    }

    .anime-card .card-body {
      padding: 20px;
      background: rgba(26, 30, 37, 0.9);
      display: flex;
      flex-direction: column;
      height: calc(100% - 280px);
    }

    .anime-card .card-title {
      font-size: 16px;
      font-weight: 600;
      margin-bottom: 5px;
      color: var(--text-light);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .anime-card .card-text {
      font-size: 14px;
      color: var(--text-muted);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      margin-bottom: auto;
    }

    /* Selection Checkmark */
    .selection-indicator {
      position: absolute;
      top: 10px;
      right: 10px;
      background: rgba(26, 30, 37, 0.8);
      border-radius: 50%;
      width: 30px;
      height: 30px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--text-light);
      font-size: 16px;
      opacity: 0.7;
      transition: all 0.3s;
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .anime-card.selected .selection-indicator {
      background: var(--success);
      opacity: 1;
      border-color: white;
    }

    .anime-card:hover .selection-indicator {
      opacity: 1;
    }

    /* Animation for card loading */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }

      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .anime-card {
      animation: fadeInUp 0.5s ease-out forwards;
      animation-delay: calc(var(--index) * 0.1s);
      opacity: 0;
    }

    /* Loading Spinner */
    .loading-spinner {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px;
    }

    .spinner {
      width: 40px;
      height: 40px;
      border: 4px solid rgba(255, 255, 255, 0.3);
      border-radius: 50%;
      border-top-color: var(--primary-color);
      animation: spin 1s ease-in-out infinite;
    }

    @keyframes spin {
      to {
        transform: rotate(360deg);
      }
    }

    /* Pagination */
    .pagination-container {
      display: flex;
      justify-content: center;
      margin-top: 50px;
    }

    .pagination {
      background: rgba(52, 73, 94, 0.3);
      border-radius: 50px;
      padding: 5px;
      display: inline-flex;
    }

    .pagination .page-item .page-link {
      border: none;
      color: var(--text-light);
      background-color: transparent;
      transition: all 0.3s;
      padding: 10px 15px;
      border-radius: 50px;
      margin: 0 5px;
    }

    .pagination .page-item.active .page-link,
    .pagination .page-item .page-link:hover {
      background-color: var(--primary-color);
      color: white;
    }

    .pagination .page-item.disabled .page-link {
      color: var(--text-muted);
    }

    /* Footer Styles */
    .footer-section {
      background-color: rgba(26, 30, 37, 0.9);
      backdrop-filter: blur(10px);
      padding: 40px 0 20px;
      margin-top: 80px;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      text-align: center;
    }

    .social-links {
      display: flex;
      justify-content: center;
      gap: 20px;
      margin-bottom: 20px;
    }

    .social-links a {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 50px;
      height: 50px;
      border-radius: 50%;
      background-color: rgba(52, 73, 94, 0.5);
      transition: all 0.3s;
    }

    .social-links a:hover {
      transform: translateY(-5px);
      background-color: var(--primary-color);
    }

    .social-links img {
      width: 25px;
      height: 25px;
      object-fit: contain;
    }

    .footer-section p {
      color: var(--text-muted);
      margin-top: 20px;
    }

    /* Responsive adjustments */
    @media (max-width: 991px) {
      .anime-grid {
        grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
      }

      .page-header h2 {
        font-size: 30px;
      }
    }

    @media (max-width: 767px) {
      .topnav {
        padding: 10px 15px;
      }

      .logo {
        font-size: 24px;
      }

      .nav-links {
        gap: 10px;
      }

      .page-header h2 {
        font-size: 26px;
      }

      .filter-section {
        flex-direction: column;
      }

      .filter-section select {
        width: 100%;
      }

      .anime-grid {
        grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
      }

      .selection-counter {
        width: calc(100% - 40px);
        min-width: auto;
      }
    }
  </style>
</head>

<body>
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
                <a href="/user-profile/${userId!}">My Profile</a>
            </#if>
            <a href="/logout">Logout</a>
          </div>
        </div>
        <#else>
          <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
      </#if>
      <a href="/watchlists/watchlist-list">Watchlist library</a>
      <a href="/browse-anime">Browse Anime</a>
    </div>
  </div>

  <!-- Main Content -->
  <div class="content">
    <div class="container">
      <a href="/watchlists/new" class="back-button">
        <i class="fas fa-arrow-left"></i> Back to Watchlist Creation
      </a>

      <div class="page-header">
        <h2>Select Anime</h2>
        <p>Choose up to 24 anime to add to your watchlist</p>
      </div>

      <!-- Search and Filter Section -->
      <div class="search-filter-section">
        <div class="search-bar">
          <input type="text" id="searchInput" class="form-control" placeholder="Search anime by title..." />
        </div>
        <div class="filter-section">
          <select id="genreFilter" class="form-select">
            <option value="">All Genres</option>
            <option value="action">Action</option>
            <option value="adventure">Adventure</option>
            <option value="comedy">Comedy</option>
            <option value="drama">Drama</option>
            <option value="fantasy">Fantasy</option>
            <option value="horror">Horror</option>
            <option value="mystery">Mystery</option>
            <option value="romance">Romance</option>
            <option value="sci-fi">Sci-Fi</option>
            <option value="slice-of-life">Slice of Life</option>
          </select>
          <select id="sortFilter" class="form-select">
            <option value="title-asc">Sort by Title (A-Z)</option>
            <option value="title-desc">Sort by Title (Z-A)</option>
            <option value="popularity">Sort by Popularity</option>
            <option value="latest">Sort by Latest</option>
          </select>
        </div>
      </div>

      <#if watchlistAnime?has_content>
        <div class="d-none">
          <#list watchlistAnime as anime>
            <div data-watchlist-anime="true" data-id="${anime.id}" data-title="${anime.title}" data-image="${anime.imageUrl!'/pics/default-anime.jpg'}"></div>
          </#list>
        </div>
      </#if>

      <!-- Anime Grid -->
      <div class="anime-grid" id="animeGrid">
        <#if animeList?has_content>
          <#list animeList as anime>
            <div class="anime-card" data-id="${anime.id}" data-title="${anime.title}" data-image="${anime.imageUrl!'/pics/default-anime.jpg'}" style="--index: ${anime?index}">
              <div class="selection-indicator">
                <i class="fas fa-check"></i>
              </div>
              <img src="${anime.imageUrl!'/pics/default-anime.jpg'}" alt="${anime.title}" loading="lazy" />
              <div class="card-body">
                <h5 class="card-title">${anime.title}</h5>
                <p class="card-text">Alternate Title: ${anime.alternateTitle!''}</p>
              </div>
            </div>
          </#list>
        <#else>
          <div class="loading-spinner">
            <div class="spinner"></div>
          </div>
        </#if>
      </div>

      <!-- Pagination -->
      <#if totalPages?? && totalPages gt 1>
        <div class="pagination-container">
          <ul class="pagination">
            <li class="page-item <#if currentPage == 0>disabled</#if>">
              <a class="page-link" href="?page=${currentPage - 1}" <#if currentPage == 0>tabindex="-1" aria-disabled="true"</#if>>
                <i class="fas fa-chevron-left"></i>
              </a>
            </li>
            <#list 0..(totalPages-1) as page>
              <li class="page-item <#if currentPage == page>active</#if>">
                <a class="page-link" href="?page=${page}">${page + 1}</a>
              </li>
            </#list>
            <li class="page-item <#if currentPage == totalPages - 1>disabled</#if>">
              <a class="page-link" href="?page=${currentPage + 1}" <#if currentPage == totalPages - 1>tabindex="-1" aria-disabled="true"</#if>>
                <i class="fas fa-chevron-right"></i>
              </a>
            </li>
          </ul>
        </div>
      </#if>

      <!-- Selection Counter -->
      <div class="selection-counter" id="selectionCounter">
        <div class="counter-info">
          <span>Selected:</span>
          <span class="counter-badge" id="selectionCount">0/24</span>
        </div>
        <button class="done-btn" id="doneBtn">
          <i class="fas fa-check"></i> Done
        </button>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer-section">
    <div class="container">
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
    </div>
  </footer>

  <#import "/fragments/auth-modals.ftlh" as auth>
  <@auth.authModals />

  <!-- Scripts -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <script>
  <#noparse>
    document.addEventListener('DOMContentLoaded', function () {
      const animeCards = document.querySelectorAll('.anime-card');
      const selectionCounter = document.getElementById('selectionCounter');
      const selectionCount = document.getElementById('selectionCount');
      const doneBtn = document.getElementById('doneBtn');
      const searchInput = document.getElementById('searchInput');
      const genreFilter = document.getElementById('genreFilter');
      const sortFilter = document.getElementById('sortFilter');
      const backButton = document.querySelector('.back-button');

      // Define storage keys
      const STORAGE_KEYS = {
        CREATE_WATCHLIST: {
          ANIME_LIST: 'create_watchlist_anime_list',
          TEMP_DATA: 'create_watchlist_temp_data'
        },
        EDIT_WATCHLIST: {
          ANIME_LIST: 'edit_watchlist_anime_list',
          TEMP_DATA: 'edit_watchlist_temp_data'
        },
        VIEW_WATCHLIST: {
          ANIME_LIST: 'view_watchlist_anime_list',
        },
        SELECT_ANIME: {
          ORIGIN: 'select_anime_origin', // Values: 'create', 'edit', or 'view'
          WATCHLIST_ID: 'select_anime_watchlist_id'
        }
      };

      // Check mode and get watchlist ID
      const urlParams = new URLSearchParams(window.location.search);
      const watchlistId = urlParams.get('watchlistId');

      // Determine if we're in view mode (from watchlist page)
      // View mode will be detected by presence of 'view' parameter
      const viewMode = urlParams.get('view') === 'true';
      const editMode = !viewMode && !!watchlistId;
      const createMode = !viewMode && !watchlistId;

      // Set the origin and watchlist ID in localStorage
      if (viewMode) {
        localStorage.setItem(STORAGE_KEYS.SELECT_ANIME.ORIGIN, 'view');
      } else if (editMode) {
        localStorage.setItem(STORAGE_KEYS.SELECT_ANIME.ORIGIN, 'edit');
      } else {
        localStorage.setItem(STORAGE_KEYS.SELECT_ANIME.ORIGIN, 'create');
      }

      if (watchlistId) {
        localStorage.setItem(STORAGE_KEYS.SELECT_ANIME.WATCHLIST_ID, watchlistId);
      }

      // Update back button URL and text based on origin
      if (backButton) {
        if (viewMode) {
          backButton.href = `/watchlists/${watchlistId}`;
          backButton.innerHTML = '<i class="fas fa-arrow-left"></i> Back to Watchlist';
        } else if (editMode) {
          backButton.href = `/watchlists/edit/${watchlistId}`;
          backButton.innerHTML = '<i class="fas fa-arrow-left"></i> Back to Watchlist Editor';
        } else {
          backButton.href = '/watchlists/new';
          backButton.innerHTML = '<i class="fas fa-arrow-left"></i> Back to Watchlist Creation';
        }
      }

      const MAX_SELECTIONS = 24;
      let selectedAnime = [];

      // Determine which storage key to use based on mode
      let ANIME_LIST_KEY;
      if (viewMode) {
        ANIME_LIST_KEY = STORAGE_KEYS.VIEW_WATCHLIST.ANIME_LIST;
      } else if (editMode) {
        ANIME_LIST_KEY = STORAGE_KEYS.EDIT_WATCHLIST.ANIME_LIST;
      } else {
        ANIME_LIST_KEY = STORAGE_KEYS.CREATE_WATCHLIST.ANIME_LIST;
      }

      // Load the stored anime list from the appropriate localStorage key
      const storedAnimeList = localStorage.getItem(ANIME_LIST_KEY);

      if (storedAnimeList) {
        try {
          selectedAnime = JSON.parse(storedAnimeList);
          updateSelectionCount();

          // Mark pre-selected anime cards
          selectedAnime.forEach(anime => {
            const card = document.querySelector(`.anime-card[data-id="${anime.id}"]`);
            if (card) {
              card.classList.add('selected');
            }
          });
        } catch (error) {
          console.error('Error parsing stored anime list:', error);
          localStorage.removeItem(ANIME_LIST_KEY);
          selectedAnime = [];
        }
      } else if (watchlistId) {
        // For view or edit mode, if there's no stored list, we'll pre-populate from the data attributes
        // This happens when directly navigating to the page without going through the watchlist first
        console.log("No stored anime list found, attempting to load from page data...");

        // Look for data attributes that might contain current watchlist anime
        const animeDataElements = document.querySelectorAll('[data-watchlist-anime="true"]');
        if (animeDataElements && animeDataElements.length > 0) {
          console.log(`Found ${animeDataElements.length} anime from watchlist data`);

          // Create a list of currently selected anime
          animeDataElements.forEach(elem => {
            try {
              const animeId = parseInt(elem.dataset.id);
              const animeTitle = elem.dataset.title || "Unknown Title";
              const animeImage = elem.dataset.image || "/pics/default-anime.jpg";

              selectedAnime.push({
                id: animeId,
                title: animeTitle,
                imageUrl: animeImage
              });

              // Mark the anime card as selected
              const card = document.querySelector(`.anime-card[data-id="${animeId}"]`);
              if (card) {
                card.classList.add('selected');
              }
            } catch (e) {
              console.error("Error processing anime data:", e);
            }
          });

          // Store the selected anime in localStorage
          localStorage.setItem(ANIME_LIST_KEY, JSON.stringify(selectedAnime));
          updateSelectionCount();
        }
      }

      animeCards.forEach((card, index) => {
        card.style.setProperty('--index', index % 20);
      });

      // Toggle anime selection
      animeCards.forEach(card => {
        card.addEventListener('click', function() {
          const animeId = parseInt(this.dataset.id);
          const animeTitle = this.dataset.title;
          const animeImage = this.dataset.image;

          // Check if anime card is already selected
          const isAlreadySelected = selectedAnime.some(anime => anime.id === animeId);

          if (isAlreadySelected) {
            selectedAnime = selectedAnime.filter(anime => anime.id !== animeId);
            this.classList.remove('selected');
          } else {
            if (selectedAnime.length >= MAX_SELECTIONS) {
              alert(`You can only select up to ${MAX_SELECTIONS} anime for a watchlist.`);
              return;
            }

            // Add to selection
            selectedAnime.push({
              id: animeId,
              title: animeTitle,
              imageUrl: animeImage
            });
            this.classList.add('selected');
          }

          // Update localStorage with the appropriate key
          localStorage.setItem(ANIME_LIST_KEY, JSON.stringify(selectedAnime));

          // Update count display
          updateSelectionCount();
        });
      });

      function updateSelectionCount() {
        selectionCount.textContent = `${selectedAnime.length}/${MAX_SELECTIONS}`;
      }

      // Search functionality
      searchInput.addEventListener('input', function() {
        filterAnime();
      });

      genreFilter.addEventListener('change', function() {
        filterAnime();
      });

      sortFilter.addEventListener('change', function() {
        filterAnime();
      });

      // Filter and sort anime cards
      function filterAnime() {
        const searchTerm = searchInput.value.toLowerCase().trim();
        const genreValue = genreFilter.value.toLowerCase();
        const sortValue = sortFilter.value;

        animeCards.forEach(card => {
          const title = card.dataset.title.toLowerCase();
          const matchesSearch = searchTerm === '' || title.includes(searchTerm);
          const matchesGenre = genreValue === '' || card.dataset.genres?.includes(genreValue);

          if (matchesSearch && matchesGenre) {
            card.style.display = '';
          } else {
            card.style.display = 'none';
          }
        });

        sortAnimeCards(sortValue);
      }

      // Sort anime cards
      function sortAnimeCards(sortType) {
        const animeGrid = document.getElementById('animeGrid');
        const cards = Array.from(animeGrid.children);

        cards.sort((a, b) => {
          const titleA = a.dataset.title?.toLowerCase() || '';
          const titleB = b.dataset.title?.toLowerCase() || '';

          switch (sortType) {
            case 'title-asc':
              return titleA.localeCompare(titleB);
            case 'title-desc':
              return titleB.localeCompare(titleA);
            case 'popularity':
              return parseInt(b.dataset.popularity || 0) - parseInt(a.dataset.popularity || 0);
            case 'latest':
              return parseInt(b.dataset.releaseDate || 0) - parseInt(a.dataset.releaseDate || 0);
            default:
              return 0;
          }
        });

        // Remove all cards from the grid
        while (animeGrid.firstChild) {
          animeGrid.removeChild(animeGrid.firstChild);
        }

        // Add sorted cards back to the grid
        cards.forEach(card => {
          animeGrid.appendChild(card);
        });
      }

      doneBtn.addEventListener('click', function() {
        if (viewMode || editMode) {
          // View or Edit mode - submit directly to update the watchlist
          const selectedAnimeIds = selectedAnime.map(anime => anime.id).join(',');

          // Create form to submit the data
          const form = document.createElement('form');
          form.method = 'POST';
          form.action = `/watchlists/add-anime/${watchlistId}`;

          // Create hidden input for anime IDs
          const input = document.createElement('input');
          input.type = 'hidden';
          input.name = 'selectedAnimeIds';
          input.value = selectedAnimeIds;

          // Add CSRF token if needed
          if (document.querySelector('meta[name="_csrf"]')) {
            const csrfInput = document.createElement('input');
            csrfInput.type = 'hidden';
            csrfInput.name = document.querySelector('meta[name="_csrf_parameter_name"]').content;
            csrfInput.value = document.querySelector('meta[name="_csrf"]').content;
            form.appendChild(csrfInput);
          }

          // Add the input to the form and submit
          form.appendChild(input);
          document.body.appendChild(form);
          form.submit();
        } else {
          // Create mode - go back to create watchlist page
          window.location.href = '/watchlists/new';
        }
      });
    });
        </#noparse>
        </script>
      </body>
      </html>