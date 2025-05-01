package com.aniwatch.aniwatch.comment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportedCommentRepository extends JpaRepository<ReportedComment, Long> {
    List<ReportedComment> findByIsResolvedFalse();
    List<ReportedComment> findByIsResolvedTrue();

    @Query("SELECT rc FROM ReportedComment rc JOIN rc.comment c WHERE c.watchlist.watchlistId = ?1")
    List<ReportedComment> findByWatchlistId(Long watchlistId);

    boolean existsByComment_CommentIdAndReportedBy(Long commentId, String reportedBy);
}