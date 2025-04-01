package com.aniwatch.api.user;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface userRepository extends JpaRepository<user, Integer> {
    user findByUsername(String username); // Custom query method to find user by username
    List<user> findByBio(String bio); // Custom query method to find user by bio
    List<user> findByAccountStatus(String accountStatus); // Custom query method to find user by account status
    


}
