package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class WatchlistService {

    @Autowired
    private WatchlistRepository watchlistRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    public List<Watchlist> getAllWatchlists() {
        return watchlistRepository.findAll();
    }

    public Watchlist getWatchlistByWatchlistId(Long watchlistId) {
        return watchlistRepository.findById(watchlistId)
                .orElseThrow(() -> new RuntimeException("Watchlist not found with ID: " + watchlistId));
    }

    public List<Watchlist> getWatchlistsByProviderId(Long providerId) {
        return watchlistRepository.findByProviderId(providerId);
    }

    public Watchlist createWatchlist(Watchlist watchlist) {
        return watchlistRepository.save(watchlist);
    }

    public Watchlist getOrCreateWatchlist(Long watchlistId, String defaultTitle, String defaultDescription) {
        Optional<Watchlist> existingWatchlist = watchlistRepository.findById(watchlistId);
        if (existingWatchlist.isPresent()) {
            return existingWatchlist.get();
        } else {
            Watchlist watchlist = new Watchlist();
            watchlist.setWatchlistId(watchlistId);
            watchlist.setTitle(defaultTitle);
            watchlist.setDescription(defaultDescription);
            return watchlistRepository.save(watchlist);
        }
    }

    public void incrementWatchlistViews(Long watchlistId) {
        Watchlist watchlist = getWatchlistByWatchlistId(watchlistId);

        Long currentViews = watchlist.getViews() != null ? watchlist.getViews() : 0L;
        watchlist.setViews(currentViews + 1);

        watchlistRepository.save(watchlist);
    }

    public List<Watchlist> getRandomWatchlists(int count) {
        List<Watchlist> allWatchlists = watchlistRepository.findAll();

        // If we have fewer watchlists than requested, return all of them
        if (allWatchlists.size() <= count) {
            return allWatchlists;
        }

        // Otherwise, select random ones
        Collections.shuffle(allWatchlists);
        return allWatchlists.subList(0, count);
    }

    public Watchlist updateWatchlist(Watchlist watchlist) {
        return watchlistRepository.save(watchlist);
    }

    public void deleteWatchlist(Long watchlistId) {
        watchlistRepository.deleteById(watchlistId);
    }

    public List<Watchlist> getRecentWatchlistsViewedByUser(String username) {
        // This would ideally come from a view history table, but im nt sure if im going to still use it
        // For now, i'll return a sample of watchlists as a placeholder

        List<Watchlist> allWatchlists = watchlistRepository.findAll();

        if (allWatchlists.isEmpty()) {
            return new ArrayList<>();
        }

        int numToReturn = Math.min(3, allWatchlists.size());
        return allWatchlists.subList(0, numToReturn);
    }

    public int getSubscriptionCountForUser(String username) {
        return 0;
    }


    public void trackWatchlistView(String username, Long watchlistId) {
        Watchlist watchlist = getWatchlistByWatchlistId(watchlistId);
        if (watchlist != null) {
            watchlist.setViews(watchlist.getViews() + 1);
            watchlistRepository.save(watchlist);
        }
    }


    @Transactional
    public void subscribeToWatchlist(String username, Long watchlistId) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));

        // Check if subscription already exists
        boolean exists = subscriptionRepository.existsByUserIdAndWatchlistId(user.getId(), watchlistId);
        if (exists) {
            return; // Already subscribed
        }

        // Create new subscription
        Subscription subscription = new Subscription();
        subscription.setUserId(user.getId());
        subscription.setWatchlistId(watchlistId);
        subscription.setSubscribedAt(LocalDateTime.now());

        subscriptionRepository.save(subscription);
    }

    @Transactional
    public void unsubscribeFromWatchlist(String username, Long watchlistId) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));

        subscriptionRepository.deleteByUserIdAndWatchlistId(user.getId(), watchlistId);
    }

    public boolean isSubscribed(String username, Long watchlistId) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));

        return subscriptionRepository.existsByUserIdAndWatchlistId(user.getId(), watchlistId);
    }

    public List<Watchlist> getSubscribedWatchlists(String username) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found: " + username));

        List<Subscription> subscriptions = subscriptionRepository.findByUserId(user.getId());
        List<Watchlist> subscribedWatchlists = new ArrayList<>();

        for (Subscription subscription : subscriptions) {
            try {
                Watchlist watchlist = getWatchlistByWatchlistId(subscription.getWatchlistId());
                subscribedWatchlists.add(watchlist);
            } catch (Exception e) {
                // if watchlist does not exist anymore, skip it
            }
        }

        return subscribedWatchlists;
    }

    public int getSubscriberCount(Long watchlistId) {
        return subscriptionRepository.findByWatchlistId(watchlistId).size();
    }
}
