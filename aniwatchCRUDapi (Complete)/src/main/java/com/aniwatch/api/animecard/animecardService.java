package com.aniwatch.api.animecard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class animecardService {
    
    @Autowired
    private animecardRepository animecardRepository;

    /**
     * Get all anime cards in the database.
     *
     * @return list of all anime cards.
     */
    public List<animecard> getAllAnimeCards() {
        return animecardRepository.findAll();
            //Cosuming a restful web api
        //     try{
        //         //CONSUMING A RESTFUL WEB API
        //         String url = "https://api.jikan.moe/v4/anime?limit=10&sfw=true";
    
        //         RestTemplate restTemplate = new RestTemplate();
        //         ObjectMapper mapper = new ObjectMapper();
    
        //         String result = restTemplate.getForObject(url, String.class);        
        //         JsonNode root = mapper.readTree(result);
    
        //         List<animecard> animecard = new ArrayList<animecard>();
    
        //         int count = 0;
        //         for (JsonNode node : root.path("data")) {
        //             if (count >= 10) break;
        //             animecard animeCard = new animecard();
        //             animeCard.setCardId(node.path("mal_id").asInt());
        //             animeCard.setName(node.path("title_english").asText());
        //             animeCard.setImageUrl(node.path("images").path("jpg").path("image_url").asText());
        //             animeCard.setDescription(node.path("synopsis").path("name").asText());
        //             // animeCard.setAltName(node.path("title_japanese").asText());
                    
        //             animecard.add(animeCard);
        //             count++;
        //         }
        //         return animecard;
        //     } catch (JsonProcessingException e) {
        //         // Handle the exception here (e.g., log it, return an error response, etc.)
        //         Logger.getLogger(animecardController.class.getName()).log(Level.SEVERE, null, e);
        //         return null;
        //         //return new ResponseEntity<>("Error processing JSON data", HttpStatus.INTERNAL_SERVER_ERROR);
        //     }
        
        //    // return animecardRepository.findAll();
        // }
    }

    /**
     * Get an anime card by id.
     *
     * @param id the id of the anime card.
     * @return the anime card object.
     */
    public animecard getAnimeCardById(int id) {
        return animecardRepository.findById(id).orElse(null);
    }

    /**
     * Get an anime card by name.
     *
     * @param name the name of the anime card.
     * @return the anime card object.
     */
    public animecard getAnimeCardByName(String name) {
        return animecardRepository.findByName(name);
    }

    /**
     * Create a new anime card.
     *
     * @param animeCard the anime card object to be created.
     * @return the created anime card object.
     */
    public animecard createAnimeCard(animecard animeCard) {
        return animecardRepository.save(animeCard);
    }

    /**
     * Update an existing anime card by id.
     *
     * @param id the id of the anime card to be updated.
     * @param animeCard the updated anime card object.
     * @return the updated anime card object.
     */
    public animecard updateAnimeCardById(int id, animecard animeCard) {
        animecard existing = getAnimeCardById(id);
        existing.setName(animeCard.getName());
        existing.setDescription(animeCard.getDescription());
        // existing.setImageUrl[](animeCard.getImageUrl());

        return animecardRepository.save(existing);
    }

    /**
     * Delete an anime card by id.
     *
     * @param id the id of the anime card to be deleted.
     */
    public void deleteAnimeCardById(int id) {
        animecardRepository.deleteById(id);
    }

    
}
