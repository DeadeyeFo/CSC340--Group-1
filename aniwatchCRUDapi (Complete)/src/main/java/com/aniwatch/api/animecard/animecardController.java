package com.aniwatch.api.animecard;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/anime")
public class animecardController {

    @Autowired
    private animecardService animecardService;

    /**
     * Get a list of all anime cards in the database.
     * Endpoint: http://localhost:8080/anime/all
     *
     * @return a list of anime cards.
     */
    @GetMapping("/all")
    public Object getAllAnimeCards()  {
        return new ResponseEntity<>(animecardService.getAllAnimeCards(), HttpStatus.OK);
    }

    /**
     * Get an anime card by its ID.
     * Endpoint: http://localhost:8080/anime/{id}
     *
     * @param id the ID of the anime card.
     * @return the anime card with the specified ID.
     */
    @GetMapping("/{id}")
    public Object getAnimeCardById(@PathVariable Integer id) {
        return new ResponseEntity<>(animecardService.getAnimeCardById(id), HttpStatus.OK);
    }

    /**
     * Get an anime card by its name.
     * Endpoint: http://localhost:8080/anime/name/{name}
     *
     * @param name the name of the anime card.
     * @return the anime card with the specified name.
     */
    @GetMapping("/name/{name}")
    public Object getAnimeCardByName(@PathVariable String name) {
        return new ResponseEntity<>(animecardService.getAnimeCardByName(name), HttpStatus.OK);
    }

    /**
     * Create a new anime card.
     * Endpoint: http://localhost:8080/anime/create
     *
     * @param animeCard the anime card to be created.
     * @return the created anime card.
     */
    @PostMapping("/create")
    public Object createAnimeCard(@RequestBody animecard animeCard) {
        return new ResponseEntity<>(animecardService.createAnimeCard(animeCard), HttpStatus.CREATED);
    }

    /**
     * Update an existing anime card by its ID.
     * Endpoint: http://localhost:8080/anime/update/{id}
     *
     * @param id the ID of the anime card to be updated.
     * @param animeCard the updated anime card data.
     * @return the updated anime card.
     */
    @PutMapping("/update/{id}")
    public Object updateAnimeCard(@PathVariable Integer id, @RequestBody animecard animeCard) {
        return new ResponseEntity<>(animecardService.updateAnimeCardById(id, animeCard), HttpStatus.OK);
    }

    /**
     * Delete an anime card by its ID.
     * Endpoint: http://localhost:8080/anime/delete/{id}
     *
     * @param id the ID of the anime card to be deleted.
     * @return a response indicating the deletion status.
     */
    @DeleteMapping("/delete/{id}")
    public Object deleteAnimeCardById(@PathVariable Integer id) {
        animecardService.deleteAnimeCardById(id);
        return new ResponseEntity<>(animecardService.getAllAnimeCards(), HttpStatus.OK);
    }


    
    
}
