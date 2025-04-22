package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/comments")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @GetMapping("/list/{watchlistId}")
    public ResponseEntity<List<Comment>> getComments(@PathVariable Long watchlistId) {
        List<Comment> comments = commentService.getCommentsByWatchlistId(watchlistId);
        return ResponseEntity.ok(comments);
    }

    @PostMapping("/add/{watchlistId}")
    public ResponseEntity<Comment> addComment(
            @PathVariable Long watchlistId,
            @RequestParam String username,
            @RequestParam String text) {
        try {
            Comment comment = commentService.addComment(watchlistId, username, text);
            return ResponseEntity.ok(comment);
        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to add comment", e);
        }
    }

    @PostMapping("/reply/{parentCommentId}")
    public ResponseEntity<Comment> addReply(
            @PathVariable Long parentCommentId,
            @RequestParam String username,
            @RequestParam String text) {
        try {
            Comment reply = commentService.addReply(parentCommentId, username, text);
            return ResponseEntity.ok(reply);
        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to add reply", e);
        }
    }

    @GetMapping("/replies/{parentCommentId}")
    public ResponseEntity<List<Comment>> getReplies(@PathVariable Long parentCommentId) {
        List<Comment> replies = commentService.getReplies(parentCommentId);
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
}
