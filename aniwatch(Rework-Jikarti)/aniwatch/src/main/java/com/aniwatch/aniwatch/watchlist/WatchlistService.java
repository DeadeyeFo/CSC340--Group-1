package com.aniwatch.aniwatch.watchlist;

import com.aniwatch.aniwatch.anime.Anime;
import com.aniwatch.aniwatch.anime.AnimeRepository;
import com.aniwatch.aniwatch.comment.CommentRepository;
import com.aniwatch.aniwatch.subscription.*;
import com.aniwatch.aniwatch.user.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class WatchlistService {

    @Autowired
    private WatchlistRepository watchlistRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AnimeRepository animeRepository;

    @Autowired
    private WatchlistAnimeRepository watchlistAnimeRepository;

    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private CommentRepository commentRepository;

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

    @Transactional
    public void deleteWatchlist(Long watchlistId) {
        Watchlist watchlist = getWatchlistByWatchlistId(watchlistId);

        if (watchlist == null) {
            throw new RuntimeException("Watchlist not found with ID: " + watchlistId);
        }

        // Delete related records first (comments, subscriptions, anime associations, etc..)
        commentRepository.deleteByWatchlist_WatchlistId(watchlistId);
        subscriptionRepository.deleteByWatchlistId(watchlistId);
        watchlistAnimeRepository.deleteByIdWatchlistId(watchlistId);

        // Finally, delete the watchlist itself
        watchlistRepository.deleteById(watchlistId);
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

    public boolean isWatchlistOwner(Long watchlistId, String username) {
        Long providerId = userService.getProviderId(username);

        if (providerId == null) {
            return false;
        }

        Watchlist watchlist = watchlistRepository.findById(watchlistId)
                .orElse(null);

        if (watchlist == null) {
            return false;
        }

        // Check if the watchlist belongs to this provider
        return watchlist.getProviderId().equals(providerId);
    }

    /**
     * Add anime to a given watchlist
     */
    @Transactional
    public void addAnimeToWatchlist(Long watchlistId, List<Long> animeIds) {
        // Verify watchlist exists
        Watchlist watchlist = getWatchlistByWatchlistId(watchlistId);

        // Get current count to set display order
        int currentCount = (int) watchlistAnimeRepository.countByIdWatchlistId(watchlistId);

        for (int i = 0; i < animeIds.size(); i++) {
            Long animeId = animeIds.get(i);

            // Check if anime exists
            if (!animeRepository.existsById(animeId)) {
                continue; // Skip if the anime doesn't exist
            }

            // Create watchlist-anime association if it doesn't exist
            if (!watchlistAnimeRepository.existsByIdWatchlistIdAndIdAnimeId(watchlistId, animeId)) {
                WatchlistAnime watchlistAnime = new WatchlistAnime(watchlistId, animeId);
                watchlistAnime.setAddedAt(LocalDateTime.now());
                watchlistAnime.setDisplayOrder(currentCount + i);
                watchlistAnimeRepository.save(watchlistAnime);
            }
        }
    }

    /**
     * Remove anime from a given watchlist
     */
    @Transactional
    public void removeAnimeFromWatchlist(Long watchlistId, Long animeId) {
        watchlistAnimeRepository.deleteByIdWatchlistIdAndIdAnimeId(watchlistId, animeId);
    }

    /**
     * Remove all anime from a given watchlist
     */
    @Transactional
    public void removeAllAnimeFromWatchlist(Long watchlistId) {
        watchlistAnimeRepository.deleteByIdWatchlistId(watchlistId);
    }

    /**
     * Get all anime in a given watchlist
     */
    public List<Anime> getAnimeInWatchlist(Long watchlistId) {
        List<Long> animeIds = watchlistAnimeRepository.findAnimeIdsByWatchlistId(watchlistId);

        if (animeIds.isEmpty()) {
            return new ArrayList<>();
        }

        return animeRepository.findAllById(animeIds);
    }

    /**
     * This checks if an anime is in a given watchlist
     */
    public boolean isAnimeInWatchlist(Long watchlistId, Long animeId) {
        return watchlistAnimeRepository.existsByIdWatchlistIdAndIdAnimeId(watchlistId, animeId);
    }

    /**
     * Get the number of anime in a given watchlist
     */
    public long getAnimeCountInWatchlist(Long watchlistId) {
        return watchlistAnimeRepository.countByIdWatchlistId(watchlistId);
    }

    /**
     * This updates the display order of anime in a given watchlist
     */
    @Transactional
    public void updateAnimeOrder(Long watchlistId, List<Long> orderedAnimeIds) {
        for (int i = 0; i < orderedAnimeIds.size(); i++) {
            Long animeId = orderedAnimeIds.get(i);

            WatchlistAnime.WatchlistAnimeId id = new WatchlistAnime.WatchlistAnimeId(watchlistId, animeId);
            Optional<WatchlistAnime> watchlistAnimeOpt = watchlistAnimeRepository.findById(id);

            if (watchlistAnimeOpt.isPresent()) {
                WatchlistAnime watchlistAnime = watchlistAnimeOpt.get();
                watchlistAnime.setDisplayOrder(i);
                watchlistAnimeRepository.save(watchlistAnime);
            }
        }
    }
}