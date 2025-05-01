package com.aniwatch.aniwatch.watchlist;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WatchlistAnimeRepository extends JpaRepository<WatchlistAnime, WatchlistAnime.WatchlistAnimeId> {
    List<WatchlistAnime> findByIdWatchlistId(Long watchlistId);
    List<WatchlistAnime> findByIdAnimeId(Long animeId);

    void deleteByIdWatchlistId(Long watchlistId);
    void deleteByIdWatchlistIdAndIdAnimeId(Long watchlistId, Long animeId);
    boolean existsByIdWatchlistIdAndIdAnimeId(Long watchlistId, Long animeId);

    // Count the number of anime in a watchlist
    long countByIdWatchlistId(Long watchlistId);

    // Get the anime IDs in a watchlist
    @Query("SELECT wa.id.animeId FROM WatchlistAnime wa WHERE wa.id.watchlistId = :watchlistId ORDER BY wa.displayOrder ASC")
    List<Long> findAnimeIdsByWatchlistId(@Param("watchlistId") Long watchlistId);
}