package com.aniwatch.api.user;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class user {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column
    Integer userId;

    @Column
    String name;

    @Column
    String bio;

    @Column
    String username;

    @Column
    String password;
    //profile pic

    @Column
    String accountStatus;

    public user(){}

    public user(String username, String password){
        this.username = username;
        this.password = password;
        this.accountStatus = "Active";
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getAccountStatus(){return accountStatus;}

    public void setAccountStatus(String accountStatus){this.accountStatus = accountStatus;}
}
