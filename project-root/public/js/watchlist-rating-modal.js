// Link the button to open the modal
const rateButton = document.getElementById("rateButton");
rateButton.onclick = openRatingModal;

// Get modal elements
const modal = document.getElementById("ratingModal");
const closeBtn = document.querySelector(".close");
const ratingForm = document.getElementById("ratingForm");
const ratingMessage = document.getElementById("ratingMessage");

// Function to open the modal
function openRatingModal() {
    modal.style.display = "flex";
    ratingMessage.style.display = "none"; // Reset message
    ratingForm.reset(); // Reset form to default (1 star)
}

// Close the modal when the close button is clicked
closeBtn.onclick = function () {
    modal.style.display = "none";
};

// Close the modal when clicking outside the modal content
window.onclick = function (event) {
    if (event.target === modal) {
        modal.style.display = "none";
    }
};

// Handle form submission
ratingForm.onsubmit = function (event) {
    event.preventDefault();
    const rating = document.querySelector('input[name="rating"]:checked').value;
    // Example: Save to localStorage
    localStorage.setItem("watchlistItemRating", rating);
    ratingMessage.style.display = "block";
    ratingMessage.style.color = "green";
    ratingMessage.textContent = `Thank you for rating this item ${rating} star(s)!`;
    setTimeout(() => {
        modal.style.display = "none";
    }, 2000);
}; 
