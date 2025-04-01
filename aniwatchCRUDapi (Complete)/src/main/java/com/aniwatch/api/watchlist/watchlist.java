package com.aniwatch.api.watchlist;

import jakarta.persistence.*;

@Entity
@Table(name = "watch-lists")
public class watchlist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    Integer watchlistId;

    @Column
    String watchlistName;

    @Column
    String watchlistDescription;

    public watchlist(){}

    public watchlist(Integer watchlistId, String watchlistName, String watchlistDescription){
        this.watchlistId = watchlistId;
        this.watchlistName = watchlistName;
        this.watchlistDescription = watchlistDescription;
    }

    public Integer getWatchlistId() {
        return watchlistId;
    }

    public void setWatchlistId(Integer watchlistId) {
        this.watchlistId = watchlistId;
    }

    public String getWatchlistName() {
        return watchlistName;
    }

    public void setWatchlistName(String watchlistName) {
        this.watchlistName = watchlistName;
    }

    public String getWatchlistDescription() {
        return watchlistDescription;
    }

    public void setWatchlistDescription(String watchlistDescription) {
        this.watchlistDescription = watchlistDescription;
    }
}
