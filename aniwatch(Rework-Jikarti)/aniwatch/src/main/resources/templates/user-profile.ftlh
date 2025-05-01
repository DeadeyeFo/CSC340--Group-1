<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch - User Profile</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

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
    }

    /* Profile Header */
    .profile-header {
          position: relative;
          overflow: hidden;
          border-radius: 15px;
          padding: 40px 0;
          margin-bottom: 40px;
          text-align: center;
    }

    .profile-header::before {
          content: '';
          position: absolute;
          top: -10px;
          left: -10px;
          right: -10px;
          bottom: -10px;
          background-image: url('${(user.profileImage)!'/pics/default-profile.jpg'}');
          background-size: cover;
          background-position: center;
          filter: blur(15px);
          z-index: 0;
    }

    .profile-header::after {
          content: '';
          position: absolute;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: linear-gradient(135deg,
                        rgba(26, 30, 37, 0.65) 0%,
                        rgba(44, 62, 80, 0.65) 100%);
          z-index: 1;
        }

        /* Content container */
        .profile-content {
          position: relative;
          z-index: 2;
        }

        .profile-img {
          width: 180px;
          height: 180px;
          border-radius: 50%;
          object-fit: cover;
          border: 5px solid var(--primary-color);
          margin-bottom: 20px;
          box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
          transition: transform 0.3s, box-shadow 0.3s;
        }

        .profile-img:hover {
          transform: scale(1.05);
          box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4);
        }

        .profile-username {
          font-size: 32px;
          font-weight: 700;
          margin-bottom: 15px;
          text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        }

    /* Status Badges */
    .status-badge {
      display: inline-flex;
      align-items: center;
      padding: 8px 15px;
      border-radius: 30px;
      font-weight: 600;
      font-size: 14px;
      margin-bottom: 15px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
      transition: transform 0.3s;
    }

    .status-badge:hover {
      transform: translateY(-3px);
    }

    .status-badge i {
      margin-right: 8px;
    }

    .verified-badge {
      background: linear-gradient(135deg, #2ecc71, #27ae60);
      color: white;
    }

    .member-badge {
      background: linear-gradient(135deg, #9b59b6, #8e44ad);
      color: white;
    }

    /* Admin Badge Styling */
    .admin-badge {
      background: linear-gradient(135deg, #e74c3c, #c0392b);
      color: white;
      position: relative;
      overflow: hidden;
    }

    .admin-badge::before {
      content: '';
      position: absolute;
      top: -10px;
      right: -10px;
      width: 20px;
      height: 20px;
      background: rgba(255, 255, 255, 0.3);
      border-radius: 50%;
      animation: shine 2s infinite;
    }

    .admin-badge::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 2px;
      background: rgba(255, 255, 255, 0.5);
      animation: pulse 1.5s infinite;
    }

    @keyframes shine {
      0% {
        transform: scale(1);
        opacity: 0.5;
      }
      50% {
        transform: scale(1.5);
        opacity: 0.8;
      }
      100% {
        transform: scale(1);
        opacity: 0.5;
      }
    }

    @keyframes pulse {
      0% {
        opacity: 0.3;
      }
      50% {
        opacity: 0.8;
      }
      100% {
        opacity: 0.3;
      }
    }

    /* Bio Section */
    .bio-section {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 25px;
      margin-bottom: 40px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .bio-section:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
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

    /* Stats Section */
    .stats-section {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 25px;
      margin-bottom: 40px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      transition: transform 0.3s, box-shadow 0.3s;
    }

    .stats-section:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
      gap: 20px;
      margin-top: 20px;
    }

    .stat-item {
      background: rgba(26, 30, 37, 0.7);
      border-radius: 10px;
      padding: 15px;
      text-align: center;
      border: 1px solid rgba(255, 255, 255, 0.05);
      transition: transform 0.3s;
    }

    .stat-item:hover {
      transform: translateY(-5px);
    }

    .stat-icon {
      font-size: 24px;
      margin-bottom: 10px;
      display: inline-block;
      width: 50px;
      height: 50px;
      line-height: 50px;
      border-radius: 50%;
      background: rgba(52, 152, 219, 0.2);
      color: var(--primary-color);
    }

    .stat-value {
      font-size: 24px;
      font-weight: 700;
      margin-bottom: 5px;
    }

    .stat-label {
      font-size: 14px;
      color: var(--text-muted);
    }

    /* Watchlist Section */
    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .view-all {
      color: var(--primary-color);
      text-decoration: none;
      font-weight: 500;
      font-size: 14px;
      transition: all 0.3s;
      display: flex;
      align-items: center;
    }

    .view-all i {
      margin-left: 5px;
      font-size: 12px;
    }

    .view-all:hover {
      color: var(--primary-dark);
    }

    /* Watchlist Cards */
    .watchlist-card {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      overflow: hidden;
      transition: all 0.3s ease;
      height: 100%;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .watchlist-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      border-color: rgba(52, 152, 219, 0.3);
    }

    .watchlist-thumbnail {
      width: 100%;
      height: 150px;
      object-fit: cover;
      transition: all 0.5s;
    }

    .watchlist-card:hover .watchlist-thumbnail {
      transform: scale(1.05);
    }

    .watchlist-card-body {
      padding: 20px;
      background: rgba(26, 30, 37, 0.9);
    }

    .watchlist-card-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 15px;
      color: var(--text-light);
      text-align: center;
      padding: 8px;
      background: rgba(44, 62, 80, 0.5);
      border-radius: 6px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .provider-info {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
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

    .profile-image {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid var(--primary-color);
      margin-right: 10px;
    }

    .watchlist-card-text {
      font-size: 14px;
      color: var(--text-muted);
    }

    .watchlist-metadata {
      display: flex;
      flex-direction: column;
      gap: 5px;
      margin-bottom: 15px;
    }

    .views-counter {
      font-size: 14px;
      color: var(--text-muted);
      display: flex;
      align-items: center;
    }

    .views-counter i {
      margin-right: 5px;
      color: var(--primary-color);
    }

    .rating-container {
      display: flex;
      align-items: center;
    }

    .rating-container .text-warning {
      color: var(--warning) !important;
      margin-right: 5px;
    }

    .btn-group {
      display: flex;
      gap: 10px;
      justify-content: center;
    }

    .btn {
      padding: 8px 16px;
      font-weight: 500;
      border-radius: 6px;
      transition: all 0.3s;
    }

    .btn-outline-light {
      border: 1px solid rgba(255, 255, 255, 0.5);
      color: var(--text-light);
    }

    .btn-outline-light:hover {
      background-color: rgba(255, 255, 255, 0.1);
      border-color: var(--text-light);
    }

    .btn-primary {
      background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
      border: none;
    }

    .btn-primary:hover {
      background: linear-gradient(135deg, #2980b9 0%, #2573a7 100%);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
    }

    .btn-danger {
      background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
      border: none;
    }

    .btn-danger:hover {
      background: linear-gradient(135deg, #c0392b 0%, #a93226 100%);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
    }

    /* Private Content Card */
    .private-content-card {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 40px 20px;
      text-align: center;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }

    .private-content-card i {
      font-size: 48px;
      color: var(--text-muted);
      margin-bottom: 20px;
    }

    .private-content-card h5 {
      font-size: 20px;
      margin-bottom: 15px;
    }

    .private-content-card p {
      font-size: 16px;
      color: var(--text-muted);
      margin-bottom: 20px;
    }

    /* Empty Content Card */
    .empty-content-card {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.7) 0%, rgba(52, 73, 94, 0.7) 100%);
      border-radius: 12px;
      padding: 40px 20px;
      text-align: center;
      border: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
      margin-bottom: 50px;
    }

    .empty-content-card h5 {
      font-size: 20px;
      margin-bottom: 15px;
    }

    /* Swiper Customization */
    .swiper {
      padding-bottom: 40px !important;
    }

    .swiper-button-next,
    .swiper-button-prev {
      color: var(--primary-color) !important;
      background-color: rgba(26, 30, 37, 0.7);
      width: 40px !important;
      height: 40px !important;
      border-radius: 50%;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }

    .swiper-button-next:after,
    .swiper-button-prev:after {
      font-size: 20px !important;
    }

    /* Footer */
    .footer-section {
      background-color: rgba(26, 30, 37, 0.9);
      backdrop-filter: blur(10px);
      padding: 40px 0 20px;
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

    /* Modal Styles */
    .modal-content {
      background: linear-gradient(135deg, rgba(44, 62, 80, 0.95) 0%, rgba(52, 73, 94, 0.95) 100%);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 12px;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
    }

    .modal-header {
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      padding: 20px 25px;
    }

    .modal-title {
      font-weight: 600;
      color: var(--text-light);
    }

    .btn-close {
      filter: brightness(0) invert(1);
      opacity: 0.7;
    }

    .modal-body {
      padding: 25px;
    }

    .modal-footer {
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      padding: 20px 25px;
    }

    /* Responsive Adjustments */
    @media (max-width: 991px) {
      .stats-grid {
        grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
      }

      .profile-username {
        font-size: 28px;
      }

      .section-title {
        font-size: 22px;
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

      .profile-header {
        padding: 30px 0;
      }

      .profile-img {
        width: 140px;
        height: 140px;
      }

      .profile-username {
        font-size: 24px;
      }

      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
      }

      .section-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 10px;
      }

      .social-links a {
        width: 40px;
        height: 40px;
      }

      .social-links img {
        width: 20px;
        height: 20px;
      }

      .btn-group {
        flex-direction: column;
      }
    }

    @media (max-width: 575px) {
      .stats-grid {
        grid-template-columns: 1fr;
      }

      .profile-img {
        width: 120px;
        height: 120px;
      }
    }

    /* Settings Modal Styles */
    .settings-modal .modal-content {
      background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 15px;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      color: #ecf0f1;
      opacity: 1;
      backdrop-filter: none;
    }

    .settings-modal .modal-header {
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      padding: 20px 25px;
    }

    .settings-modal .modal-body {
      padding: 25px;
    }

    .settings-modal .modal-footer {
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      padding: 20px 25px;
    }

    .settings-modal .modal-title {
      font-weight: 600;
      color: #3498db;
    }

    .settings-modal .btn-close {
      color: #ecf0f1;
      filter: invert(1) brightness(200%);
    }

    /* Profile Image Section */
    .profile-image-section {
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .image-preview-wrapper {
      position: relative;
      width: 160px;
      height: 160px;
      border-radius: 50%;
      overflow: hidden;
      border: 3px solid #3498db;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .image-preview-wrapper:hover .profile-image-overlay {
      opacity: 1;
    }

    .profile-preview-img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s ease;
    }

    .image-preview-wrapper:hover .profile-preview-img {
      transform: scale(1.05);
    }

    .profile-image-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(52, 152, 219, 0.7);
      display: flex;
      justify-content: center;
      align-items: center;
      opacity: 0;
      transition: opacity 0.3s ease;
    }

    .profile-image-overlay i {
      font-size: 40px;
      color: white;
    }

    .upload-btn {
      background: linear-gradient(135deg, #3498db, #2980b9);
      border: none;
      transition: all 0.3s ease;
      padding: 8px 15px;
    }

    .upload-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .selected-file {
      font-size: 14px;
      color: #bdc3c7;
      font-style: italic;
      word-break: break-all;
      max-width: 100%;
    }

    /* Form Fields */
    .form-control {
      background-color: rgba(26, 30, 37, 0.7);
      border: 1px solid rgba(255, 255, 255, 0.1);
      color: #ecf0f1;
      border-radius: 8px;
      padding: 12px 15px;
      transition: all 0.3s;
    }

    .form-control:focus {
      background-color: rgba(26, 30, 37, 0.9);
      border-color: #3498db;
      box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
      color: #ecf0f1;
    }

    .form-control:disabled {
      background-color: rgba(44, 62, 80, 0.5);
      cursor: not-allowed;
    }

    .form-control::placeholder {
      color: #95a5a6;
      opacity: 1;
    }

    /* For older browsers */
    .form-control::-webkit-input-placeholder {
      color: #95a5a6;
      opacity: 1;
    }

    .form-control::-moz-placeholder {
      color: #95a5a6;
      opacity: 1;
    }

    .form-control:-ms-input-placeholder {
      color: #95a5a6;
      opacity: 1;
    }

    .form-text {
      color: #bdc3c7;
    }

    /* Privacy Section */
    .privacy-settings-section {
      background: linear-gradient(135deg, rgba(26, 30, 37, 0.5) 0%, rgba(44, 62, 80, 0.5) 100%);
      border-radius: 12px;
      padding: 20px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      margin-top: 20px;
    }

    .privacy-header {
      color: #3498db;
    }

    .form-check-input {
      background-color: rgba(44, 62, 80, 0.7);
      border-color: rgba(255, 255, 255, 0.2);
    }

    .form-check-input:checked {
      background-color: #3498db;
      border-color: #3498db;
    }

    /* Buttons */
    .btn-primary {
      background: linear-gradient(135deg, #3498db, #2980b9);
      border: none;
      transition: all 0.3s;
    }

    .btn-primary:hover {
      background: linear-gradient(135deg, #2980b9, #2573a7);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
    }

    .btn-secondary {
      background: rgba(44, 62, 80, 0.7);
      border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .btn-secondary:hover {
      background: rgba(52, 73, 94, 0.8);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    /* Responsive Adjustments */
    @media (max-width: 767px) {
      .image-preview-wrapper {
        width: 120px;
        height: 120px;
      }

      .profile-image-section {
        margin-bottom: 25px;
      }
    }

    .text-muted {
      color: white!important;
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
        <a href="/watchlists/watchlist-list">Watchlists library</a>
        <a href="/browse-anime">Browse Anime</a>
      </#if>
    </div>
  </div>

  <!-- Main Content -->
  <div class="content">
    <div class="container">
      <!-- Profile Header -->
      <div class="profile-header">
        <div class="profile-content">
          <img id="profileImage" src="${(user.profileImage)!'/pics/default-profile.jpg'}" alt="${user.username!''}" class="profile-img">
          <h1 class="profile-username">${user.username!''}</h1>

          <div class="d-flex justify-content-center align-items-center">
            <div class="status-badge verified-badge">
              <i class="fas fa-check-circle"></i> Verified
            </div>

            <#if user.roles?? && user.roles?seq_contains("ADMIN")>
              <div class="status-badge admin-badge ms-3">
                <i class="fas fa-crown"></i> Admin
              </div>
            <#else>
              <div class="status-badge member-badge ms-3">
                <i class="fas fa-user-shield"></i> Member
              </div>
            </#if>
          </div>

          <p class="mt-3 mb-0 text-muted">
            <i class="fas fa-calendar-alt"></i> Joined:
            <#if user.joinDate??>
              ${user.joinDate}
            <#else>
              <span>Unknown</span>
            </#if>
          </p>
        </div>
      </div>

      <!-- Bio Section -->
      <div class="bio-section">
        <h2 class="section-title">Bio</h2>
        <p><#if user.bio?has_content>${user.bio}<#else>No bio available yet.</#if></p>
      </div>

      <!-- Statistics Section -->
      <div class="stats-section">
        <h2 class="section-title">Statistics</h2>

        <div class="stats-grid">
          <div class="stat-item">
            <div class="stat-icon">
              <i class="fas fa-bookmark"></i>
            </div>
            <div class="stat-value">${subscriptionCount!'0'}</div>
            <div class="stat-label">Subscribed Lists</div>
          </div>

          <div class="stat-item">
            <div class="stat-icon">
              <i class="fas fa-comment-dots"></i>
            </div>
            <div class="stat-value">${commentCount!'0'}</div>
            <div class="stat-label">Comments Made</div>
          </div>
        </div>
      </div>

      <!-- Subscribed Watchlists Section -->
      <div class="watchlist-section">
        <div class="section-header">
          <h2 class="section-title">Subscribed Watchlists</h2>
          <#if isOwnProfile?? && isOwnProfile>
            <a href="/user-profile/subscribed-watchlists" class="view-all">
              View all subscribed watchlists <i class="fas fa-chevron-right"></i>
            </a>
          <#elseif user.publicSubscribedWatchlists?? && user.publicSubscribedWatchlists>
            <a href="/user-profile/subscribed-watchlists?userId=${user.id}" class="view-all">
              View all subscribed watchlists <i class="fas fa-chevron-right"></i>
            </a>
          </#if>
        </div>

        <#if !(isOwnProfile?? && isOwnProfile) && !(user.publicSubscribedWatchlists?? && user.publicSubscribedWatchlists)>
          <div class="private-content-card mb-4">
            <i class="fas fa-lock"></i>
            <h5>Subscribed watchlists are private</h5>
            <p>${user.username!''} has chosen to keep their subscribed watchlists private.</p>
          </div>
        <#elseif !subscribedWatchlists?? || subscribedWatchlists?size == 0>
          <div class="empty-content-card">
            <h5>No subscribed watchlists yet</h5>
            <a href="/watchlists/watchlist-list" class="btn btn-primary mt-3">Explore Watchlists</a>
          </div>
        <#else>
          <!-- Subscribed Watchlist Slider -->
          <div class="swiper mySwiper3">
            <div class="swiper-wrapper">
              <!-- Loop through subscribed watchlists -->
              <#list subscribedWatchlists as watchlist>
                <div class="swiper-slide watchlist-item" data-keywords="${(watchlist.tags)!'general'}">
                  <div class="watchlist-card">
                    <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="Watchlist Thumbnail" class="watchlist-thumbnail" onerror="this.src='/pics/default-watchlist.jpg';">
                    <div class="watchlist-card-body">
                      <h5 class="watchlist-card-title">${watchlist.title}</h5>
                      <div class="provider-info">
                        <img src="${watchlist.avatar!'/pics/default-profile.jpg'}" alt="Profile Image" class="profile-image">
                        <p class="watchlist-card-text">By: <a href="/provider-profile/${watchlist.providerId}" class="text-light">${watchlist.providerUsername!''}</a></p>
                      </div>
                      <div class="watchlist-metadata">
                        <div class="views-counter">
                          <i class="fas fa-eye"></i> ${watchlist.views!'0'} views
                        </div>
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
                      <#if isOwnProfile?? && isOwnProfile>
                        <div class="btn-group">
                          <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">View list</a>
                          <button class="btn btn-danger unsubscribe-btn" data-watchlist-id="${watchlist.watchlistId}">Unsubscribe</button>
                        </div>
                      <#else>
                        <div class="btn-group">
                          <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-light">View list</a>
                        </div>
                      </#if>
                    </div>
                  </div>
                </div>
              </#list>
            </div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
          </div>
        </#if>
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

  <!-- User Settings Modal -->
  <#if isOwnProfile?? && isOwnProfile>
    <div class="modal fade settings-modal" id="settingsModal" tabindex="-1" aria-labelledby="settingsModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="settingsModalLabel">
              <i class="fas fa-cog me-2"></i>Profile Settings
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <div class="modal-body">
            <form action="/user-profile/update" method="post" enctype="multipart/form-data" id="profileSettingsForm">
              <!-- Include CSRF token if available -->
              <#if _csrf??>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
              </#if>

              <div class="row">
                <!-- Left Column - Profile Picture -->
                <div class="col-md-4 text-center mb-4 mb-md-0">
                  <div class="profile-image-section">
                    <div class="current-image-container mb-3">
                      <div class="image-preview-wrapper">
                        <img src="${(user.profileImage)!'/pics/default-profile.jpg'}" alt="Profile" id="profilePreview" class="profile-preview-img">
                        <div class="profile-image-overlay">
                          <i class="fas fa-camera"></i>
                        </div>
                      </div>
                    </div>

                    <div class="file-upload-container">
                      <button type="button" class="btn btn-primary btn-sm upload-btn" onclick="document.getElementById('profileImageInput').click();">
                        <i class="fas fa-upload me-1"></i> Upload Photo
                      </button>
                      <input type="file" class="d-none" id="profileImageInput" name="profileImage" accept="image/*" onchange="previewImage(this)">
                      <div class="selected-file mt-2" id="selectedFileName">No file selected</div>
                    </div>

                    <div class="file-requirements mt-2">
                      <small class="text-muted">Recommended: Square image, max 10MB</small>
                    </div>
                  </div>
                </div>

                <!-- Right Column - User Details -->
                <div class="col-md-8">
                  <div class="profile-details-section">
                    <!-- Username Field -->
                    <div class="form-group mb-4">
                      <label for="username" class="form-label fw-bold">
                        <i class="fas fa-user text-primary me-2"></i>Username
                      </label>
                      <input type="text" class="form-control" id="username" name="username" value="${user.username!''}" disabled>
                      <small class="form-text text-muted">Username cannot be changed</small>
                    </div>

                    <!-- Bio Field -->
                    <div class="form-group mb-4">
                      <label for="bio" class="form-label fw-bold">
                        <i class="fas fa-edit text-primary me-2"></i>Bio
                      </label>
                      <textarea class="form-control" id="bio" name="bio" rows="4" placeholder="Tell others about yourself...">${user.bio!''}</textarea>
                    </div>

                    <!-- Privacy Settings -->
                    <div class="privacy-settings-section">
                      <div class="privacy-header d-flex align-items-center mb-3">
                        <i class="fas fa-lock text-primary me-2"></i>
                        <h6 class="mb-0 fw-bold">Privacy Settings</h6>
                      </div>

                      <div class="privacy-options">
                        <div class="form-check form-switch mb-3">
                          <input class="form-check-input" type="checkbox" id="publicSubscribedWatchlists" name="publicSubscribedWatchlists" ${user.publicSubscribedWatchlists?string('checked', '')}>
                          <label class="form-check-label" for="publicSubscribedWatchlists">
                            Show my subscribed watchlists to everyone
                          </label>
                        </div>

                        <div class="privacy-notice mt-2">
                          <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i>
                            Unchecking this will make your watchlist data private.
                          </small>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="modal-footer mt-4">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                  <i class="fas fa-times me-2"></i>Cancel
                </button>
                <button type="submit" class="btn btn-primary" id="saveChangesBtn">
                  <i class="fas fa-save me-2"></i>Save Changes
                  <span class="spinner-border spinner-border-sm d-none" id="saveSpinner"></span>
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </#if>

    <script>
    function previewImage(input) {
                    const preview = document.getElementById('profileImage');
                    const fileNameDisplay = document.getElementById('filename-display');

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


  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
  <script src="/js/main.js"></script>

  <script>
    function previewImage(input) {
      console.log("previewImage function called");
      const preview = document.getElementById('profilePreview');
      const fileNameDisplay = document.getElementById('selectedFileName');

      console.log("Preview element:", preview);
      console.log("Filename display element:", fileNameDisplay);

      if (input.files && input.files[0]) {
        const file = input.files[0];
        console.log("File selected:", file.name);

        // Update file name display
        if (fileNameDisplay) {
          fileNameDisplay.textContent = file.name.length > 25 ?
            file.name.substring(0, 22) + '...' : file.name;
          console.log("Updated filename display to:", fileNameDisplay.textContent);
        } else {
          console.error("Could not find selectedFileName element");
        }

        // Update image preview
        const reader = new FileReader();
        reader.onload = function(e) {
          preview.src = e.target.result;
          console.log("Image preview updated");
        }
        reader.readAsDataURL(file);
      } else {
        console.log("No file selected");
        if (fileNameDisplay) {
          fileNameDisplay.textContent = 'No file selected';
        }
      }
    }

    // Document ready function
    document.addEventListener('DOMContentLoaded', function() {
      // Add click handler for the profile image to trigger file input
      const imageWrapper = document.querySelector('.image-preview-wrapper');
      const fileInput = document.getElementById('profileImageInput');

      if (imageWrapper && fileInput) {
        console.log("Adding click event to image wrapper");
        imageWrapper.addEventListener('click', function() {
          console.log("Image wrapper clicked");
          fileInput.click();
        });
      }

      // Show loading spinner when form is submitted
      const form = document.getElementById('profileSettingsForm');
      const saveBtn = document.getElementById('saveChangesBtn');
      const spinner = document.getElementById('saveSpinner');

      if (form && saveBtn && spinner) {
        console.log("Adding submit event to form");
        form.addEventListener('submit', function() {
          console.log("Form submitted");
          saveBtn.disabled = true;
          spinner.classList.remove('d-none');
          saveBtn.querySelector('i').classList.add('d-none');
        });
      }

      // Handle unsubscribe buttons
      const unsubscribeButtons = document.querySelectorAll('.unsubscribe-btn');
      unsubscribeButtons.forEach(button => {
        button.addEventListener('click', function() {
          const watchlistId = this.getAttribute('data-watchlist-id');

          fetch('/api/subscriptions/unsubscribe/' + watchlistId, {
            method: 'POST'
          })
          .then(response => {
            if (response.ok) {
              // Find the parent slide
              const slide = this.closest('.swiper-slide');

              // Get the swiper instance
              const swiperInstance = subscribedWatchlistsSwiper;

              // Remove the slide
              if (slide && swiperInstance) {
                swiperInstance.removeSlide(Array.from(slide.parentNode.children).indexOf(slide));
                swiperInstance.update();
              }

              // Show a success message
              const successToast = document.createElement('div');
              successToast.classList.add('toast', 'align-items-center', 'text-bg-success', 'border-0', 'position-fixed', 'top-0', 'end-0', 'mt-3', 'me-3');
              successToast.setAttribute('role', 'alert');
              successToast.setAttribute('aria-live', 'assertive');
              successToast.setAttribute('aria-atomic', 'true');
              successToast.innerHTML = `
                <div class="d-flex">
                  <div class="toast-body">
                    Successfully unsubscribed from watchlist
                  </div>
                  <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
              `;
              document.body.appendChild(successToast);

              const bsToast = new bootstrap.Toast(successToast);
              bsToast.show();

              successToast.addEventListener('hidden.bs.toast', function() {
                successToast.remove();
              });
            }
          })
          .catch(error => {
            console.error('Error unsubscribing:', error);
            alert('Failed to unsubscribe. Please try again.');
          });
        });
      });

      // Animate elements on scroll
      const animateOnScroll = function() {
        const elements = document.querySelectorAll('.bio-section, .stats-section, .watchlist-section, .stat-item, .watchlist-card');

        elements.forEach(element => {
          const elementPosition = element.getBoundingClientRect().top;
          const screenPosition = window.innerHeight / 1.2;

          if (elementPosition < screenPosition) {
            element.style.opacity = '1';
            element.style.transform = element.classList.contains('watchlist-card') ? 'translateY(0)' : element.style.transform;
          }
        });
      };

      // Set initial styles for animation
      document.querySelectorAll('.bio-section, .stats-section, .watchlist-section').forEach(element => {
        element.style.opacity = '0';
        element.style.transition = 'opacity 0.8s ease-out, transform 0.8s ease-out';
      });

      // Run once on load
      setTimeout(animateOnScroll, 300);

      // Add scroll event listener
      window.addEventListener('scroll', animateOnScroll);
    });
  </script>
</body>
</html>