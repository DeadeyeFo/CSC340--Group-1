<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
      display: flex;
      flex-direction: column;
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
      background-color: #222!important;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      z-index: 1;
      border-radius: 8px;
      margin-top: 4px!important;
      margin-right: -84px!important;
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
      flex: 1;
    }

    /* Watchlist Header */
    .watchlist-header {
      background-image: url('${thumbnail!'/pics/default-watchlist.jpg'}');
      background-size: cover;
      background-position: center;
      padding: 80px 0;
      margin-bottom: 40px;
      position: relative;
      border-radius: 15px;
      overflow: hidden;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
    }

    .watchlist-header::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(26, 30, 37, 0.7);
      backdrop-filter: blur(10px);
      z-index: 0;
    }

    .watchlist-header-content {
      position: relative;
      z-index: 1;
    }

    .watchlist-title {
      font-size: 42px;
      font-weight: 700;
      margin-bottom: 10px;
      text-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
      background: linear-gradient(90deg, #fff, #ecf0f1);
      -webkit-background-clip: text;
      background-clip: text;
      -webkit-text-fill-color: transparent;
      display: inline-block;
    }

    /* Provider Section */
    .provider-section {
      display: flex;
      align-items: center;
      margin-bottom: 30px;
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 20px;
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .provider-icon {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      object-fit: cover;
      border: 3px solid var(--primary-color);
      margin-right: 20px;
    }

    .provider-info {
      flex: 1;
    }

    .provider-info p{
       margin-bottom: 0px;
    }

    .provider-info a {
      color: var(--text-light);
      text-decoration: none;
      font-weight: 600;
      transition: all 0.3s;
    }

    .provider-info a:hover {
      color: var(--primary-color);
    }

    .provider-stats {
      display: flex;
      align-items: center;
    }

    .provider-stats > div {
      margin-right: 20px;
      display: flex;
      align-items: center;
    }

    .provider-stats i {
      margin-right: 5px;
      color: var(--primary-color);
    }

    .rating-display {
      display: flex;
      align-items: center;
    }

    .rating-stars {
      color: var(--warning);
      margin-right: 5px;
    }

    /* Subscribe Button */
    .subscribe-btn {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 10px 20px;
      border-radius: 30px;
      border: none;
      font-weight: 600;
      transition: all 0.3s ease;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      cursor: pointer;
    }

    .subscribe-btn.not-subscribed {
      background: linear-gradient(135deg, #3498db, #2980b9);
      color: white;
    }

    .subscribe-btn.subscribed {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      color: white;
    }

    .subscribe-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.3);
    }

    .subscribe-btn:active {
      transform: translateY(0);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }

    .subscribe-btn .icon {
      font-size: 18px;
    }

    /* Description Section */
    .description-section {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 25px;
      margin-bottom: 40px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .section-title {
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 15px;
      position: relative;
      display: inline-block;
    }

    .section-title:after {
      content: '';
      position: absolute;
      bottom: -8px;
      left: 0;
      width: 60px;
      height: 3px;
      background: linear-gradient(90deg, #3498db, #9b59b6);
    }

    /* Anime Cards */
    .anime-card {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      overflow: hidden;
      transition: all 0.3s ease;
      height: 100%;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      margin-bottom: 20px;
    }

    .anime-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      border-color: rgba(52, 152, 219, 0.3);
    }

    .anime-card-img {
      width: 100%;
      height: 250px;
      object-fit: cover;
      transition: all 0.5s;
    }

    .anime-card:hover .anime-card-img {
      transform: scale(1.05);
    }

    .card-body {
      padding: 20px;
      background: rgba(26, 30, 37, 0.9);
    }

    .card-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 8px;
      color: var(--text-light);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .card-text {
      font-size: 14px;
      color: var(--text-muted);
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .add-anime-card {
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, rgba(41, 128, 185, 0.3) 0%, rgba(44, 62, 80, 0.3) 100%) !important;
        height: 100%;
        min-height: 310px;
        transition: all 0.3s ease;
        border: 2px dashed rgba(52, 152, 219, 0.5) !important;
      }

      .add-anime-card:hover {
        background: linear-gradient(135deg, rgba(41, 128, 185, 0.5) 0%, rgba(44, 62, 80, 0.5) 100%) !important;
        border-color: rgba(52, 152, 219, 1) !important;
      }

      .add-anime-placeholder {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        height: 100%;
        width: 100%;
        padding: 30px;
      }

      .add-anime-placeholder i {
        font-size: 64px;
        color: var(--primary-color);
        margin-bottom: 20px;
        transition: all 0.3s ease;
      }

      .add-anime-card:hover .add-anime-placeholder i {
        transform: scale(1.2);
      }

      .add-anime-placeholder p {
        font-size: 18px;
        font-weight: 600;
        color: var(--text-light);
        margin: 0;
      }

    /* Comment Section */
    .comment-heading-container {
      display: flex;
      align-items: center;
      margin-bottom: 2rem;
      margin-top: 1rem;
    }

    .comment-heading {
      margin-left: 1.5rem;
      margin-top: 0;
      font-size: 1.5rem;
      font-weight: 600;
    }

    .comment-card {
      color: var(--text-light);
      transition: transform 0.3s ease;
      border-radius: 10px;
    }

    .comment-card-body {
      background: transparent;
      overflow: hidden;
      word-break: break-all;
    }

    .comment-card-body p {
      white-space: pre-wrap;
      word-wrap: break-word;
      overflow-wrap: break-word;
      margin-top: 0.5rem;
      font-size: 0.95rem;
    }

    .comment-header {
      display: flex;
      align-items: center;
      flex-wrap: wrap;
      gap: 0.75rem;
    }

    .rounded-circle {
      height: 3rem;
      width: 3rem;
      border: 1.5px solid var(--primary-color);
      object-fit: cover;
      margin-top: 20px;
    }

    .comment-author {
      font-weight: 600;
      font-size: 1rem;
      color: var(--text-light);
    }

    .comment-time,
    .comment-date {
      font-size: 0.75rem;
      color: var(--text-muted);
      margin-bottom: 0.25rem;
    }

    .comment-text {
      margin-top: 0.75rem;
      font-size: 0.95rem;
    }

    .current-user-avatar {
      width: 3rem;
      height: 3rem;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid var(--primary-color);
    }

    .comment-input-wrapper {
      display: flex;
      align-items: center;
      width: 100%;
      max-width: 100%;
      position: relative;
    }

    #commentBox {
      resize: none;
      overflow-y: auto;
      white-space: pre-wrap;
      word-wrap: break-word;
      height: 5.5rem;
      width: 100%;
      background: var(--card-bg);
      color: var(--text-light);
      border-radius: 8px;
      padding: 0.75rem;
      font-size: 0.9rem;
    }

    #commentBox::-webkit-scrollbar {
      width: 0.5rem;
    }

    #commentBox::-webkit-scrollbar-track {
      background: #2c2f33;
      border-radius: 5px;
    }

    #commentBox::-webkit-scrollbar-thumb {
      background: var(--primary-color);
      border-radius: 5px;
    }

    #commentBox::-webkit-scrollbar-thumb:hover {
      background: var(--primary-dark);
    }

    .post-reply-btn {
        margin-left: 100px;
    }

    .emoji-button {
      background: transparent;
      border: none;
      font-size: 1.25rem;
      padding: 0.25rem;
      cursor: pointer;
      position: absolute;
      right: 0.75rem;
      top: 0.2rem;
    }

    .emoji-button:hover {
      opacity: 0.8;
    }

    #emojiPickerContainer {
      z-index: 9999;
      max-height: 20rem;
      overflow-y: auto;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    }

    .reply-emoji-button {
      background: transparent;
      border: none;
      font-size: 1.25rem;
      padding: 0.25rem;
      cursor: pointer;
      position: absolute;
      right: 12px;
      top: 35%;
      transform: translateY(-50%);
    }

    .reply-input-wrapper {
        width: 100%!important;
    }

    .reply-emoji-button:hover {
      opacity: 0.8;
    }

    .toggle-replies {
      display: block;
      font-size: 0.9rem;
      color: var(--primary-color);
      text-decoration: none!important;
      margin-top: 0.5rem;
      cursor: pointer;
    }

    .toggle-replies:hover {
      text-decoration: underline;
    }

    .reply .toggle-replies {
      display: none !important;
    }

    .reply .reply-box {
      width: 100%;
      max-width: 100%;
      height: 5rem;
      background: var(--card-bg);
      color: var(--text-light);
      border-radius: 8px;
      padding: 0.75rem;
      font-size: 0.9rem;
    }

    .reply-box::-webkit-scrollbar {
      width: 0.5rem;
    }

    .reply-box::-webkit-scrollbar-track {
      background: #2c2f33;
      border-radius: 5px;
    }

    .reply-box::-webkit-scrollbar-thumb {
      background: var(--primary-color);
      border-radius: 5px;
    }

    .reply-box::-webkit-scrollbar-thumb:hover {
      background: var(--primary-dark);
    }

    .reply .comment-date,
    .reply .comment-time,
    .nested-reply .comment-date,
    .nested-reply .comment-time {
      font-size: 0.75rem;
      color: var(--text-muted);
      margin-bottom: 0.25rem;
    }

    .reply-btn,
    .report-btn,
    .delete-btn {
      font-size: 0.85rem;
      color: var(--primary-color);
      text-decoration: none;
      margin-right: 1rem;
      transition: color 0.3s ease;
    }

    .reply-btn:hover,
    .report-btn:hover,
    .delete-btn:hover {
      color: var(--primary-dark);
    }

    .action-buttons-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 0.5rem;
    }

    .voting-buttons {
      display: flex;
      gap: 1rem;
    }

    .action-buttons {
      display: flex;
      gap: 1rem;
    }

    .view-more-comments {
      font-size: 0.9rem;
      color: var(--primary-color);
      margin: 1rem auto;
      display: block;
      text-align: center;
      text-decoration: none!important;
    }

    @media (max-width: 767px) {
      .comment-heading {
        margin-left: 1rem;
        font-size: 1.25rem;
      }

      .comment-card {
        padding: 0.75rem;
      }

      .comment-input-wrapper {
        max-width: 95%;
      }

      .reply .reply-box {
        max-width: 98%;
      }

      .rounded-circle,
      .current-user-avatar {
        width: 2.5rem;
        height: 2.5rem;
      }

      .comment-author {
        font-size: 0.9rem;
      }

      .comment-text {
        font-size: 0.85rem;
      }

      .reply-btn,
      .report-btn,
      .delete-btn {
        font-size: 0.8rem;
        margin-right: 0.75rem;
      }
    }

    @media (max-width: 576px) {
      .comment-input-wrapper {
        max-width: 100%;
      }

      .reply .reply-box {
        max-width: 100%;
      }

      .action-buttons-container {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.5rem;
      }

      .voting-buttons,
      .action-buttons {
        gap: 0.75rem;
      }
    }

    /* Footer */
    .footer-section {
      background-color: rgba(26, 30, 37, 0.9);
      backdrop-filter: blur(10px);
      padding: 40px 0 20px;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      text-align: center;
      margin-top: auto;
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

    .link-muted {
      text-decoration: none;
    }

    .dislike-count {
      text-decoration: none;
    }

    .like-count {
      text-decoration: none;
    }

    /* Responsive Adjustments */
    @media (max-width: 991px) {
      .watchlist-title {
        font-size: 28px;
      }

      .section-title {
        font-size: 20px;
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
        gap: 15px;
      }

      .provider-section {
        flex-direction: column;
        align-items: center;
        text-align: center;
      }

      .provider-icon {
        margin-right: 0;
        margin-bottom: 15px;
      }

      .provider-stats {
        justify-content: center;
        flex-wrap: wrap;
      }

      .provider-stats > div {
        margin: 5px 10px;
      }

      .watchlist-header {
        padding: 40px 0;
      }

      .watchlist-title {
        font-size: 24px;
      }

      .social-links a {
        width: 40px;
        height: 40px;
      }

      .social-links img {
        width: 20px;
        height: 20px;
      }
    }

    .action-buttons {
        margin-left: 0px;
    }
  </style>
</head>

<body>

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
                    <a href="/watchlists/watchlist-list">Watchlists library</a>
                    <a href="/browse-anime">Browse Anime</a>
                <#else>
                    <a href="#" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
                    <a href="/watchlists/watchlist-list">Watchlists library</a>
                    <a href="/browse-anime">Browse Anime</a>
                </#if>
            </div>
        </div>

        <#import "/fragments/auth-modals.ftlh" as auth>
                              <@auth.authModals/>

  <!-- Main Content -->
  <div class="content">
    <div class="container">
      <!-- Watchlist Header -->
      <div class="watchlist-header">
        <div class="watchlist-header-content text-center">
          <h1 class="watchlist-title">${title}</h1>
        </div>
      </div>

      <!-- Provider Section -->
      <div class="provider-section">
        <a href="/provider-profile/${watchlistProviderId!}">
          <img src="${avatar!'/pics/default-profile.jpg'}" alt="Provider Icon" class="provider-icon">
        </a>
        <div class="provider-info">
          <p>Created by: <a href="/provider-profile/${watchlistProviderId!}">${providerUsername!''}</a></p>
          <div class="provider-stats">
            <div class="rating-display">
              <span class="five-star-rating rating-stars" id="rateButton">${ratingStars}</span>
              <span>(${rating}/5)</span>
              <#import "/fragments/watchlist-rating-modal.ftlh" as rating>
              <@rating.watchlistRatingModal/>
            </div>
            <div class="views-stat">
              <i class="fas fa-eye"></i>
              <span>${views!'0'} views</span>
            </div>
          </div>
        </div>

        <#if isAuthenticated?? && isAuthenticated>
          <div class="subscribe-container ms-auto">
            <button id="subscribeButton"
                   class="subscribe-btn <#if isSubscribed?? && isSubscribed>subscribed<#else>not-subscribed</#if>"
                   data-watchlist-id="${watchlistId}">
              <span class="icon">
                <i class="fas <#if isSubscribed?? && isSubscribed>fa-check-circle<#else>fa-bookmark</#if>"></i>
              </span>
              <span class="text">
                <#if isSubscribed?? && isSubscribed>Subscribed<#else>Subscribe</#if>
              </span>
            </button>
          </div>
        </#if>
      </div>

      <!-- Description Section -->
      <div class="description-section">
        <h2 class="section-title">Description</h2>
        <p>${description}</p>
      </div>

      <!-- Anime Cards -->
      <h2 class="section-title mb-4">Anime in this Watchlist</h2>
      <div class="row">
        <#if animeList?has_content>
          <#list animeList as anime>
            <div class="col-md-4 mb-4">
              <!-- Add data-id attribute to each anime card -->
              <div class="anime-card" data-id="${anime.id}">
                <img src="${anime.imageUrl!'/pics/default-anime.jpg'}" class="anime-card-img" alt="${anime.title}">
                <div class="card-body">
                  <h5 class="card-title">${anime.title}</h5>
                  <p class="card-text">${anime.alternateTitle!''}</p>
                </div>
              </div>
            </div>
          </#list>
          <!-- Add Anime Card - Only visible to watchlist owner -->
          <#if isAuthenticated?? && isAuthenticated && username == providerUsername>
            <div class="col-md-4 mb-4">
              <a href="/watchlists/select-anime?watchlistId=${watchlistId}" class="text-decoration-none">
                <div class="anime-card add-anime-card">
                  <div class="add-anime-placeholder">
                    <i class="fas fa-plus-circle"></i>
                    <p>Add More Anime</p>
                  </div>
                </div>
              </a>
            </div>
          </#if>
        <#else>
          <div class="col-12 text-center">
            <div class="empty-anime-message">
              <i class="fas fa-film mb-3" style="font-size: 48px; color: var(--text-muted);"></i>
              <p>This watchlist doesn't have any anime yet.</p>
              <#if isAuthenticated?? && isAuthenticated && username == providerUsername>
                <a href="/watchlists/select-anime?watchlistId=${watchlistId}" class="btn btn-primary mt-3">
                  <i class="fas fa-plus-circle me-2"></i>Add Anime
                </a>
              </#if>
            </div>
          </div>
        </#if>
      </div>

      <!-- Comment Section -->


      <script>
          const watchlistId = ${watchlistId?c}; // Use ?c to ensure numeric output
      </script>

      <div class="container text-body">
          <div class="row d-flex justify-content-center">
              <div class="col-md-12 col-lg-10 col-xl-9">
                  <!-- Comment Input Section -->
                  <#if isAuthenticated?? && isAuthenticated>
                      <div class="d-flex flex-start">
                          <img class="rounded-circle shadow-1-strong current-user-avatar" src="${currentUserAvatar}" alt="avatar" width="65" height="65" />
                          <div class="comment-card w-100">
                              <div class="comment-card-body p-4">
                                  <div class="comment-header">
                                      <h5 class="comment-author">${currentUser}</h5>
                                  </div>
                                  <div class="comment-input-wrapper">
                                      <textarea id="commentBox" class="form-control border-0 bg-secondary" rows="3" placeholder="Leave a comment..." maxlength="1000"></textarea>
                                      <button id="emojiPicker" class="emoji-button">😊</button>
                                  </div>
                                  <div class="d-flex justify-content-end mt-2">
                                      <button class="btn btn-primary btn-sm" onclick="postComment()">Comment</button>
                                  </div>
                              </div>
                          </div>
                      </div>
                  <#else>
                      <div class="alert alert-info text-center mb-5">
                          <span>Please <a href="/login" class="alert-link">log in</a> to leave a comment.</span>
                      </div>
                  </#if>

                  <!-- Comments Section - visible to everyone -->
                  <div id="commentSection">
                      <!-- Comments will be loaded here by JavaScript -->
                  </div>
              </div>
          </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer-section">
    <div class="container">
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
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/js/login-registration.js"></script>
  <script src="/js/comment.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/emoji-mart@latest/dist/browser.js"></script>

  <script>
    // Subscribe/Unsubscribe Functionality
    document.addEventListener('DOMContentLoaded', function() {
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
          ORIGIN: 'select_anime_origin',
          WATCHLIST_ID: 'select_anime_watchlist_id'
        }
      };

      // Clear any other watchlist storage to avoid conflicts
      localStorage.removeItem(STORAGE_KEYS.CREATE_WATCHLIST.ANIME_LIST);
      localStorage.removeItem(STORAGE_KEYS.CREATE_WATCHLIST.TEMP_DATA);
      localStorage.removeItem(STORAGE_KEYS.EDIT_WATCHLIST.ANIME_LIST);
      localStorage.removeItem(STORAGE_KEYS.EDIT_WATCHLIST.TEMP_DATA);

      // Find the "Add More Anime" button
      const addAnimeButton = document.querySelector('a[href^="/watchlists/select-anime"]');

      if (addAnimeButton) {
        // Get the current watchlist ID
        const watchlistId = addAnimeButton.href.split('watchlistId=')[1];

        // Update the URL to include view=true parameter
        addAnimeButton.href = `/watchlists/select-anime?watchlistId=${watchlistId}&view=true`;

        addAnimeButton.addEventListener('click', function(e) {
          // Get all anime cards from the page
          const animeCards = document.querySelectorAll('.anime-card:not(.add-anime-card)');
          const animeList = [];

          // Extract anime data from each card
          animeCards.forEach(card => {
            const img = card.querySelector('.anime-card-img');
            const title = card.querySelector('.card-title');

            if (img && title) {
              // Extract the anime ID from data attribute or parse it from URL
              // For this example, we'll assume you add data-id to each anime card
              const animeId = parseInt(card.dataset.id || '0');

              if (animeId) {
                animeList.push({
                  id: animeId,
                  title: title.textContent,
                  imageUrl: img.src
                });
              }
            }
          });

          // Store the current anime list in localStorage
          localStorage.setItem(STORAGE_KEYS.VIEW_WATCHLIST.ANIME_LIST, JSON.stringify(animeList));

          // Set the origin for select-anime
          localStorage.setItem(STORAGE_KEYS.SELECT_ANIME.ORIGIN, 'view');
          localStorage.setItem(STORAGE_KEYS.SELECT_ANIME.WATCHLIST_ID, watchlistId);
        });
      }

      // Subscribe/Unsubscribe Functionality
      const subscribeButton = document.getElementById('subscribeButton');
      if (subscribeButton) {
        subscribeButton.addEventListener('click', function() {
          const watchlistId = this.getAttribute('data-watchlist-id');
          const isSubscribed = this.classList.contains('subscribed');
          const endpoint = isSubscribed ?
            `/api/subscriptions/unsubscribe/${watchlistId}` :
            `/api/subscriptions/subscribe/${watchlistId}`;

          fetch(endpoint, {
            method: 'POST'
          })
          .then(response => {
            if (response.ok) {
              if (isSubscribed) {
                // Unsubscribe action
                this.classList.remove('subscribed');
                this.classList.add('not-subscribed');
                this.querySelector('.text').textContent = 'Subscribe';
                this.querySelector('.icon i').classList.remove('fa-check-circle');
                this.querySelector('.icon i').classList.add('fa-bookmark');
              } else {
                // Subscribe action
                this.classList.remove('not-subscribed');
                this.classList.add('subscribed');
                this.querySelector('.text').textContent = 'Subscribed';
                this.querySelector('.icon i').classList.remove('fa-bookmark');
                this.querySelector('.icon i').classList.add('fa-check-circle');
              }
            }
          })
          .catch(error => {
            console.error('Error updating subscription:', error);
            alert('Failed to update subscription. Please try again.');
          });
        });
      }

      // Comment Section Animation
      const animateOnScroll = function() {
        const elements = document.querySelectorAll('.comment-card, .anime-card');

        elements.forEach(element => {
          const elementPosition = element.getBoundingClientRect().top;
          const screenPosition = window.innerHeight / 1.2;

          if (elementPosition < screenPosition) {
            element.style.opacity = '1';
            element.style.transform = 'translateY(0)';
          }
        });
      };

      document.querySelectorAll('.comment-card, .anime-card').forEach(element => {
        element.style.opacity = '0';
        element.style.transform = 'translateY(20px)';
        element.style.transition = 'all 0.6s ease-out';
      });

      setTimeout(animateOnScroll, 300);

      window.addEventListener('scroll', animateOnScroll);
    });
  </script>
</body>
</html>