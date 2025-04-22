<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AniWatch - ${title}</title>
    <link rel="stylesheet" href="/css/create-service.css">
    <link href="https://fonts.googleapis.com/css2?family=Anton+SC&family=Press+Start+2P&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    .modal {
     background: linear-gradient(to bottom, rgba(64, 64, 64, 0.7), rgba(5, 5, 5, 0.5));
    }

    .views-stat {
        margin-top: 5px;
        margin-left: 5px;
        display: inline-flex;
        align-items: center;
        padding: 5px 10px;
        background-color: rgba(0, 0, 0, 0.2);
        border-radius: 20px;
        margin-right: 10px;
    }

    .views-stat i {
        margin-right: 5px;
        color: #6c9fff;
    }
</style>
<body class="bg-dark text-light">
    <!-- Top Navigation Bar -->
    <div class="topnav">
        <a href="/home" class="logo-link">
            <h1 class="logo">AniWatch</h1>
        </a>
        <div class="nav-links">
            <a href="/watchlists/watchlist-list">Watchlist library</a>
            <a href="/provider-profile">Profile</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="content">
        <div class="container my-5">
            <h2 class="mb-4">${title}</h2>
            <div class="d-flex align-items-center mb-4">
                <a href="/customer/${username}-profile">
                    <img src="${avatar}" alt="Provider Icon" class="provider-icon">
                </a>
                <p class="mb-0">By: <a href="" class="text-light">${username}</a></p>
                <div class="rating mb-2">
                    <span class="five-star-rating text-warning" id="rateButton">${ratingStars}</span> (${rating}/5)
                </div>
    <span class="views-stat">
        <i class="fas fa-eye"></i> ${views!'0'} views
    </span>
            </div>

            <!-- Watchlist Description -->
            <div class="Description mb-4">
                <h5>Description</h5>
                <p>${description}</p>
            </div>

            <!-- Anime List (Static) -->
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Berserk.jpg" class="anime-card-img" alt="Berserk">
                        <div class="card-body">
                            <h5 class="card-title">Berserk</h5>
                            <p class="card-text">A dark fantasy epic of vengeance and fate.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Code-geass.jpg" class="anime-card-img" alt="Code Geass">
                        <div class="card-body">
                            <h5 class="card-title">Code Geass</h5>
                            <p class="card-text">A strategic rebellion against an empire.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Vinland-saga.jpg" class="anime-card-img" alt="Vinland Saga">
                        <div class="card-body">
                            <h5 class="card-title">Vinland Saga</h5>
                            <p class="card-text">A Viking tale of revenge and redemption.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Parasyte-the-maxim.jpg" class="anime-card-img" alt="Parasyte: The Maxim">
                        <div class="card-body">
                            <h5 class="card-title">Parasyte: The Maxim</h5>
                            <p class="card-text">A human-alien symbiosis thriller.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Bunguo-stray-dogs.jpg" class="anime-card-img" alt="Bunguo Stray Dogs">
                        <div class="card-body">
                            <h5 class="card-title">Bunguo Stray Dogs</h5>
                            <p class="card-text">Supernatural detectives inspired by literature.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Detective-conan.jpg" class="anime-card-img" alt="Detective Conan">
                        <div class="card-body">
                            <h5 class="card-title">Detective Conan</h5>
                            <p class="card-text">A young detective solving endless mysteries.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Tokyo-ravens.jpg" class="anime-card-img" alt="Tokyo Ravens">
                        <div class="card-body">
                            <h5 class="card-title">Tokyo Ravens</h5>
                            <p class="card-text">Magic and spirits in modern Tokyo.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Baki.jpg" class="anime-card-img" alt="Baki">
                        <div class="card-body">
                            <h5 class="card-title">Baki</h5>
                            <p class="card-text">Brutal martial arts battles.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Trigun.jpg" class="anime-card-img" alt="Trigun">
                        <div class="card-body">
                            <h5 class="card-title">Trigun</h5>
                            <p class="card-text">A gunslinger’s journey in a desert world.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/cowboy-bebop.jpg" class="anime-card-img" alt="Cowboy Bebop">
                        <div class="card-body">
                            <h5 class="card-title">Cowboy Bebop</h5>
                            <p class="card-text">Space bounty hunters with style.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Soul-eater.jpg" class="anime-card-img" alt="Soul Eater">
                        <div class="card-body">
                            <h5 class="card-title">Soul Eater</h5>
                            <p class="card-text">Weapon and meister battles against evil.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-secondary text-light">
                        <img src="/pics/Darling-in-the-franxx.jpg" class="anime-card-img" alt="Darling in the FRANXX">
                        <div class="card-body">
                            <h5 class="card-title">Darling in the FRANXX</h5>
                            <p class="card-text">Mechs and emotions in a dystopian future.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="d-flex align-items-center mb-4">
        <i class="fas fa-comment me-2 mt-4"></i>
        <h5 class="comment-heading">Comment Section</h5>
    </div>

<script>
    const watchlistId = ${watchlistId?c}; // Use ?c to ensure numeric output
</script>

<div class="container my-5 py-5 text-body">
    <div class="row d-flex justify-content-center">
        <div class="col-md-12 col-lg-10 col-xl-9">
            <!-- Comment Input Section -->
            <div class="d-flex flex-start">
                <img class="rounded-circle shadow-1-strong" src="${userAvatar}" alt="avatar" width="65" height="65" />
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

            <!-- Comments Section -->
            <div id="commentSection">
            </div>
        </div>
    </div>
</div>

    <!-- Rating Modal -->
    <div id="ratingModal" class="modal">
        <div class="modal-content">
            <span class="close">×</span>
            <h2 class="rate-watchlist-text">Rate Watchlist</h2>
            <p class="rate-watchlist-subtext">Rate this watchlist (1 to 5 stars)</p>
            <form id="ratingForm">
                <fieldset class="star-rating">
                    <input type="radio" id="star5" name="rating" value="5" /><label for="star5" title="5 stars">☆</label>
                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="4 stars">☆</label>
                    <input type="radio" id="star3" name="rating" value="3" /><label for="star3" title="3 stars">☆</label>
                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="2 stars">☆</label>
                    <input type="radio" id="star1" name="rating" value="1" checked /><label for="star1" title="1 star">☆</label>
                </fieldset>
                <div id="ratingMessage" style="display: none; margin-top: 10px;"></div>
                <button type="submit" class="submit-btn">Submit Rating</button>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/comment-new.js"></script>
    <script src="/js/watchlist-rating-modal-n.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/emoji-mart@latest/dist/browser.js"></script>

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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>