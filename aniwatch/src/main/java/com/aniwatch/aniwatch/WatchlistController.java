package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/watchlists")
public class WatchlistController {

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private UserService userService;

    @GetMapping("/{watchlistId}")
    public String getWatchlist(@PathVariable Long watchlistId, Model model) {
        watchlistService.incrementWatchlistViews(watchlistId);
        Watchlist watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);
        model.addAttribute("watchlistId", watchlist.getWatchlistId());
        model.addAttribute("title", watchlist.getTitle());
        model.addAttribute("description", watchlist.getDescription());
        model.addAttribute("username", watchlist.getProviderUsername());
        model.addAttribute("avatar", watchlist.getAvatar());
        model.addAttribute("views", watchlist.getViews());
        model.addAttribute("rating", watchlist.getRating() != null ?
                String.format("%.1f", watchlist.getRating()) : "0.0");        model.addAttribute("ratingStars", getRatingStars(watchlist.getRating()));
        model.addAttribute("comments", watchlist.getComments());
        // Placeholder user data; will replace with actual authentication logic soon
        model.addAttribute("userId", 1L);
        model.addAttribute("currentUser", "DeadeyeFo");
        model.addAttribute("userAvatar", "/pics/DeadeyeFo.png");
        return "watchlist";
    }

    @GetMapping ("/watchlist-list")
    public String listWatchlists(Model model) {
        List<Watchlist> watchlists = watchlistService.getAllWatchlists();
        model.addAttribute("watchlists", watchlists);

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
        return "watchlist-list";
    }

    @GetMapping("/new")
    public String showCreateWatchlistForm(Model model) {
        Watchlist watchlist = new Watchlist();

        // Set some default values for a watchlist for now
        watchlist.setProviderId(0L);
        watchlist.setProviderUsername("DeadeyeFo");
        watchlist.setAvatar("/pics/DeadeyeFo.png");
        watchlist.setRating(0.0);

        model.addAttribute("watchlist", watchlist);
        model.addAttribute("providerId", 0L);

        return "create-watchlist";
    }

    @PostMapping("/create")
    public String createWatchlist(@ModelAttribute Watchlist watchlist,
                                  @RequestParam("thumbnailFile") MultipartFile thumbnailFile) {

        if (watchlist.getProviderId() == null) {
            watchlist.setProviderId(0L);
        }
        if (watchlist.getProviderUsername() == null) {
            watchlist.setProviderUsername("DeadeyeFo");
        }
        watchlist.setAvatar("/pics/DeadeyeFo.png");
        watchlist.setRating(0.0);

        if (!thumbnailFile.isEmpty()) {
            try {
                String uploadDir = "src/main/resources/static/uploads/watchlists";
                Path uploadPath = Paths.get(uploadDir);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                String filename = UUID.randomUUID().toString() + "_" + thumbnailFile.getOriginalFilename();
                Path filePath = uploadPath.resolve(filename);

                Files.copy(thumbnailFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                watchlist.setThumbnail("/uploads/watchlists/" + filename);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            watchlist.setThumbnail("/pics/default-watchlist.jpg");
        }

        watchlistService.createWatchlist(watchlist);
        return "redirect:/watchlists/watchlist-list";
    }

    private String getRatingStars(Double rating) {
        if (rating == null) return "☆☆☆☆☆";
        int stars = (int) Math.round(rating);
        return "★".repeat(stars) + "☆".repeat(5 - stars);
    }

    @PostMapping("/{watchlistId}/rate")
    @ResponseBody
    public Watchlist rateWatchlist(@PathVariable Long watchlistId, @RequestParam Integer rating) {
        Watchlist watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);

        Double currentRating = watchlist.getRating() != null ? watchlist.getRating() : 0.0;
        int numRatings = watchlist.getNumRatings() != null ? watchlist.getNumRatings() : 0;

        double newRating = ((currentRating * numRatings) + rating) / (numRatings + 1);
        watchlist.setRating(newRating);
        watchlist.setNumRatings(numRatings + 1);

        return watchlistService.updateWatchlist(watchlist);
    }
}


