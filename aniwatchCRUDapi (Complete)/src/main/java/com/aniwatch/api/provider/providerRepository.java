package com.aniwatch.api.provider;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface providerRepository extends JpaRepository<provider, Integer> {
    List<provider> getProviderByUsername(String username);
    List<provider> getProviderByBio(String bio);
}
