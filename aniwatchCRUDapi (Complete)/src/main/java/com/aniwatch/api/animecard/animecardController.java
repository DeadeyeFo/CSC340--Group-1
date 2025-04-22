package com.aniwatch.api.animecard;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.logging.Level;
import java.util.logging.Logger;


@RestController
@RequestMapping("/anime")
public class animecardController {

    @Autowired
    private animecardService animecardService;

    /**
     * Get a list of anime cards from a RESTful web API.
     * Endpoint: http://localhost:8080/anime/jikan
     *
     * @return a list of anime cards.
     */
    @GetMapping("/jikan")
    public Object getAnimecards(){

    
    //Cosuming a restful web api
            try{
            //CONSUMING A RESTFUL WEB API
            String url = "https://api.jikan.moe/v4/anime?limit=10&sfw=true";

            RestTemplate restTemplate = new RestTemplate();
            ObjectMapper mapper = new ObjectMapper();

            String result = restTemplate.getForObject(url, String.class);        
            JsonNode root = mapper.readTree(result);

            List<animecard> animecard = new ArrayList<animecard>();

            int count = 0;
            for (JsonNode node : root.path("data")) {
                if (count >= 10) break;
                animecard animeCard = new animecard();
                animeCard.setCardId(node.path("mal_id").asInt());
                animeCard.setName(node.path("title_english").asText());
                animeCard.setImageUrl(node.path("images").path("jpg").path("image_url").asText());
                animeCard.setDescription(node.path("synopsis").path("name").asText());
                // animeCard.setAltName(node.path("title_japanese").asText());
                
                animecard.add(animeCard);
                count++;
            }
            return animecard;
        } catch (JsonProcessingException e) {
            // Handle the exception here (e.g., log it, return an error response, etc.)
            Logger.getLogger(animecardController.class.getName()).log(Level.SEVERE, null, e);
            return new ResponseEntity<>("Error processing JSON data", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // return new ResponseEntity<>(animecardService.getAllAnimeCards(), HttpStatus.OK);
    }

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
