package com.aniwatch.api.animecard;

import org.springframework.data.jpa.repository.JpaRepository;

public interface animecardRepository extends JpaRepository<animecard, Integer> {
    animecard findByName(String name); // Custom query method to find animecard by name
    animecard findByAltName(String altName); // Custom query method to find animecard by altName
    animecard findByDescription(String description); // Custom query method to find animecard by description
    animecard findByImageUrl(String imageUrl); // Custom query method to find animecard by imageUrl
}
