package com.aniwatch.aniwatch;

import jakarta.persistence.*;

@Entity
@Table(name = "providers")
public class Provider {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long providerId;

    @Column(nullable = false, unique = true)
    private String providerUsername;

    @Column(columnDefinition = "TEXT")
    private String providerBio;

    private String providerEmail;

    private String providerProfileImage;

    private boolean verified = false;

    @Column
    private String createdAt;

    // Note to remember, user will reference Provider by ID, REMEMBER
    public Long getProviderId() {
        return providerId;
    }

    public void setProviderId(Long providerId) {
        this.providerId = providerId;
    }

    public String getProviderUsername() {
        return providerUsername;
    }

    public void setProviderUsername(String providerUsername) {
        this.providerUsername = providerUsername;
    }

    public String getProviderBio() {
        return providerBio;
    }

    public void setProviderBio(String providerBio) {
        this.providerBio = providerBio;
    }

    public String getProviderEmail() {
        return providerEmail;
    }

    public void setProviderEmail(String providerEmail) {
        this.providerEmail = providerEmail;
    }

    public String getProviderProfileImage() {
        return providerProfileImage;
    }

    public void setProviderProfileImage(String providerProfileImage) {
        this.providerProfileImage = providerProfileImage;
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}