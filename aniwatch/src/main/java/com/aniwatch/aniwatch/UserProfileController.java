package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class UserProfileController {

    @Autowired
    private UserService userService;

    @Autowired
    private ProviderService providerService;

    @Autowired
    private WatchlistService watchlistService;

    @GetMapping("/user-profile")
    public String userProfile(Model model) {
        // Get current authenticated user
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        // Get user information
        User user = userService.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        model.addAttribute("user", user);

        List<Watchlist> subscribedWatchlists = watchlistService.getSubscribedWatchlists(username);
        model.addAttribute("subscribedWatchlists", subscribedWatchlists);

        int subscriptionCount = subscribedWatchlists.size();
        model.addAttribute("subscriptionCount", subscriptionCount);

        // For nav bar securityConfig
        model.addAttribute("isAuthenticated", true);
        model.addAttribute("isOwnProfile", true);
        model.addAttribute("username", username);
        model.addAttribute("isProvider", false);

        return "user-profile";
    }

    @PostMapping("/user-profile/update")
    public String updateUserProfile(
            @RequestParam(required = false) String bio,
            @RequestParam(required = false) MultipartFile profileImage,
            RedirectAttributes redirectAttributes) {

        try {
            // Get current authenticated user
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();

            // Update user profile
            userService.updateUserProfile(username, bio, profileImage);

            redirectAttributes.addFlashAttribute("message", "Profile updated successfully");
            return "redirect:/user-profile";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating profile: " + e.getMessage());
            return "redirect:/user-profile";
        }
    }

    @GetMapping("/provider-profile/{providerId}")
    public String providerProfile(@PathVariable Long providerId, Model model) {
        try {
            Provider provider = providerService.getProviderByProviderId(providerId);
            model.addAttribute("provider", provider);

            List<Watchlist> watchlists = watchlistService.getWatchlistsByProviderId(providerId);
            model.addAttribute("watchlists", watchlists);

            ProviderStats stats = providerService.calculateProviderStats(providerId);
            model.addAttribute("stats", stats);

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            boolean isAuthenticated = authentication != null &&
                    authentication.isAuthenticated() &&
                    !authentication.getName().equals("anonymousUser");

            model.addAttribute("isAuthenticated", isAuthenticated);

            if (isAuthenticated) {
                String username = authentication.getName();
                model.addAttribute("username", username);

                boolean isProvider = userService.isProvider(username);
                model.addAttribute("isProvider", isProvider);

                // Check if the current user is the provider being viewed
                if (isProvider) {
                    Long currentProviderId = userService.getProviderId(username);
                    model.addAttribute("isOwnProfile", providerId.equals(currentProviderId));
                    model.addAttribute("providerId", currentProviderId);
                } else {
                    model.addAttribute("isOwnProfile", false);
                }
            }

            return "provider-profile";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading provider profile: " + e.getMessage());
            return "error"; // custom error template
        }
    }

    @PostMapping("/provider-profile/update")
    public String updateProviderProfile(
            @RequestParam(required = false) String username,
            @RequestParam(required = false) String bio,
            @RequestParam(required = false) MultipartFile profileImage,
            RedirectAttributes redirectAttributes) {

        try {
            // Get current authenticated user
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String currentUsername = authentication.getName();

            // Get provider ID for current user
            Long providerId = userService.getProviderId(currentUsername);

            if (providerId == null) {
                throw new RuntimeException("You are not a provider");
            }

            // Update provider profile
            providerService.updateProviderProfile(providerId, username, bio, profileImage);

            redirectAttributes.addFlashAttribute("message", "Profile updated successfully");
            return "redirect:/provider-profile/" + providerId;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error updating profile: " + e.getMessage());
            return "redirect:/provider-profile/" + userService.getProviderId(SecurityContextHolder.getContext().getAuthentication().getName());
        }
    }

    // User stats page, still in the works
    @GetMapping("/user-profile/stats")
    public String userStats(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        User user = userService.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        model.addAttribute("user", user);

        return "user-stats";
    }

    @GetMapping("/provider-profile/stats")
    public String providerStats(Model model) {
        // Get current authenticated user
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        boolean isProvider = userService.isProvider(username);
        if (!isProvider) {
            return "redirect:/user-profile";
        }

        Long providerId = userService.getProviderId(username);

        Provider provider = providerService.getProviderByProviderId(providerId);
        model.addAttribute("provider", provider);

        ProviderStats stats = providerService.calculateProviderStats(providerId);
        model.addAttribute("stats", stats);

        // Get all watchlists for this provider
        List<Watchlist> watchlists = watchlistService.getWatchlistsByProviderId(providerId);
        model.addAttribute("watchlists", watchlists);

        return "provider-stats";
    }
}