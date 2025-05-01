package com.aniwatch.aniwatch.comment;

import com.aniwatch.aniwatch.user.*;
import com.aniwatch.aniwatch.watchlist.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/comments")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private CommentRepository commentRepository;

    @GetMapping("/list/{watchlistId}")
    public ResponseEntity<List<Comment>> getComments(@PathVariable Long watchlistId, Model model) {
        List<Comment> comments = commentService.getCommentsByWatchlistId(watchlistId);

        // This updates each comment with the latest avatar URL
        for (Comment comment : comments) {
            String latestAvatarUrl = userService.getCurrentUserAvatar(comment.getUsername());
            comment.setAvatarSrc(latestAvatarUrl);
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null &&
                authentication.isAuthenticated() &&
                !authentication.getName().equals("anonymousUser");

        model.addAttribute("isAuthenticated", isAuthenticated);

        //Whether to show the comment form
        if (isAuthenticated) {
            model.addAttribute("showCommentForm", true);
        } else {
            model.addAttribute("showCommentForm", false);
        }

        return ResponseEntity.ok(comments);
    }

    @PostMapping("/add/{watchlistId}")
    public ResponseEntity<?> addComment(@PathVariable Long watchlistId,
                                        @RequestParam String username,
                                        @RequestParam String text) {
        try {
            Watchlist watchlist = watchlistService.getWatchlistByWatchlistId(watchlistId);

            Comment comment = new Comment();
            comment.setText(text);
            comment.setUsername(username);
            comment.setWatchlist(watchlist);
            comment.setCreatedAt(LocalDateTime.now());

            // Get the current user's avatar based on whether they're a provider or regular user
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.isAuthenticated()) {
                String currentUsername = authentication.getName();

                String avatarUrl = userService.getCurrentUserAvatar(currentUsername);
                comment.setAvatarSrc(avatarUrl);
            } else {
                comment.setAvatarSrc("/pics/default-profile.jpg");
            }

            Comment savedComment = commentRepository.save(comment);
            return ResponseEntity.ok(savedComment);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error adding comment: " + e.getMessage());
        }
    }

    @PostMapping("/reply/{parentId}")
    public ResponseEntity<?> addReply(@PathVariable Long parentId,
                                      @RequestParam String username,
                                      @RequestParam String text) {
        try {
            Comment parentComment = commentRepository.findById(parentId)
                    .orElseThrow(() -> new RuntimeException("Parent comment not found"));

            Comment reply = new Comment();
            reply.setText(text);
            reply.setUsername(username);
            reply.setWatchlist(parentComment.getWatchlist());
            reply.setParentComment(parentComment);
            reply.setCreatedAt(LocalDateTime.now());

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.isAuthenticated()) {
                String currentUsername = authentication.getName();

                String avatarUrl = userService.getCurrentUserAvatar(currentUsername);
                reply.setAvatarSrc(avatarUrl);
            } else {
                reply.setAvatarSrc("/pics/default-profile.jpg");
            }

            Comment savedReply = commentRepository.save(reply);
            return ResponseEntity.ok(savedReply);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error adding reply: " + e.getMessage());
        }
    }

    @GetMapping("/replies/{parentCommentId}")
    public ResponseEntity<List<Comment>> getReplies(@PathVariable Long parentCommentId) {
        List<Comment> replies = commentService.getReplies(parentCommentId);

        for (Comment reply : replies) {
            String latestAvatarUrl = userService.getCurrentUserAvatar(reply.getUsername());
            reply.setAvatarSrc(latestAvatarUrl);
        }

        return ResponseEntity.ok(replies);
    }

    @PostMapping("/like/{commentId}")
    public ResponseEntity<Comment> likeComment(@PathVariable Long commentId) {
        try {
            Comment updatedComment = commentService.likeComment(commentId);
            return ResponseEntity.ok(updatedComment);
        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to like comment", e);
        }
    }

    @PostMapping("/dislike/{commentId}")
    public ResponseEntity<Comment> dislikeComment(@PathVariable Long commentId) {
        try {
            Comment updatedComment = commentService.dislikeComment(commentId);
            return ResponseEntity.ok(updatedComment);
        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to dislike comment", e);
        }
    }

    @DeleteMapping("/delete/{commentId}")
    public ResponseEntity<?> deleteComment(@PathVariable Long commentId) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated()) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("You must be logged in to delete comments");
            }

            String username = authentication.getName();
            commentService.deleteComment(commentId, username);
            return ResponseEntity.ok().body(Map.of("success", true, "message", "Comment deleted successfully"));
        } catch (ResponseStatusException e) {
            return ResponseEntity.status(e.getStatusCode()).body(e.getReason());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to delete comment: " + e.getMessage());
        }
    }

    @PostMapping("/report/{commentId}")
    public ResponseEntity<?> reportComment(
            @PathVariable Long commentId,
            @RequestParam String reason) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated()) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("You must be logged in to report comments");
            }

            String reportedBy = authentication.getName();
            ReportedComment reportedComment = commentService.reportComment(commentId, reportedBy, reason);
            return ResponseEntity.ok().body(Map.of(
                    "success", true,
                    "message", "Comment reported successfully",
                    "reportId", reportedComment.getId()
            ));
        } catch (ResponseStatusException e) {
            return ResponseEntity.status(e.getStatusCode()).body(e.getReason());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to report comment: " + e.getMessage());
        }
    }
}