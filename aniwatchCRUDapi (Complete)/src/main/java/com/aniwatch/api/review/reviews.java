package com.aniwatch.api.review;

import com.aniwatch.api.wl_storage.WL_storage;
import jakarta.persistence.*;
import com.aniwatch.api.user.user;

@Entity
@Table(name = "reviews")
public class reviews {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer reviewId;

    @Column
    String description;

    @Column
    Integer starRating;

    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "userId")
    private user user;

    @OneToOne
    @JoinColumn(name = "wl_storage_id", referencedColumnName = "wl_Id")
    private WL_storage wl_storage;

    public reviews(){};

    public Integer getReviewId() {
        return reviewId;
    }

    public String getDescription() {
        return description;
    }

    public Integer getStarRating() {
        return starRating;
    }

    public user getUser() {
        return user;
    }

    public WL_storage getWl_storage() {
        return wl_storage;
    }


    public void setReviewId(Integer reviewId) {
        this.reviewId = reviewId;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStarRating(Integer starRating) {
        this.starRating = starRating;
    }

    public void setUser(user user) {
        this.user = user;
    }

    public void setWl_storage(WL_storage wl_storage) {
        this.wl_storage = wl_storage;
    }
}
