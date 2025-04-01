package com.aniwatch.api.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class reviewController {

    @Autowired
    private com.aniwatch.api.review.reviewService reviewService;

    //Gets all Reviews
    // Endpoint: http://localhost:8080/reviews/all
    // @return a list of all reviews.
    // @GetMapping("reviews/all")
    @GetMapping("reviews/all")
    public Object getAllReviews() {
        return new ResponseEntity<>(reviewService.getAllReviews(), HttpStatus.OK);
    }

    //Gets a review by id
    // Endpoint: http://localhost:8080/reviews/{id}
    // @param id the id of the review.
    // @return the review object with the specified id.
    // @GetMapping("reviews/{id}")
    @GetMapping("reviews/{id}")
    public Object getReviewById(Integer id) {
        return new ResponseEntity<>(reviewService.getReviewById(id), HttpStatus.OK);
    }

    //Creates a new review
    // Endpoint: http://localhost:8080/reviews/create
    // @param review the review object to be created.
    // @return the created review object.
    @PostMapping("reviews/create")
    public Object createReview(com.aniwatch.api.review.reviews review) {
        reviewService.createReview(review);
        return new ResponseEntity<>(review, HttpStatus.CREATED);
    }

    //Updates a review by id
    // Endpoint: http://localhost:8080/reviews/update/{id}
    // @param id the id of the review.
    // @param review the review object to be updated.
    // @return the updated review object.
    @PutMapping("reviews/update/{id}")
    public Object updateReviewById(Integer id, com.aniwatch.api.review.reviews review) {
        reviewService.updateReviewById(id, review);
        return new ResponseEntity<>(review, HttpStatus.OK);
    }
    

    //Deletes a review by id
    // Endpoint: http://localhost:8080/reviews/delete/{id}
    // @param id the id of the review.
    // @return the review object with the specified id.
    // @DeleteMapping("reviews/delete/{id}")
    @DeleteMapping("reviews/delete/{id}")
    public Object deleteReviewById(Integer id) {
        reviewService.deleteReviewById(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }



}

