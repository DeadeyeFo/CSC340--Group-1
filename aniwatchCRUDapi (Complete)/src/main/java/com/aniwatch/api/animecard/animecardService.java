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
        existing.setImageUrl(animeCard.getImageUrl());

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
