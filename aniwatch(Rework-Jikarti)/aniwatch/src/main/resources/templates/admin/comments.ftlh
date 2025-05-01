<#import "admin-layout.ftlh" as layout>

<#-- Set default values for pagination -->
<#assign currentPage = currentPage!0>
<#assign totalPages = totalPages!1>
<#assign comments = comments![]>
<#assign enhancedComments = enhancedComments![]>
<#assign totalComments = totalComments!0>
<#assign totalReported = totalReported!0>
<#assign totalReplies = totalReplies!0>
<#assign totalDeleted = totalDeleted!0>

<@layout.adminLayout title="Comment Management" activeTab="comments" additionalStyles="
    .search-container {
        position: relative;
        max-width: 300px;
    }

    .search-icon {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--muted-text);
    }

    .comment-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
    }

    .action-btn {
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        transition: all 0.2s;
    }

    .action-btn:hover {
        transform: translateY(-2px);
    }

    .comment-content {
        max-width: 300px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .comment-info {
        font-size: 0.85rem;
        color: var(--muted-text);
    }

    .view-comment-btn {
        color: var(--primary);
        border-color: var(--primary);
    }

    .view-comment-btn:hover {
        background-color: var(--primary);
        color: white;
    }

    .delete-comment-btn {
        color: var(--danger);
        border-color: var(--danger);
    }

    .delete-comment-btn:hover {
        background-color: var(--danger);
        color: white;
    }

    .comment-preview {
        color: #000;
        font-style: italic;
        font-size: 0.9rem;
        max-width: 150px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        display: block;
    }

    .modal-content {
        border: 1px solid var(--border-color);
        color: #000;
    }

    .bg-darker {
        background-color: var(--card-bg);
    }

    .table {
        color: #000;
    }

    .table tbody td {
        background-color: white;
    }

    .table thead th {
        background-color: #f8f9fa;
        color: #000;
    }

    .fw-semibold a, .table a {
        color: #000 !important;
    }

    /* Modal styles */
    .modal-header {
        background-color: #f8f9fa;
        border-bottom: 1px solid #dee2e6;
    }

    .modal-body {
        background-color: white;
    }

    .modal-footer {
        background-color: #f8f9fa;
        border-top: 1px solid #dee2e6;
    }

    #viewCommentModal .card {
        border: 1px solid #dee2e6;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    #viewCommentModal .card-header {
        background-color: #f8f9fa;
        font-weight: 600;
    }

    #viewCommentModal .card-body {
        padding: 1rem;
    }

    .view-comment-heading {
        color: #000;
        font-weight: 600;
        margin-bottom: 0.5rem;
    }

    .comment-modal-section {
        margin-bottom: 1rem;
        padding: 0.75rem;
        background-color: #f8f9fa;
        border-radius: 0.5rem;
        border: 1px solid #dee2e6;
    }

    #commentText {
        min-height: 80px;
        white-space: pre-wrap;
    }
">

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="mb-0">Comments</h4>

    <div class="search-container">
        <input type="text" id="commentSearch" class="form-control" placeholder="Search comments...">
        <i class="fas fa-search search-icon"></i>
    </div>
</div>

<div class="card">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Watchlist</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <#list comments as comment>
                    <tr data-comment-id="${comment.commentId}"
                        data-likes="${comment.likes!0}"
                        data-dislikes="${comment.dislikes!0}"
                        data-full-text="${comment.text}">
                        <td>${comment.commentId}</td>
                        <td>
                            <div class="d-flex align-items-center">
                                <img src="${comment.avatarSrc!'/pics/default-profile.jpg'}" alt="${comment.username}" class="comment-avatar me-3">
                                <div>
                                    <div class="fw-semibold">
                                            ${comment.username}
                                    </div>
                                    <span class="comment-preview" title="${comment.text}">
                                        <#if comment.text?length gt 30>
                                            ${comment.text?substring(0, 30)}...
                                        <#else>
                                            ${comment.text}
                                        </#if>
                                    </span>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="text-truncate" style="max-width: 200px;" title="${comment.watchlist.title}">
                                ${comment.watchlist.title}
                            </div>
                        </td>
                        <td>
                            <div class="comment-info">
                                <#if comment.createdAt??>
                                    <#if comment.createdAt?is_date>
                                        ${comment.createdAt?string("yyyy-MM-dd HH:mm:ss")}
                                    <#else>
                                        ${comment.createdAt}
                                    </#if>
                                <#else>
                                    N/A
                                </#if>
                            </div>
                        </td>
                        <td>
                            <#if comment.text?contains("[Comment deleted")>
                                <span class="badge bg-secondary px-3 py-2 rounded-pill">Deleted</span>
                            <#elseif comment.parentComment??>
                                <span class="badge bg-info px-3 py-2 rounded-pill">Reply</span>
                            <#else>
                                <span class="badge bg-primary px-3 py-2 rounded-pill">Parent</span>
                            </#if>
                            <#if reportedComments?? && reportedComments?seq_contains(comment.commentId)>
                                <span class="badge bg-danger px-3 py-2 rounded-pill mt-1 d-block">Reported</span>
                            </#if>
                        </td>
                        <td class="text-end">
                            <div class="d-flex justify-content-end gap-2">
                                <button type="button" class="btn btn-outline-primary action-btn view-comment-btn"
                                        title="View Comment">
                                    <i class="fas fa-eye"></i>
                                </button>
                                <button type="button" class="btn btn-outline-danger action-btn delete-comment-btn"
                                        title="Delete Comment">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </#list>
            </tbody>
        </table>
    </div>
</div>

<!-- Pagination for page management -->
<#if totalPages gt 1>
    <nav class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item ${(currentPage == 0)?then('disabled', '')}">
                <a class="page-link" href="?page=0${searchParams!''}" aria-label="First">
                    <span aria-hidden="true">««</span>
                </a>
            </li>
            <li class="page-item ${(currentPage == 0)?then('disabled', '')}">
                <a class="page-link" href="?page=${currentPage - 1}${searchParams!''}" aria-label="Previous">
                    <span aria-hidden="true">«</span>
                </a>
            </li>

            <#assign pageStart = 0>
            <#assign pageEnd = totalPages - 1>

            <#-- Display at most 7 page links -->
            <#if totalPages gt 7>
                <#if currentPage gt 3>
                    <#assign pageStart = currentPage - 2>
                </#if>
                <#if (pageStart + 6) lt (totalPages - 1)>
                    <#assign pageEnd = pageStart + 6>
                </#if>
            </#if>

            <#-- First page link if needed -->
            <#if pageStart gt 0>
                <li class="page-item">
                    <a class="page-link" href="?page=0${searchParams!''}">1</a>
                </li>
                <#if pageStart gt 1>
                    <li class="page-item disabled">
                        <span class="page-link">...</span>
                    </li>
                </#if>
            </#if>

            <#-- Page links -->
            <#list pageStart..pageEnd as i>
                <li class="page-item ${(i == currentPage)?then('active', '')}">
                    <a class="page-link" href="?page=${i}${searchParams!''}">${i + 1}</a>
                </li>
            </#list>

            <#-- Last page link if needed -->
            <#if pageEnd lt (totalPages - 1)>
                <#if pageEnd lt (totalPages - 2)>
                    <li class="page-item disabled">
                        <span class="page-link">...</span>
                    </li>
                </#if>
                <li class="page-item">
                    <a class="page-link" href="?page=${totalPages - 1}${searchParams!''}">${totalPages}</a>
                </li>
            </#if>

            <li class="page-item ${(currentPage >= totalPages - 1)?then('disabled', '')}">
                <a class="page-link" href="?page=${currentPage + 1}${searchParams!''}" aria-label="Next">
                    <span aria-hidden="true">»</span>
                </a>
            </li>
            <li class="page-item ${(currentPage >= totalPages - 1)?then('disabled', '')}">
                <a class="page-link" href="?page=${totalPages - 1}${searchParams!''}" aria-label="Last">
                    <span aria-hidden="true">»»</span>
                </a>
            </li>
        </ul>
    </nav>
</#if>

<#assign additionalScripts>
// Comment management scripts to add if necessary
</#assign>

</@layout.adminLayout>