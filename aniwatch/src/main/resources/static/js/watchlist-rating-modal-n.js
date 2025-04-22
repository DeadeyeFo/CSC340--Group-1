const rateButton = document.getElementById("rateButton");
rateButton.onclick = openRatingModal;

const modal = document.getElementById("ratingModal");
const closeBtn = document.querySelector(".close");
const ratingForm = document.getElementById("ratingForm");
const ratingMessage = document.getElementById("ratingMessage");

function openRatingModal() {
    modal.style.display = "flex";
    ratingMessage.style.display = "none"; // To reset message
    ratingForm.reset(); // To reset form to 1 star
}

closeBtn.onclick = function () {
    modal.style.display = "none";
};

// This closes the modal when clicking outside the modal
window.onclick = function (event) {
    if (event.target === modal) {
        modal.style.display = "none";
    }
};

ratingForm.onsubmit = function (event) {
    event.preventDefault();
    const rating = document.querySelector('input[name="rating"]:checked').value;

    // This submits the rating to the server
    fetch(`/watchlists/${watchlistId}/rate`, {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
        },
        body: new URLSearchParams({
            rating: rating
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Network response was not ok");
        }
        return response.json();
    })
    .then(data => {
        const ratingStarsElement = document.querySelector('.five-star-rating');
        const ratingTextElement = document.querySelector('.rating');

        const stars = Math.round(data.rating);
        const starRating = "★".repeat(stars) + "☆".repeat(5 - stars);

        ratingStarsElement.textContent = starRating;
        ratingTextElement.innerHTML = `<span class="five-star-rating text-warning" id="rateButton">${starRating}</span> (${data.rating.toFixed(1)}/5)`;

        ratingMessage.style.display = "block";
        ratingMessage.style.color = "green";
        ratingMessage.textContent = `Thank you for rating this watchlist ${rating} star(s)!`;

        // Something extra to close the modal after a delay
        setTimeout(() => {
            modal.style.display = "none";
        }, 2000);
    })
    .catch(error => {
        console.error("Error submitting rating:", error);
        ratingMessage.style.display = "block";
        ratingMessage.style.color = "red";
        ratingMessage.textContent = "Error submitting rating. Please try again.";
    });
};