// Function to update background image for provider
function updateBackgroundImage() {
    let profileImg = document.getElementById("profileImage");
    let bgDiv = document.querySelector(".profile-background");

    if (profileImg && bgDiv) {
        let imageUrl = profileImg.src;
        bgDiv.style.backgroundImage = `url('${imageUrl}'), linear-gradient(to bottom, rgba(240, 240, 240, 0.8), rgba(255, 255, 255, 0))`;
    }
}

// Run function when page loads
window.onload = updateBackgroundImage;

// Listen for changes to the profile image
document.getElementById("profileImage").addEventListener("load", updateBackgroundImage);  
