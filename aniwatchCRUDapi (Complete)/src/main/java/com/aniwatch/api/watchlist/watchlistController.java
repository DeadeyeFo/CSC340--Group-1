package com.aniwatch.api.watchlist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/watchlists")
public class watchlistController {

    @Autowired
    private watchlistData data;

    /**
     * Get a list of all the watchlist in the database.
     * http://localhost:8080/watchlists/allWatchlists
     *
     * @return a list of watchlists.
     */
    @GetMapping("/allWatchlists")
    public Object getAllWatchlist() {
        return new ResponseEntity<>(data.getAllWatchlist(), HttpStatus.OK);
    }

    /**
     * Get a wathlist using its ID.
     * http://localhost:8080/watchlists/1
     *
     * @param watchlistId watchlist ID.
     * @return a watchlist object.
     */
    @GetMapping("/{watchlistId}")
    public Object getOneWatchlist(@PathVariable int watchlistId) {
        return new ResponseEntity<>(data.getWatchlistByWatchlistId(watchlistId), HttpStatus.OK);
    }

    /**
     * Get a list of the watchlists with a name that contains a given string.
     * http://localhost:8080/watchlists/watchlistName?search=Primordial
     *
     * @param search the search key
     * @return list of all watchlists matching the search key.
     */
    @GetMapping("/watchlistName")
    public Object getWatchlistByName(@RequestParam(name = "search", defaultValue = "") String search) {
        return new ResponseEntity<>(data.getWatchlistByWatchlistName(search), HttpStatus.OK);
    }

    /**
     * Get a list of watchlist based on their description.
     * http://localhost:8080/watchlists/watchlistDescription/watchlistDescription-info
     *
     * @param watchlistDescription the search key.
     * @return A list of watchlists objects that match the search key.
     */
    @GetMapping("/watchlistDescription/{watchlistDescription}")
    public Object getWatchlistByDescription(@PathVariable String watchlistDescription) {
        return new ResponseEntity<>(data.getWatchlistByWatchlistDescription(watchlistDescription), HttpStatus.OK);
    }

    /**
     * http://localhost:8080/watchlists/newWatchlist
     * { "watchlistName": "Top 10 Shounen", "watchlistDescription": "Best action packed anime's" }
     *
     * @param watchlist the new watchlist
     * @return updated list of watchlists
     */
    @PostMapping("/newWatchlist")
    public Object addNewWatchlist(@RequestBody watchlist watchlist) {
        data.addNewWatchlist(watchlist);
        return new ResponseEntity<>(data.getAllWatchlist(), HttpStatus.CREATED);
    }

    /**
     * Update an existing watchlists data.
     * http://localhost:8080/watchlists/updateWatchlist/1
     * { "watchlistName": "Tester Watchlist", "watchlistDescription": "Test watchlist with updates"
     * }
     *
     * @param watchlistId the watchlist ID.
     * @param watchlist the new updated watchlist details.
     * @return the updated watchlist object.
     */
    @PutMapping("/updateWatchlist/{watchlistId}")
    public Object updateWatchlist(@PathVariable Integer watchlistId, @RequestBody watchlist watchlist) {
        data.updateWatchlist(watchlistId, watchlist);
        return new ResponseEntity<>(data.getWatchlistByWatchlistId(watchlistId), HttpStatus.CREATED);
    }

    /**
     * Delete a watchlist.
     * http://localhost:8080/watchlists/deleteWatchlist/4
     * { "watchlistName": "Tester Watchlist", "watchlistDescription": "Test watchlist with updates"
     *
     * @param watchlistId the watchlist ID.
     * @return the updated list of watchlists.
     */
    @DeleteMapping("/deleteWatchlist/{watchlistId}")
    public Object deleteWatchlistById(@PathVariable Integer watchlistId) {
        data.deleteWatchlistByWatchlistId(watchlistId);
        return new ResponseEntity<>(data.getAllWatchlist(), HttpStatus.OK);
    }
}
