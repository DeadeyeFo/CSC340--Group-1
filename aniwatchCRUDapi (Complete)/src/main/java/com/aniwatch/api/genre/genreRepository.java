package com.aniwatch.api.genre;

import com.aniwatch.api.provider.provider;
import org.springframework.data.jpa.repository.JpaRepository;
public interface genreRepository extends JpaRepository<provider, Integer> {
}

