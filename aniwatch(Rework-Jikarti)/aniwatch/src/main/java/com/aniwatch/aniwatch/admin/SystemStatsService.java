package com.aniwatch.aniwatch.admin;

import com.aniwatch.aniwatch.comment.CommentRepository;
import com.aniwatch.aniwatch.provider.ProviderRepository;
import com.aniwatch.aniwatch.subscription.SubscriptionRepository;
import com.aniwatch.aniwatch.user.UserRepository;
import com.aniwatch.aniwatch.watchlist.WatchlistRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class SystemStatsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProviderRepository providerRepository;

    @Autowired
    private WatchlistRepository watchlistRepository;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    public SystemStats getSystemStats() {
        SystemStats stats = new SystemStats();

        // Set current counts
        stats.setTotalUsers((int) userRepository.count());
        stats.setTotalProviders((int) providerRepository.count());
        stats.setTotalWatchlists((int) watchlistRepository.count());
        stats.setTotalComments((int) commentRepository.count());

        // All placeholder values for now
        stats.setNewUsersLast24Hours(5);
        stats.setNewWatchlistsLast24Hours(8);
        stats.setCommentsLast24Hours(15);

        stats.setNewUsersLastWeek(24);
        stats.setNewWatchlistsLastWeek(32);
        stats.setCommentsLastWeek(120);

        return stats;
    }
}