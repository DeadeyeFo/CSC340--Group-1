package com.aniwatch.api.wl_storage;
import com.aniwatch.api.animecard.animecard;
import com.aniwatch.api.provider.provider;
import jakarta.persistence.*;
import com.aniwatch.api.user.user;
import com.aniwatch.api.watchlist.watchlist;

@Entity
@Table(name = "WL_Storage")
public class WL_storage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer wl_id;

    @OneToOne
    @JoinColumn(name = "provider_id", referencedColumnName = "providerId")
    private provider provider;

    @OneToOne
    @JoinColumn(name = "card_id", referencedColumnName = "cardId")
    private animecard animecard;

    @OneToOne
    @JoinColumn(name = "watchlist_id", referencedColumnName = "watchlistId")
    private watchlist watchlist;

    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "userId")
    private user user;

    public WL_storage(){}

    public Integer getWl_id() {
        return wl_id;
    }

    public provider getProvider() {
        return provider;
    }

    public animecard getAnimecard() {
        return animecard;
    }

    public watchlist getWatchlist() {
        return watchlist;
    }

    public user getUser() {
        return user;
    }

    // Setters
    public void setWl_id(Integer wl_id) {
        this.wl_id = wl_id;
    }

    public void setProvider(provider provider) {
        this.provider = provider;
    }

    public void setAnimecard(animecard animecard) {
        this.animecard = animecard;
    }

    public void setWatchlist(watchlist watchlist) {
        this.watchlist = watchlist;
    }

    public void setUser(user user) {
        this.user = user;
    }
}
