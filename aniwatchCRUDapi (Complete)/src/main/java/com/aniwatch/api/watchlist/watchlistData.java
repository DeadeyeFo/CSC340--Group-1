package com.aniwatch.api.watchlist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class watchlistData {
    @Autowired
    private watchlistRepository watchlistRepository;

    /**
     * Get all watchlists.
     *
     * @return The list of all provider.
     */
    public List<watchlist> getAllWatchlist() {
        return watchlistRepository.findAll();
    }

    /**
     * Get a watchlist.
     *
     * @param watchlistId A wtchlist Id.
     * @return a watchlist object.
     */
    public watchlist getWatchlistByWatchlistId(int watchlistId) {
        return watchlistRepository.findById(Integer.valueOf(watchlistId)).orElse(null);
    }

    /**
     * Get all watchlists whose full watchlist description matches the search term.
     *
     * @param watchlistDescription the search key.
     * @return the list of matching watchlists.
     */
    public List<watchlist> getWatchlistByWatchlistDescription(String watchlistDescription) { // Optional: Rename method here too for consistency
        return watchlistRepository.getWatchlistByWatchlistDescription(watchlistDescription); // Use the NEW repository method name
    }

    /**
     * Get all watchlists with a name that contains the given string.
     *
     * @param watchlistName the search name
     * @return list of matching watchlists
     */
    public List<watchlist> getWatchlistByWatchlistName(String watchlistName) {
        return watchlistRepository.getWatchlistByWatchlistName(watchlistName);
    }

    /**
     * Add a new watchlist to the database.
     *
     * @param watchlist the new provider being added.
     */
    public void addNewWatchlist(watchlist watchlist) {
        watchlistRepository.save(watchlist);
    }

    /**
     * Update an existing watchlists data.
     *
     * @param watchlistId the watchlist ID.
     * @param watchlist the new watchlist details.
     */
    public void updateWatchlist(int watchlistId, watchlist watchlist) {
        watchlist existing = getWatchlistByWatchlistId(watchlistId);
        existing.setWatchlistName(watchlist.getWatchlistName());
        existing.setWatchlistDescription(watchlist.getWatchlistDescription());
        watchlistRepository.save(existing);
    }

    /**
     * Delete a watchlist.
     *
     * @param watchlistId the watchlist ID.
     */
    public void deleteWatchlistByWatchlistId(Integer watchlistId) {
        watchlistRepository.deleteById(watchlistId);
    }
}

