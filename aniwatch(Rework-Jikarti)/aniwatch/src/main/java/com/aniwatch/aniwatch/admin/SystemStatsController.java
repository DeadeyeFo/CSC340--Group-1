package com.aniwatch.aniwatch.admin;

import com.aniwatch.aniwatch.comment.CommentRepository;
import com.aniwatch.aniwatch.provider.Provider;
import com.aniwatch.aniwatch.provider.ProviderService;
import com.aniwatch.aniwatch.user.User;
import com.aniwatch.aniwatch.user.UserService;
import com.aniwatch.aniwatch.watchlist.Watchlist;
import com.aniwatch.aniwatch.watchlist.WatchlistService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class SystemStatsController {

    @Autowired
    private SystemStatsService systemStatsService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProviderService providerService;

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private CommentRepository commentRepository;

    @GetMapping
    public String adminDashboard(Model model) {
        try {
            SystemStats stats = systemStatsService.getSystemStats();
            model.addAttribute("stats", stats);
            return "admin/dashboard";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading dashboard: " + e.getMessage());
            SystemStats defaultStats = new SystemStats();
            defaultStats.setTotalUsers(0);
            defaultStats.setTotalProviders(0);
            defaultStats.setTotalWatchlists(0);
            defaultStats.setTotalComments(0);
            defaultStats.setNewUsersLast24Hours(0);
            defaultStats.setNewWatchlistsLast24Hours(0);
            defaultStats.setCommentsLast24Hours(0);
            defaultStats.setNewUsersLastWeek(0);
            defaultStats.setNewWatchlistsLastWeek(0);
            defaultStats.setCommentsLastWeek(0);
            defaultStats.setLastUpdated(LocalDateTime.now());
            model.addAttribute("stats", defaultStats);
            return "admin/dashboard";
        }
    }

    @GetMapping("/users")
    public String manageUsers(Model model) {
        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/users";
    }

    @GetMapping("/providers")
    public String manageProviders(Model model) {
        List<Provider> providers = providerService.getAllProviders();
        model.addAttribute("providers", providers);
        return "admin/providers";
    }

    @GetMapping("/watchlists")
    public String manageWatchlists(Model model) {
        List<Watchlist> watchlists = watchlistService.getAllWatchlists();
        model.addAttribute("watchlists", watchlists);
        return "admin/watchlists";
    }

    @GetMapping("/content-filter")
    public String contentFilter(Model model) {
        // Placeholder for content filtering functionality, its bare-bones
        return "admin/content-filter";
    }

    @GetMapping("/server-logs")
    public String serverLogs(Model model) {
        // Placeholder for server logs functionality, its also the bare implementation
        return "admin/server-logs";
    }

    @PostMapping("/user/{id}/toggle-status")
    public String toggleUserStatus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findById(id)
                    .orElseThrow(() -> new RuntimeException("User not found with ID: " + id));

            user.setEnabled(!user.isEnabled());
            userService.saveUser(user);

            redirectAttributes.addFlashAttribute("success",
                    "User status updated to " + (user.isEnabled() ? "enabled" : "disabled"));
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating user status: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/provider/{id}/verify")
    public String toggleProviderVerification(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Provider provider = providerService.getProviderByProviderId(id);
            provider.setVerified(!provider.isVerified());
            providerService.saveProvider(provider);

            redirectAttributes.addFlashAttribute("success",
                    "Provider verification status updated to " + (provider.isVerified() ? "verified" : "unverified"));
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating provider verification: " + e.getMessage());
        }
        return "redirect:/admin/providers";
    }

    @PostMapping("/watchlist/{id}/delete")
    public String deleteWatchlist(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        
        try {
            System.out.println("🗑️  Admin deleteWatchlist called with id=" + id);
            watchlistService.deleteWatchlist(id);
            redirectAttributes.addFlashAttribute("success", "Watchlist deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting watchlist: " + e.getMessage());
        }
        return "redirect:/admin/watchlists";
    }
}