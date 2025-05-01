package com.aniwatch.aniwatch.admin;

import com.aniwatch.aniwatch.comment.*;
import com.aniwatch.aniwatch.watchlist.*;
import com.aniwatch.aniwatch.user.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminCommentController {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private CommentService commentService;

    @Autowired
    private WatchlistService watchlistService;

    @Autowired
    private ReportedCommentRepository reportedCommentRepository;

    @Autowired
    private UserService userService;

    /**
     * Display the main comment management page with filtering and pagination
     */
    @GetMapping("/comments")
    public String viewComments(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "20") int size,
            @RequestParam(value = "watchlistId", required = false) Long watchlistId,
            @RequestParam(value = "username", required = false) String username,
            @RequestParam(value = "commentType", required = false) String commentType,
            @RequestParam(value = "searchText", required = false) String searchText,
            Model model) {

        // Check for admin role
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!isAdmin(authentication)) {
            return "redirect:/home";
        }

        // Create the pageable request with sorting
        PageRequest pageRequest = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));

        // Initialize variables
        Page<Comment> commentPage;
        List<Long> reportedCommentIds = new ArrayList<>();
        StringBuilder searchParamsBuilder = new StringBuilder();

        // Apply filters
        if (watchlistId != null) {
            if (commentType != null && commentType.equals("reply")) {
                commentPage = commentRepository.findByWatchlist_WatchlistIdAndParentCommentIsNotNull(
                        watchlistId, pageRequest);
            } else if (commentType != null && commentType.equals("parent")) {
                commentPage = commentRepository.findByWatchlist_WatchlistIdAndParentCommentIsNull(
                        watchlistId, pageRequest);
            } else if (commentType != null && commentType.equals("reported")) {
                List<Long> commentIds = reportedCommentRepository.findByWatchlistId(watchlistId)
                        .stream()
                        .map(report -> report.getComment().getCommentId())
                        .collect(Collectors.toList());

                if (commentIds.isEmpty()) {
                    commentPage = Page.empty(pageRequest);
                } else {
                    commentPage = commentRepository.findByWatchlist_WatchlistIdAndCommentIdIn(
                            watchlistId, commentIds, pageRequest);
                }

                reportedCommentIds.addAll(commentIds);
            } else if (commentType != null && commentType.equals("deleted")) {
                commentPage = commentRepository.findByWatchlist_WatchlistIdAndTextContaining(
                        watchlistId, "[Comment", pageRequest);
            } else {
                commentPage = commentRepository.findByWatchlist_WatchlistId(watchlistId, pageRequest);
            }

            searchParamsBuilder.append("&watchlistId=").append(watchlistId);
        } else if (username != null && !username.isEmpty()) {
            if (commentType != null && commentType.equals("reply")) {
                commentPage = commentRepository.findByUsernameAndParentCommentIsNotNull(
                        username, pageRequest);
            } else if (commentType != null && commentType.equals("parent")) {
                commentPage = commentRepository.findByUsernameAndParentCommentIsNull(
                        username, pageRequest);
            } else if (commentType != null && commentType.equals("reported")) {
                List<ReportedComment> reports = reportedCommentRepository.findAll();
                List<Long> commentIds = reports.stream()
                        .filter(report -> report.getComment().getUsername().equals(username))
                        .map(report -> report.getComment().getCommentId())
                        .collect(Collectors.toList());

                if (commentIds.isEmpty()) {
                    commentPage = Page.empty(pageRequest);
                } else {
                    commentPage = commentRepository.findByCommentIdIn(commentIds, pageRequest);
                }

                reportedCommentIds.addAll(commentIds);
            } else if (commentType != null && commentType.equals("deleted")) {
                commentPage = commentRepository.findByUsernameAndTextContaining(
                        username, "[Comment", pageRequest);
            } else {
                commentPage = commentRepository.findByUsername(username, pageRequest);
            }

            searchParamsBuilder.append("&username=").append(URLEncoder.encode(username, StandardCharsets.UTF_8));
        } else if (searchText != null && !searchText.isEmpty()) {
            commentPage = commentRepository.findByTextContainingIgnoreCase(searchText, pageRequest);
            searchParamsBuilder.append("&searchText=").append(URLEncoder.encode(searchText, StandardCharsets.UTF_8));
        } else if (commentType != null) {
            if (commentType.equals("reply")) {
                commentPage = commentRepository.findByParentCommentIsNotNull(pageRequest);
            } else if (commentType.equals("parent")) {
                commentPage = commentRepository.findByParentCommentIsNull(pageRequest);
            } else if (commentType.equals("reported")) {
                List<Long> commentIds = reportedCommentRepository.findAll()
                        .stream()
                        .map(report -> report.getComment().getCommentId())
                        .collect(Collectors.toList());

                if (commentIds.isEmpty()) {
                    commentPage = Page.empty(pageRequest);
                } else {
                    commentPage = commentRepository.findByCommentIdIn(commentIds, pageRequest);
                }

                reportedCommentIds.addAll(commentIds);
            } else if (commentType.equals("deleted")) {
                commentPage = commentRepository.findByTextContaining("[Comment", pageRequest);
            } else {
                commentPage = commentRepository.findAll(pageRequest);
            }

            searchParamsBuilder.append("&commentType=").append(commentType);
        } else {
            // No filters, get all comments
            commentPage = commentRepository.findAll(pageRequest);
        }

        // Get all reported comments if not already included
        if (reportedCommentIds.isEmpty() && (commentType == null || !commentType.equals("reported"))) {
            reportedCommentIds = reportedCommentRepository.findAll()
                    .stream()
                    .map(report -> report.getComment().getCommentId())
                    .collect(Collectors.toList());
        }

        // Process the comments to add likes/dislikes as data attributes
        List<Map<String, Object>> enhancedComments = new ArrayList<>();
        for (Comment comment : commentPage.getContent()) {
            Map<String, Object> commentData = new HashMap<>();
            commentData.put("comment", comment);
            commentData.put("likes", comment.getLikes());
            commentData.put("dislikes", comment.getDislikes());
            commentData.put("isReported", reportedCommentIds.contains(comment.getCommentId()));

            // Add additional data for better modal display
            commentData.put("fullText", comment.getText());

            enhancedComments.add(commentData);
        }

        // Set model attributes
        model.addAttribute("enhancedComments", enhancedComments);
        model.addAttribute("comments", commentPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", commentPage.getTotalPages());
        model.addAttribute("watchlists", watchlistService.getAllWatchlists());
        model.addAttribute("reportedComments", reportedCommentIds);
        model.addAttribute("totalComments", commentRepository.count());
        model.addAttribute("totalReplies", commentRepository.countByParentCommentIsNotNull());
        model.addAttribute("totalReported", reportedCommentRepository.count());
        model.addAttribute("totalDeleted", commentRepository.countByTextContaining("[Comment"));

        // Store filter parameters
        if (watchlistId != null) model.addAttribute("selectedWatchlistId", watchlistId);
        if (username != null) model.addAttribute("username", username);
        if (commentType != null) model.addAttribute("commentType", commentType);
        if (searchText != null) model.addAttribute("searchText", searchText);

        // Add search params string for pagination links
        model.addAttribute("searchParams", searchParamsBuilder.toString());

        // Add the logged-in admin's username
        model.addAttribute("adminUsername", authentication.getName());

        return "admin/comments";
    }

    /**
     * Display the reported comments page with tabs for pending and resolved reports
     */
    @GetMapping("/reported-comments")
    public String viewReportedComments(
            @RequestParam(value = "tab", defaultValue = "pending") String tab,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "watchlistId", required = false) Long watchlistId,
            @RequestParam(value = "commentId", required = false) Long commentId,
            @RequestParam(value = "reportedBy", required = false) String reportedBy,
            @RequestParam(value = "reasonContains", required = false) String reasonContains,
            @RequestParam(value = "status", required = false) String status,
            Model model) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!isAdmin(authentication)) {
            return "redirect:/home";
        }

        // Create pageable request
        PageRequest pageRequest = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "reportedAt"));

        // Initialize variables
        List<ReportedComment> pendingReports = new ArrayList<>();
        List<ReportedComment> resolvedReports = new ArrayList<>();
        StringBuilder searchParamsBuilder = new StringBuilder();

        // Build search parameters
        if (watchlistId != null) searchParamsBuilder.append("&watchlistId=").append(watchlistId);
        if (commentId != null) searchParamsBuilder.append("&commentId=").append(commentId);
        if (reportedBy != null) searchParamsBuilder.append("&reportedBy=").append(reportedBy);
        if (reasonContains != null) searchParamsBuilder.append("&reasonContains=").append(reasonContains);
        if (status != null) searchParamsBuilder.append("&status=").append(status);

        // Apply filters and fetch reports
        List<ReportedComment> filteredReports = new ArrayList<>();

        if (watchlistId != null) {
            filteredReports = reportedCommentRepository.findByWatchlistId(watchlistId);
        } else if (commentId != null) {
            if (commentId != null) {
                final Comment foundComment = commentRepository.findById(commentId).orElse(null);
                if (foundComment != null) {
                    List<ReportedComment> reports = reportedCommentRepository.findAll().stream()
                            .filter(report -> report.getComment().getCommentId().equals(commentId))
                            .collect(Collectors.toList());
                    filteredReports.addAll(reports);
                }
            }
        } else if (reportedBy != null && !reportedBy.isEmpty()) {
            filteredReports = reportedCommentRepository.findAll().stream()
                    .filter(report -> report.getReportedBy().equalsIgnoreCase(reportedBy))
                    .collect(Collectors.toList());
        } else if (reasonContains != null && !reasonContains.isEmpty()) {
            filteredReports = reportedCommentRepository.findAll().stream()
                    .filter(report -> report.getReason().toLowerCase().contains(reasonContains.toLowerCase()))
                    .collect(Collectors.toList());
        } else if (status != null) {
            if (status.equals("pending")) {
                filteredReports = reportedCommentRepository.findByIsResolvedFalse();
            } else if (status.equals("resolved")) {
                filteredReports = reportedCommentRepository.findByIsResolvedTrue();
            } else {
                filteredReports = reportedCommentRepository.findAll();
            }
        } else {
            filteredReports = reportedCommentRepository.findAll();
        }

        // Split into pending and resolved reports
        pendingReports = filteredReports.stream()
                .filter(report -> !report.isResolved())
                .sorted(Comparator.comparing(ReportedComment::getReportedAt).reversed())
                .collect(Collectors.toList());

        resolvedReports = filteredReports.stream()
                .filter(ReportedComment::isResolved)
                .sorted(Comparator.comparing(ReportedComment::getReportedAt).reversed())
                .collect(Collectors.toList());

        // Pagination for pending reports
        int pendingStartIndex = Math.min(page * size, pendingReports.size());
        int pendingEndIndex = Math.min(pendingStartIndex + size, pendingReports.size());
        int pendingTotalPages = (int) Math.ceil((double) pendingReports.size() / size);

        List<ReportedComment> pendingPageContent = pendingReports.size() > 0
                ? pendingReports.subList(pendingStartIndex, pendingEndIndex)
                : new ArrayList<>();

        // Pagination for resolved reports
        int resolvedStartIndex = Math.min(page * size, resolvedReports.size());
        int resolvedEndIndex = Math.min(resolvedStartIndex + size, resolvedReports.size());
        int resolvedTotalPages = (int) Math.ceil((double) resolvedReports.size() / size);

        List<ReportedComment> resolvedPageContent = resolvedReports.size() > 0
                ? resolvedReports.subList(resolvedStartIndex, resolvedEndIndex)
                : new ArrayList<>();

        // Set model attributes
        model.addAttribute("pendingReports", pendingPageContent);
        model.addAttribute("resolvedReports", resolvedPageContent);
        model.addAttribute("pendingCurrentPage", page);
        model.addAttribute("pendingTotalPages", pendingTotalPages);
        model.addAttribute("resolvedCurrentPage", page);
        model.addAttribute("resolvedTotalPages", resolvedTotalPages);
        model.addAttribute("watchlists", watchlistService.getAllWatchlists());
        model.addAttribute("searchParams", searchParamsBuilder.toString());

        // Statistics
        model.addAttribute("totalReported", reportedCommentRepository.count());
        model.addAttribute("pendingCount", reportedCommentRepository.findByIsResolvedFalse().size());
        model.addAttribute("resolvedCount", reportedCommentRepository.findByIsResolvedTrue().size());
        model.addAttribute("removedCount", reportedCommentRepository.findAll().stream()
                .filter(report -> report.isResolved() && report.getResolutionNotes() != null &&
                        report.getResolutionNotes().toLowerCase().contains("removed"))
                .count());

        // Store filter parameters in model
        if (watchlistId != null) model.addAttribute("selectedWatchlistId", watchlistId);
        if (commentId != null) model.addAttribute("commentId", commentId);
        if (reportedBy != null) model.addAttribute("reportedBy", reportedBy);
        if (reasonContains != null) model.addAttribute("reasonContains", reasonContains);
        if (status != null) model.addAttribute("status", status);

        return "admin/reported-comments";
    }

    /**
     * Delete a comment from the admin panel
     */
    @PostMapping("/comments/delete")
    public String deleteComment(
            @RequestParam Long commentId,
            RedirectAttributes redirectAttributes) {

        // Check for admin role
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!isAdmin(authentication)) {
            redirectAttributes.addFlashAttribute("error", "You don't have permission to delete comments");
            return "redirect:/home";
        }

        try {
            String adminUsername = authentication.getName();

            // Get the comment
            Comment comment = commentRepository.findById(commentId)
                    .orElseThrow(() -> new RuntimeException("Comment not found with ID: " + commentId));

            if (comment.getReplies() != null && !comment.getReplies().isEmpty()) {
                // If comment has replies, mark as deleted instead of removing
                comment.setText("[Comment removed by admin]");
                commentRepository.save(comment);
                redirectAttributes.addFlashAttribute("success", "Comment marked as removed.");
            } else {
                // Otherwise completely delete the comment
                commentRepository.delete(comment);
                redirectAttributes.addFlashAttribute("success", "Comment deleted successfully.");
            }

            return "redirect:/admin/comments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting comment: " + e.getMessage());
            return "redirect:/admin/comments";
        }
    }

    /**
     * Resolve a reported comment
     */
    @PostMapping("/reported-comments/resolve")
    public String resolveReport(
            @RequestParam Long reportId,
            @RequestParam String resolutionNotes,
            RedirectAttributes redirectAttributes) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!isAdmin(authentication)) {
            redirectAttributes.addFlashAttribute("error", "You don't have permission to resolve reports");
            return "redirect:/home";
        }

        try {
            String adminUsername = authentication.getName();

            ReportedComment report = reportedCommentRepository.findById(reportId)
                    .orElseThrow(() -> new RuntimeException("Report not found with ID: " + reportId));

            report.setResolved(true);
            report.setResolvedBy(adminUsername);
            report.setResolutionNotes(resolutionNotes);
            report.setResolvedAt(LocalDateTime.now());

            reportedCommentRepository.save(report);

            redirectAttributes.addFlashAttribute("success", "Report resolved successfully.");
            return "redirect:/admin/reported-comments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error resolving report: " + e.getMessage());
            return "redirect:/admin/reported-comments";
        }
    }

    /**
     * Delete a comment and resolve its report
     */
    @PostMapping("/reported-comments/delete-comment")
    public String deleteReportedComment(
            @RequestParam Long reportId,
            @RequestParam Long commentId,
            @RequestParam String resolutionNotes,
            RedirectAttributes redirectAttributes) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!isAdmin(authentication)) {
            redirectAttributes.addFlashAttribute("error", "You don't have permission to delete comments");
            return "redirect:/home";
        }

        try {
            String adminUsername = authentication.getName();

            // Delete the comment and resolve the report
            commentService.deleteReportedComment(reportId, adminUsername);

            redirectAttributes.addFlashAttribute("success", "Comment deleted and report resolved successfully.");
            return "redirect:/admin/reported-comments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting comment: " + e.getMessage());
            return "redirect:/admin/reported-comments";
        }
    }

    /**
     * Helper method to check if the user has an admin role
     */
    private boolean isAdmin(Authentication authentication) {
        return authentication != null &&
                authentication.isAuthenticated() &&
                !authentication.getName().equals("anonymousUser") &&
                authentication.getAuthorities().stream()
                        .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
    }
}