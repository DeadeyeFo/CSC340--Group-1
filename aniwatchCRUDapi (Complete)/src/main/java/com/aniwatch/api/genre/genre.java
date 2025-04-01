package com.aniwatch.api.genre;


import com.aniwatch.api.animecard.animecard;
import jakarta.persistence.*;
import com.aniwatch.api.watchlist.watchlist;

@Entity
@Table(name = "genres")
public class genre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer genreId;

    @OneToOne
    @JoinColumn(name = "card_id", referencedColumnName = "cardId")
    private animecard animecard;

    @OneToOne
    @JoinColumn(name = "watchlist_id", referencedColumnName = "watchlistId")
    private watchlist watchlist;

    @Column
    String genreName;

    public genre() {}

    public genre(String genreName, animecard animecard, watchlist watchlist) {
        this.genreName = genreName;
        this.animecard = animecard;
        this.watchlist = watchlist;
    }

    public Integer getGenreId() {
        return genreId;
    }

    public void setGenreId(Integer genreId) {
        this.genreId = genreId;
    }

    public animecard getAnimecard() {
        return animecard;
    }

    public void setAnimecard(animecard animecard) {
        this.animecard = animecard;
    }

    public watchlist getWatchlist() {
        return watchlist;
    }

    public void setWatchlist(watchlist watchlist) {
        this.watchlist = watchlist;
    }

    public String getGenreName() {
        return genreName;
    }

    public void setGenreName(String genreName) {
        this.genreName = genreName;
    }
}
