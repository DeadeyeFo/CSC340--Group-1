package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDate;
import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String redirectToHome() {
        return "redirect:/home";
    }

    @GetMapping("/home")
    public String home(Model model) {
        // This just gets a few random watchlists to display in home
        List<Watchlist> featuredWatchlists = watchlistService.getRandomWatchlists(4);

        model.addAttribute("featuredWatchlists", featuredWatchlists);

        // Add user attributes (I will replace with actual authentication later)
        addAuthInfoToModel(model);

        // Determine current season ;-)
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();

        String currentSeason;
        if (month >= 1 && month <= 3) {
            currentSeason = "Winter";
        } else if (month >= 4 && month <= 6) {
            currentSeason = "Spring";
        } else if (month >= 7 && month <= 9) {
            currentSeason = "Summer";
        } else {
            currentSeason = "Fall";
        }

        model.addAttribute("currentSeason", currentSeason);

        return "home";
    }

    private void addAuthInfoToModel(Model model) {
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

            if (isProvider) {
                Long providerId = userService.getProviderId(username);
                model.addAttribute("providerId", providerId);
            }
        }
    }
}