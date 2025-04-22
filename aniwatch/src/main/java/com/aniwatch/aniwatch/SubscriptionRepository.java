package com.aniwatch.aniwatch;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
    List<Subscription> findByUserId(Long userId);
    List<Subscription> findByWatchlistId(Long watchlistId);
    boolean existsByUserIdAndWatchlistId(Long userId, Long watchlistId);
    void deleteByUserIdAndWatchlistId(Long userId, Long watchlistId);
}