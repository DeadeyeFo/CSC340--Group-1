package com.aniwatch.aniwatch.anime;

import jakarta.persistence.*;

@Entity
@Table(name = "anime")
public class Anime {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "mal_id", unique = true, nullable = false)
    private Long externalId;             // the Jikan mal_id

    @Column(nullable = false)
    private String title;

    private String alternateTitle;

    private String imageUrl;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAlternateTitle() {
        return alternateTitle;
    }

    public void setAlternateTitle(String alternateTitle) {
        this.alternateTitle = alternateTitle;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
        // getters & setters
        public Long getExternalId() { return externalId; }
        public void setExternalId(Long externalId) { this.externalId = externalId; }
}