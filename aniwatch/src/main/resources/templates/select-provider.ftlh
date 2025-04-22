<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AniWatch - Select Provider</title>
  <link rel="stylesheet" href="/css/manage-profile.css">
  <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .provider-card {
      transition: transform 0.3s ease;
      margin-bottom: 20px;
    }
    .provider-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }
    .provider-img {
      height: 200px;
      object-fit: cover;
    }
    .add-provider-card {
      height: 350px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      border: 2px dashed #6c757d;
      background-color: rgba(108, 117, 125, 0.2);
      transition: all 0.3s ease;
    }
    .add-provider-card:hover {
      background-color: rgba(108, 117, 125, 0.3);
      transform: translateY(-5px);
    }
    .add-icon {
      font-size: 48px;
      margin-bottom: 15px;
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
    <a href="/browse-anime">Browse Anime</a>
    <a href="/watchlists">Public Watchlists</a>
  </div>
</div>

<div class="container my-5">
  <h1 class="mb-5 text-center">Select a Provider</h1>

  <#if errorMessage??>
    <div class="alert alert-danger" role="alert">
      ${errorMessage}
    </div>
  </#if>

  <div class="row">
    <!-- Add a new provider card -->
    <div class="col-md-4">
      <a href="/provider-profile/new" class="text-decoration-none">
        <div class="card bg-secondary text-light provider-card add-provider-card">
          <div class="card-body text-center py-5 mt-4">
            <div class="add-icon">+</div>
            <h5 class="card-title">Create New Provider</h5>
            <p class="card-text">Become an anime content creator</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Existing providers -->
    <#if providers?? && providers?size gt 0>
      <#list providers as provider>
        <div class="col-md-4">
          <div class="card bg-secondary text-light provider-card">
            <img src="${(provider.providerProfileImage)!'/pics/default-profile.png'}" class="card-img-top provider-img" alt="${provider.providerUsername!}">
            <div class="card-body">
              <h5 class="card-title">${provider.providerUsername!}</h5>
              <p class="card-text text-truncate">${provider.providerBio!}</p>
              <#if provider.verified?? && provider.verified>
                <span class="badge bg-primary mb-2"><i class="fas fa-check-circle"></i> Verified</span>
              </#if>
              <a href="/provider-profile?id=${provider.providerId}" class="btn btn-primary w-100 mt-2">View Profile</a>
            </div>
          </div>
        </div>
      </#list>
    <#else>
    <div class="col-md-4">
      <div class="card bg-secondary text-light provider-card add-provider-card">
        <div class="card-body text-center py-5 mt-5">
          <h5 class="card-title">No Providers Found</h5>
          <p class="card-text">Be the first to create a provider profile!</p>
          <a href="/provider-profile/new" class="btn btn-primary w-100 mt-2">Create Provider Profile</a>
        </div>
      </div>
    </div>
    </#if>
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

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>