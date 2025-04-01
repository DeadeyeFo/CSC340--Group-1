package com.aniwatch.api.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class reviewService {

    @Autowired
    private reviewRepository reviewrepository;

    /**
     * Get a specific all reviews.
     *
     * @return all reviews.
     */
    public List<reviews> getAllReviews(){
        return reviewrepository.findAll();
    }

    /**
     * Get a review by id.
     *
     * @param id the id of the review.
     * @return the review object.
     */
    public reviews getReviewById(int id){
        return reviewrepository.findById(id).orElse(null);
}
    
    
        /**
        * Create a new review.
        *
        * @param review the review object to be created.
        * @return the created review object.
        */
        public reviews createReview(reviews review){
            return reviewrepository.save(review);
        }
    
        /**
        * Update a review by id.
        *
        * @param id the id of the review.
        * @param review the review object to be updated.
        * @return the updated review object.
        */
        public reviews updateReviewById(int id, reviews review){
            reviews existing = getReviewById(id);
            existing.setDescription(review.getDescription());
            existing.setStarRating(review.getStarRating());
    
            return reviewrepository.save(existing);
        }

        /**
        * Delete a review by id.
        *
        * @param id the id of the review.
        */
        public void deleteReviewById(int id){
            reviewrepository.deleteById(id);
        }
        
}