package com.aniwatch.aniwatch.anime;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnimeRepository extends JpaRepository<Anime, Long> {
    List<Anime> findByExternalId(Long externalId);
    List<Anime> findAll(Sort sort);
    Page<Anime> findAll(Pageable pageable);

    //finds anime by its main and alternate title, while ignoring case sensitivity
    List<Anime> findByTitleContainingIgnoreCaseOrAlternateTitleContainingIgnoreCase(
            String title, String alternateTitle);
}