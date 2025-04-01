package com.aniwatch.api.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class userService {

    @Autowired
    private userRepository userRepository;

    /**
     * Get all users in the database.
     * 
     * @return list of all users.
     */
    public List<user> getAllUsers(){
        return userRepository.findAll();
    }

    /**
     * Get a user by id.
     * 
     * @param id the id of the user.
     * @return the user object.
     */
    public user getUserById(int userId){
        return userRepository.findById(userId).orElse(null);
    }

    /**
     * Set a user's status by id.
     * 
     * @param User the user object with the new status.
     * @param id the id of the user.
     */
    public void setUserStatusById(user User, Integer userId){
        user existing = getUserById(userId);
        existing.setAccountStatus(User.getAccountStatus());

        userRepository.save(existing);
    }

    /**
     * Get a user by username.
     * 
     * @param username the username of the user.
     * @return the user object.
     */
    public user getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    /**
     * Create a new user.
     * 
     * @param User the user object to be created.
     * @return the created user object.
     */
    public user createUser(user User) {
        return userRepository.save(User);
    }

        /**
     * Update a user by id.
     * 
     * @param User the user object with the updated information.
     * @param id the id of the user to be updated.
     * @return the updated user object.
     */
    public user updateUserById(user User, int userId) {
        user existing = getUserById(userId);
        existing.setUsername(User.getUsername());
        existing.setPassword(User.getPassword());
        existing.setAccountStatus(User.getAccountStatus()); 
        existing.setBio(User.getBio());

        return userRepository.save(existing);
    }

    /**
     * Delete a user by id.
     * 
     * @param id the id of the user to be deleted.
     */
    public void deleteUserById(int id) {
        userRepository.deleteById(id);
    }

    /**
     * Delete all users.
     * 
     * 
     */
    public void deleteAllUsers() {
        userRepository.deleteAll();
    }






}
