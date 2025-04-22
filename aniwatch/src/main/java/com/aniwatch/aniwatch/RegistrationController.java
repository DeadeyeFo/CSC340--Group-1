package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/register")
public class RegistrationController {

    @Autowired
    private ProviderService providerService;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping("/provider")
    public String showProviderRegistrationForm(Model model) {
        model.addAttribute("provider", new Provider());
        return "register-provider";
    }

    @PostMapping("/provider")
    public String registerProvider(
            @ModelAttribute Provider provider,
            @RequestParam String password,
            @RequestParam(required = false) MultipartFile profileImage,
            RedirectAttributes redirectAttributes) {

        try {
            System.out.println("Starting provider registration for username: " + provider.getProviderUsername());
            // Create and save the provider
            Long providerId = providerService.createProvider(provider, profileImage);
            System.out.println("Provider created with the ID: " + providerId);

            // Create user with provider role
            User user = userService.registerProviderUser(provider.getProviderUsername(), password, providerId);
            System.out.println("User created with the ID: " + user.getId());

            return "redirect:/login?registered";
        } catch (Exception e) {
            System.err.println("Oh no, I encountered an error during provider registration: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Registration failed: " + e.getMessage());
            return "redirect:/register/provider";
        }
    }

    @GetMapping("/user")
    public String showUserRegistrationForm(Model model) {
        return "register-user";
    }

    @PostMapping("/user")
    public String registerUser(
            @RequestParam String username,
            @RequestParam String password,
            RedirectAttributes redirectAttributes) {

        try {
            System.out.println("Starting user registration for the username: " + username);

            // Create user with USER role
            User user = userService.registerRegularUser(username, password);
            System.out.println("User created with the ID: " + user.getId());

            return "redirect:/login?registered";
        } catch (Exception e) {
            System.err.println("Error during user registration: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/register/user";
        }
    }
}