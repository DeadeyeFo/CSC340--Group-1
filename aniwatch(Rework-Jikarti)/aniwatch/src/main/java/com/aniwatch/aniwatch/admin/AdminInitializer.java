package com.aniwatch.aniwatch.admin;

import com.aniwatch.aniwatch.user.User;
import com.aniwatch.aniwatch.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Component
public class AdminInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        // This creates an admin user if it doesn't exist, use this to brute force creating admins
        // for the time being
        try {
            Optional<User> adminUser = userRepository.findByUsername("admin");

            if (adminUser.isEmpty()) {
                User admin = new User();
                admin.setUsername("admin");
                admin.setPassword(passwordEncoder.encode("adminPassword123"));
                admin.setEnabled(true);

                Set<String> roles = new HashSet<>();
                roles.add("ADMIN");
                admin.setRoles(roles);

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                admin.setJoinDate(LocalDateTime.now().format(formatter));
                admin.setProfileImage("/pics/default-profile.jpg");

                userRepository.save(admin);

                System.out.println("Admin user created successfully: admin/adminPassword123");
            } else {
                User existingAdmin = adminUser.get();

                // Ensure the admin user has the ADMIN role
                if (!existingAdmin.getRoles().contains("ADMIN")) {
                    Set<String> roles = existingAdmin.getRoles();
                    if (roles == null) {
                        roles = new HashSet<>();
                    }
                    roles.add("ADMIN");
                    existingAdmin.setRoles(roles);
                    userRepository.save(existingAdmin);
                    System.out.println("Added ADMIN role to existing admin user");
                } else {
                    System.out.println("Admin user already exists");
                }
            }
        } catch (Exception e) {
            System.err.println("Error initializing admin user: " + e.getMessage());
            e.printStackTrace();
        }
    }
}