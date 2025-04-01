package com.aniwatch.api.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/")
public class userController {

    @Autowired
    private userService userService;

    /**
     * Get a list of all users in the database.
     * Endpoint: http://localhost:8080/users/all
     *
     * @return a list of users.
     */
    @GetMapping("users/all")
    public Object getAllUsers() {
        return new ResponseEntity<>(userService.getAllUsers(), HttpStatus.OK);
    }

    /**
     * Set a user's status by id.
     * Endpoint: http://localhost:8080/users/status/{id}
     * @param User
     * @param id
     * @return a user object with the updated status.
     */
    @PutMapping("users/status/{id}")
    public Object setUserStatusById(@RequestBody user User, @PathVariable Integer id){
        userService.setUserStatusById(User, id);
        return new ResponseEntity<>(userService.getUserById(id), HttpStatus.OK);
    }

    /**
     * Get a user by id.
     * Endpoint: http://localhost:8080/users/{id}
     * @param id
     * @return a user object.
     */
    @GetMapping("users/{id}")
    public Object getUserById(@PathVariable Integer id) {
        return new ResponseEntity<>(userService.getUserById(id), HttpStatus.OK);
    }

    /**
     * This could also be a request param search instead of a path variable.
     * Get a user by username.
     * Endpoint: http://localhost:8080/users/{username}
     * @param username
     * @return a user object.
     */
    @GetMapping("users/{username}")
    public Object getUserByUsername(@PathVariable String username) {
        return new ResponseEntity<>(userService.getUserByUsername(username), HttpStatus.OK);
    }

    /**
     * Create a new user.
     * Endpoint: http://localhost:8080/users/create
     * @param User
     * @return a user object.
     */
    @PostMapping("users/create")
    public Object createUser(@RequestBody user User) {
        userService.createUser(User);
        return new ResponseEntity<>(userService.getUserByUsername(User.getUsername()), HttpStatus.CREATED);
    }

    /**
     * Update a user by id.
     * Endpoint: http://localhost:8080/users/update/{id}
     * @param User
     * @param id
     * @return a user object.
     */
    @PutMapping("users/update/{id}")
    public Object updateUserById(@RequestBody user User, @PathVariable Integer id) {
        userService.updateUserById(User, id);
        return new ResponseEntity<>(userService.getUserById(id), HttpStatus.OK);
    }

    /**
     * Delete a user by id.
     * Endpoint: http://localhost:8080/users/delete/{id}
     * @param id
     * @return a message indicating the user was deleted.
     */
    @DeleteMapping("users/delete/{id}")
    public Object deleteUserById(@PathVariable Integer id) {
        userService.deleteUserById(id);
        return new ResponseEntity<>("User with id " + id + " deleted", HttpStatus.OK);
    }

    /**
     * Delete all users.
     * Endpoint: http://localhost:8080/users/delete/all
     * @return a message indicating all users were deleted.
     */
    @DeleteMapping("users/delete/all")
    public Object deleteAllUsers() {
        userService.deleteAllUsers();
        return new ResponseEntity<>("All users deleted", HttpStatus.OK);
    }



}

