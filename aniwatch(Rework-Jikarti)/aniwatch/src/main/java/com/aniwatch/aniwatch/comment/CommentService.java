package com.aniwatch.aniwatch.comment;

import com.aniwatch.aniwatch.watchlist.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private ReportedCommentRepository reportedCommentRepository;

    public List<Comment> getCommentsByWatchlistId(Long watchlistId) {
        return commentRepository.findByWatchlist_WatchlistIdAndParentCommentIsNull(watchlistId);
    }

    public Comment addComment(Long watchlistId, String username, String text) {
        Watchlist watchlist;
        try {
            watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);
        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Oh no watchlist not found with the ID: " + watchlistId, e);
        }
        Comment comment = new Comment();
        comment.setWatchlist(watchlist);
        comment.setUsername(username);
        comment.setText(text);
        return commentRepository.save(comment);
    }

    public Comment addReply(Long parentCommentId, String username, String text) {
        Comment parentComment = commentRepository.findById(parentCommentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Ouch, parent comment not found with the ID: " + parentCommentId));
        Comment reply = new Comment();
        reply.setUsername(username);
        reply.setText(text);
        parentComment.addReply(reply);
        return commentRepository.save(reply);
    }

    public List<Comment> getReplies(Long parentCommentId) {
        return commentRepository.findByParentComment_CommentId(parentCommentId);
    }

    public Comment likeComment(Long commentId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Whelp, comment not found with the ID: " + commentId));
        comment.setLikes(comment.getLikes() + 1);
        return commentRepository.save(comment);
    }

    public Comment dislikeComment(Long commentId) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Sorry not sorry, comment not found with the ID: " + commentId));
        comment.setDislikes(comment.getDislikes() + 1);
        return commentRepository.save(comment);
    }

    @Transactional
    public Map<String, Object> deleteComment(Long commentId, String username) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Comment not found with ID: " + commentId));

        // Normalize username for comparison (trim whitespace, case-insensitive)
        String normalizedUsername = username != null ? username.trim().toLowerCase() : "";
        String commentUsername = comment.getUsername() != null ? comment.getUsername().trim().toLowerCase() : "";

        // Check if the user is the comment owner
        if (!commentUsername.equals(normalizedUsername)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "You don't have permission to delete this comment");
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);

        // Check if the comment is a reply (has a parent comment)
        boolean isReply = comment.getParentComment() != null;

        if (isReply) {
            // Always fully delete replies, as they do not have nested replies
            commentRepository.delete(comment);
            response.put("message", "Reply deleted successfully");
            response.put("hasReplies", false);
            response.put("isReply", true);
        } else {
            // Handle parent comments
            if (comment.getReplies() != null && !comment.getReplies().isEmpty()) {
                // Parent comment with replies: mark as deleted
                comment.setText("[Comment deleted by user]");
                commentRepository.save(comment);
                response.put("message", "Comment marked as deleted");
                response.put("hasReplies", true);
                response.put("isReply", false);
            } else {
                // Parent comment with no replies: fully delete
                commentRepository.delete(comment);
                response.put("message", "Comment deleted successfully");
                response.put("hasReplies", false);
                response.put("isReply", false);
            }
        }
        return response;
    }

    @Transactional
    public ReportedComment reportComment(Long commentId, String reportedBy, String reason) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Comment not found with ID: " + commentId));

        // Check if user already reported this comment
        if (reportedCommentRepository.existsByComment_CommentIdAndReportedBy(commentId, reportedBy)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "You have already reported this comment");
        }

        ReportedComment reportedComment = new ReportedComment(comment, reportedBy, reason);
        return reportedCommentRepository.save(reportedComment);
    }

    public List<ReportedComment> getAllReportedComments() {
        return reportedCommentRepository.findAll();
    }

    public List<ReportedComment> getUnresolvedReportedComments() {
        return reportedCommentRepository.findByIsResolvedFalse();
    }

    public Map<Long, List<ReportedComment>> getReportedCommentsByWatchlist() {
        List<Watchlist> allWatchlists = watchlistService.getAllWatchlists();
        Map<Long, List<ReportedComment>> reportsByWatchlist = new HashMap<>();

        for (Watchlist watchlist : allWatchlists) {
            List<ReportedComment> reports = reportedCommentRepository.findByWatchlistId(watchlist.getWatchlistId());
            if (!reports.isEmpty()) {
                reportsByWatchlist.put(watchlist.getWatchlistId(), reports);
            }
        }

        return reportsByWatchlist;
    }

    @Transactional
    public ReportedComment resolveReport(Long reportId, String resolvedBy, String resolutionNotes) {
        ReportedComment report = reportedCommentRepository.findById(reportId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Report not found with ID: " + reportId));

        report.setResolved(true);
        report.setResolvedBy(resolvedBy);
        report.setResolutionNotes(resolutionNotes);
        report.setResolvedAt(LocalDateTime.now());

        return reportedCommentRepository.save(report);
    }

    @Transactional
    public void deleteReportedComment(Long reportId, String username) {
        ReportedComment report = reportedCommentRepository.findById(reportId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Report not found with ID: " + reportId));

        Comment comment = report.getComment();

        // Delete the comment
        if (comment.getReplies() != null && !comment.getReplies().isEmpty()) {
            comment.setText("[Comment removed by admin]");
            commentRepository.save(comment);
        } else {
            commentRepository.delete(comment);
        }

        // Resolve the report
        report.setResolved(true);
        report.setResolvedBy(username);
        report.setResolutionNotes("Comment was deleted");
        report.setResolvedAt(LocalDateTime.now());
        reportedCommentRepository.save(report);
    }
}