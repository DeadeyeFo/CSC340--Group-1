package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/login")
    public String login(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "registered", required = false) String registered,
            Model model) {

        if (error != null) {
            System.out.println("Oof Login error encountered");
            model.addAttribute("error", true);
        }

        if (registered != null) {
            System.out.println("User was registered successfully");
            model.addAttribute("registered", true);

            // Debug to console to check number of users in the database
            long userCount = userRepository.count();
            System.out.println("Total users in database: " + userCount);
        }

        return "login";
    }

    // Debug endpoint to see all users in the database, will remove later
    @GetMapping("/debug/users")
    public String debugUsers(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "debug-users";
    }
}