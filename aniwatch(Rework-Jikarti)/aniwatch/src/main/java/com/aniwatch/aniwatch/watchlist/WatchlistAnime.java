package com.aniwatch.aniwatch.watchlist;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "watchlist_anime")
public class WatchlistAnime {

    @EmbeddedId
    private WatchlistAnimeId id;

    @Column(name = "added_at")
    private LocalDateTime addedAt;

    @Column(name = "display_order")
    private Integer displayOrder;

    public WatchlistAnime() {
    }

    public WatchlistAnime(Long watchlistId, Long animeId) {
        this.id = new WatchlistAnimeId(watchlistId, animeId);
        this.addedAt = LocalDateTime.now();
    }

    public WatchlistAnimeId getId() {
        return id;
    }

    public void setId(WatchlistAnimeId id) {
        this.id = id;
    }

    public LocalDateTime getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(LocalDateTime addedAt) {
        this.addedAt = addedAt;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    // Composite key class
    @Embeddable
    public static class WatchlistAnimeId implements Serializable {

        @Column(name = "watchlist_id")
        private Long watchlistId;

        @Column(name = "anime_id")
        private Long animeId;

        public WatchlistAnimeId() {
        }

        public WatchlistAnimeId(Long watchlistId, Long animeId) {
            this.watchlistId = watchlistId;
            this.animeId = animeId;
        }

        // Getters and Setters
        public Long getWatchlistId() {
            return watchlistId;
        }

        public void setWatchlistId(Long watchlistId) {
            this.watchlistId = watchlistId;
        }

        public Long getAnimeId() {
            return animeId;
        }

        public void setAnimeId(Long animeId) {
            this.animeId = animeId;
        }

        // equals and hashCode methods
        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;

            WatchlistAnimeId that = (WatchlistAnimeId) o;

            if (!watchlistId.equals(that.watchlistId)) return false;
            return animeId.equals(that.animeId);
        }

        @Override
        public int hashCode() {
            int result = watchlistId.hashCode();
            result = 31 * result + animeId.hashCode();
            return result;
        }
    }
}