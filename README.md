## Title
> Anime/Manga Watchlist & Community (Aniwatch)

## Team Members
> Foday Mami, Abel Moran, Joshua Wusu,

## Description 
> Our application is an interactive platform designed for anime and manga enthusiasts to track their watchlists, discover new series, and engage with the community. Users can rate and review anime/manga, participate in discussions, and get personalized recommendations.
> 
> Motivation: The growing anime and manga fanbase lacks a centralized space for tracking, reviewing, and interacting with others beyond generic social media platforms. We also all enjoy anime and thought it would be good to work on a project we are passionate about!
> 
> Goals: Provide an easy-to-use watchlist tracker for anime and manga. Create a review and rating system to help users discover quality content. Offer a discussion platform where fans can engage in meaningful conversations. Allow content providers (reviewers, critics) to curate lists and interact with users.


## App Functions
1. Customer (the user with the customer role):
    1. Create/modify customer profile - Users can sign up, log in, and personalize their profiles with avatars, watchlists, and preferences.
    2. View available services - Users can browse anime/manga titles, view detailed information, and read reviews.
    3. Subscribe to available services - Users can follow favorite watchlists and subscribe to see changes and reviews for them.
    4. Write reviews for subscribed services - Users can rate anime/manga, write detailed reviews, and comment on other users' reviews.
2. Provider (the user with the provider role):
    1. Create/modify/remove provider profile - Content creators and reviewers can establish profiles to share recommendations and lists.
    2. Create services - Providers can create curated watchlists, post recommendations, and host discussions.
    3. View customer statistics - Providers can analyze user interactions, track engagement, and refine their content strategy.
    4. Reply to reviews - Providers can engage with users by responding to reviews, answering questions, and moderating discussions.
3. SysAdmin (the user with the admin role, if applicable):
    1. Manage user access - Admins can approve, suspend, or remove user accounts based on platform policies.
    2. Moderate services - Admins can ensure appropriate content is posted, remove inappropriate material, and verify provider authenticity.
    3. Moderate reviews - Admins can handle reported reviews, delete spam, and ensure a healthy discussion environment.
    4. View usage statistics - Admins can track platform engagement, monitor active users, and generate analytics reports.
  

## How to run the Project
> 1. **Import the database**  
>    – Ensure your database server is running (we used AMPPS/phpMyAdmin).  
>    – Import the provided `.sql` file from this repo into your database.  
>
> 2. **Start the application**  
>    – In your IDE, locate and run `AniwatchApplication.java`.  
>    – Once startup completes, visit [http://localhost:8080/home](http://localhost:8080/home) to see the homepage.  
>
> 3. **Default Accounts**  
>    - **USER**  
>      - Username: `billybob`  
>      - Password: `12345678`  
>    - **PROVIDER**  
>      - Username: `prov2`  
>      - Password: `12345678`  
>    - **ADMIN**  
>      - Username: `admin`  
>      - Password: `adminPassword123`  
>
> 4. **Admin Dashboard**  
>    – After logging in as **ADMIN**, navigate to [http://localhost:8080/admin](http://localhost:8080/admin).  
>    – Non‑admin users will be denied access to this page.  

