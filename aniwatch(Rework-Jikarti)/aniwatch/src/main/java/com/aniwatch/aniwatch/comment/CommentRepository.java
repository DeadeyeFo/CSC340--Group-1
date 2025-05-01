package com.aniwatch.aniwatch.comment;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByWatchlist_WatchlistId(Long watchlistId);
    int countByUsername(String username);
    List<Comment> findByWatchlist_WatchlistIdAndParentCommentIsNull(Long watchlistId);
    List<Comment> findByParentComment_CommentId(Long parentCommentId);
    int countByWatchlist_WatchlistId(Long watchlistId);
    void deleteByWatchlist_WatchlistId(Long watchlistId);

    // Methods for admin functionality, pagination included
    Page<Comment> findByWatchlist_WatchlistId(Long watchlistId, Pageable pageable);
    Page<Comment> findByWatchlist_WatchlistIdAndParentCommentIsNull(Long watchlistId, Pageable pageable);
    Page<Comment> findByWatchlist_WatchlistIdAndParentCommentIsNotNull(Long watchlistId, Pageable pageable);
    Page<Comment> findByWatchlist_WatchlistIdAndTextContaining(Long watchlistId, String text, Pageable pageable);
    Page<Comment> findByWatchlist_WatchlistIdAndCommentIdIn(Long watchlistId, List<Long> commentIds, Pageable pageable);

    Page<Comment> findByUsername(String username, Pageable pageable);
    Page<Comment> findByUsernameAndParentCommentIsNull(String username, Pageable pageable);
    Page<Comment> findByUsernameAndParentCommentIsNotNull(String username, Pageable pageable);
    Page<Comment> findByUsernameAndTextContaining(String username, String text, Pageable pageable);

    Page<Comment> findByParentCommentIsNull(Pageable pageable);
    Page<Comment> findByParentCommentIsNotNull(Pageable pageable);
    Page<Comment> findByTextContaining(String text, Pageable pageable);
    Page<Comment> findByTextContainingIgnoreCase(String text, Pageable pageable);
    Page<Comment> findByCommentIdIn(List<Long> commentIds, Pageable pageable);

    // Count methods for statistics
    long countByParentCommentIsNull();
    long countByParentCommentIsNotNull();
    long countByTextContaining(String text);

    // Query to find comments with specific text by watchlist
    @Query("SELECT c FROM Comment c WHERE c.watchlist.watchlistId = :watchlistId AND LOWER(c.text) LIKE LOWER(CONCAT('%', :text, '%'))")
    Page<Comment> findByWatchlistAndTextContainingIgnoreCase(@Param("watchlistId") Long watchlistId, @Param("text") String text, Pageable pageable);
}