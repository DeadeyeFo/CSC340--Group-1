package com.aniwatch.api.provider;

import jakarta.persistence.*;

@Entity
@Table(name = "providers")
public class provider {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer providerId;

    @Column
    String bio;

    @Column
    String username;

    @Column
    String password;
    //profile pic

    public provider(){}

    public provider(Integer providerId, String username, String bio){
        this.providerId = providerId;
        this.username = username;
        this.bio = bio;
    }

    public int getUserId() {
        return providerId;
    }

    public void setProviderId(int providerId) {
        this.providerId = (Integer) providerId;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}