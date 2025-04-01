package com.aniwatch.api.watchlist;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface watchlistRepository extends JpaRepository<watchlist, Integer> {
    List<watchlist> getWatchlistByWatchlistName(String watchlistName);
    List<watchlist> getWatchlistByWatchlistDescription(String watchlistDescription);
}
