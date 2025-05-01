<#import "admin-layout.ftlh" as layout>

<@layout.adminLayout title="Reported Comments" activeTab="reported-comments" additionalStyles="
/* General Styles */
p {
    margin-top: 0;
    margin-bottom: 0!important;
}
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}
.page-title {
    font-size: 2rem;
    font-weight: 700;
    color: var(--light-text);
}
.page-subtitle {
    font-size: 1rem;
    color: var(--muted-text);
    margin-top: 0.25rem;
}
.status-badges {
    display: flex;
    gap: 1rem;
}

/* Search & Filter Section */
.filter-card {
    background-color: var(--darker);
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}
.filter-form .form-label {
    color: var(--muted-text);
    font-size: 0.9rem;
    margin-bottom: 0.5rem;
}
.filter-form .form-control,
.filter-form .form-select {
    border: 1px solid var(--border-color);
    border-radius: 0.5rem;
    height: 40px; /* Ensure consistent height */
}
.filter-form .form-control:focus,
.filter-form .form-select:focus {
    border-color: var(--primary);
    box-shadow: 0 0 5px rgba(58, 134, 255, 0.3);
}
.filter-form .input-group {
    align-items: center;
}
.filter-form .input-group-text {
    background-color: var(--dark);
    border: 1px solid var(--border-color);
    color: var(--muted-text);
    border-right: none;
    border-radius: 0.5rem 0 0 0.5rem;
    padding: 0.75rem;
    height: 40px; /* Match input height */
    display: flex;
    align-items: center;
}
.filter-form .form-control.input-with-icon {
    border-left: none;
    border-radius: 0 0.5rem 0.5rem 0;
}
.filter-form .btn-primary {
    background: linear-gradient(135deg, var(--primary), #2a5cff);
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    transition: transform 0.2s ease;
    height: 40px; /* Match input height */
    display: flex;
    align-items: center;
}
.filter-form .btn-primary:hover {
    transform: translateY(-2px);
}
.filter-form .btn-outline-secondary {
    border-color: var(--border-color);
    color: var(--muted-text);
    border-radius: 0.5rem;
    padding: 0.75rem 1.5rem;
    transition: transform 0.2s ease;
    height: 40px; /* Match input height */
    display: flex;
    align-items: center;
}
.filter-form .btn-outline-secondary:hover {
    transform: translateY(-2px);
    color: var(--light-text);
    border-color: var(--primary);
}
.filter-form .row {
    align-items: flex-end; /* Align items at the bottom for consistency */
}

/* Tabs */
.tabs-container {
    margin-bottom: 2rem;
}
.nav-tabs {
    border: none;
    display: flex;
    gap: 1rem;
}
.nav-tabs .nav-link {
    color: var(--muted-text);
    font-weight: 600;
    font-size: 1.1rem;
    padding: 0.75rem 1.5rem;
    border: none;
    background: transparent;
    position: relative;
    transition: color 0.3s ease;
}
.nav-tabs .nav-link:hover {
    color: var(--light-text);
}
.nav-tabs .nav-link.active {
    color: var(--primary);
}
.nav-tabs .nav-link.active::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 3px;
    background: linear-gradient(90deg, var(--primary), #2a5cff);
    border-radius: 3px 3px 0 0;
}
.nav-tabs .badge {
    vertical-align: middle;
    font-size: 0.85rem;
    padding: 0.4rem 0.6rem;
}

/* Report Card (Pending Reports) */
.report-card {
    background-color: var(--darker);
    border-radius: 1rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.report-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}
.report-card-header {
    background: linear-gradient(135deg, #ff4757, #ff6b81);
    padding: 1rem 1.5rem;
    border-radius: 1rem 1rem 0 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.report-card-header .status-pending {
    background-color: var(--warning);
    width: 12px;
    height: 12px;
    border-radius: 50%;
    display: inline-block;
    margin-right: 0.5rem;
}
.report-card-body {
    padding: 1.5rem;
}
.collapsible-section {
    margin-bottom: 1rem;
}
.collapsible-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    cursor: pointer;
    padding: 0.75rem;
    background-color: var(--dark);
    border-radius: 0.5rem;
    transition: background-color 0.3s ease;
}
.collapsible-header:hover {
    background-color: rgba(255, 255, 255, 0.05);
}
.collapsible-header h6 {
    margin: 0;
    font-size: 1rem;
    font-weight: 600;
}
.collapsible-content {
    display: none;
    padding: 1rem;
    background-color: rgba(239, 71, 111, 0.1);
    border-radius: 0.5rem;
    margin-top: 0.5rem;
}
.collapsible-content.show {
    display: block;
}
.comment-card {
    background-color: var(--dark);
    border-radius: 0.5rem;
    padding: 1rem;
}
.reporter-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
}
.reporter-info {
    font-size: 0.9rem;
    color: var(--muted-text);
}
.action-buttons {
    display: flex;
    gap: 0.75rem;
    flex-wrap: wrap;
}
.action-buttons .btn {
    padding: 0.5rem 1rem;
    border-radius: 0.5rem;
    font-size: 0.9rem;
    transition: transform 0.2s ease;
}
.action-buttons .btn:hover {
    transform: translateY(-2px);
}
.action-buttons .btn-outline-primary {
    border-color: var(--primary);
    color: var(--primary);
}
.action-buttons .btn-outline-success {
    border-color: var(--success);
    color: var(--success);
}
.action-buttons .btn-outline-danger {
    border-color: var(--danger);
    color: var(--danger);
}

/* Resolved Reports Table */
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
.text-wrap {
    max-width: 300px;
    white-space: normal;
    word-wrap: break-word;
}

/* Modals */
.modal-content {
    background-color: var(--darker);
    border-radius: 1rem;
    border: none;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}
.modal-header {
    border-bottom: none;
    padding: 1.5rem 1.5rem 0;
}
.modal-body {
    padding: 1.5rem;
}
.modal-footer {
    border-top: none;
    padding: 0 1.5rem 1.5rem;
}
.modal-content .form-control {
    background-color: var(--dark);
    border: 1px solid var(--border-color);
    color: var(--light-text);
    border-radius: 0.5rem;
}
.modal-content .btn {
    border-radius: 0.5rem;
    padding: 0.5rem 1rem;
    transition: transform 0.2s ease;
}
.modal-content .btn:hover {
    transform: translateY(-2px);
}

/* Ensure full width */
.content-wrapper .row {
    max-width: 100%;
}
.content-wrapper .col-12 {
    width: 100%;
    max-width: 100%;
}
">

<!-- Header Section -->
<div class="page-header">
    <div>
        <h1 class="page-title">Reported Comments</h1>
        <p class="page-subtitle">Manage reported comments and take actions</p>
    </div>
    <div class="status-badges">
        <span class="badge bg-danger rounded-pill">Pending: ${pendingCount!0}</span>
        <span class="badge bg-success rounded-pill">Resolved: ${resolvedCount!0}</span>
    </div>
</div>

<!-- Search & Filter Section -->
<div class="mb-4">
    <div class="col-12">
        <div class="filter-card">
            <form action="/admin/reported-comments" method="GET" class="row g-3 filter-form">
                    <label for="status" class="form-label">Status</label>
                    <select class="form-select" id="status" name="status">
                        <option value="">All Reports</option>
                        <option value="pending" ${(status?? && status == 'pending')?then('selected', '')}>Pending</option>
                        <option value="resolved" ${(status?? && status == 'resolved')?then('selected', '')}>Resolved</option>
                    </select>
                    <label for="reportedBy" class="form-label">Reported By</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control input-with-icon" id="reportedBy" name="reportedBy" value="${reportedBy!''}" placeholder="Reporter username">
                    </div>

                    <label for="reasonContains" class="form-label">Reason Contains</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control input-with-icon" id="reasonContains" name="reasonContains" value="${reasonContains!''}" placeholder="Search reason">
                    </div>
                <div class="d-flex justify-content-end gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search me-2"></i>Search
                    </button>
                    <a href="/admin/reported-comments" class="btn btn-outline-secondary">
                        <i class="fas fa-redo me-2"></i>Reset
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Tabs Section -->
<div class="tabs-container">
    <ul class="nav nav-tabs" id="reportsTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link ${(tab?? && tab == 'pending')?then('active', '')}" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending-reports" type="button" role="tab">
                Pending <span class="badge bg-danger rounded-pill ms-2">${pendingCount!0}</span>
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link ${(tab?? && tab == 'resolved')?then('active', '')}" id="resolved-tab" data-bs-toggle="tab" data-bs-target="#resolved-reports" type="button" role="tab">
                Resolved <span class="badge bg-success rounded-pill ms-2">${resolvedCount!0}</span>
            </button>
        </li>
    </ul>
</div>

<!-- Tab Content -->
<div class="tab-content">
    <!-- Pending Reports Tab -->
    <div class="tab-pane fade ${(tab?? && tab == 'pending')?then('show active', '')}" id="pending-reports" role="tabpanel">
            <div class="col-12">
                <#if pendingReports?? && pendingReports?size gt 0>
                        <#list pendingReports as report>
                            <div class="col-12">
                                <div class="report-card">
                                    <div class="report-card-header">
                                        <div class="d-flex align-items-center">
                                            <span class="status-pending" title="Pending"></span>
                                            <span class="fw-bold">Report #${report.id}</span>
                                        </div>
                                        <small class="text-light">
                                            <#if report.reportedAt?is_date>
                                                ${report.reportedAt?string("yyyy-MM-dd HH:mm")}
                                            <#else>
                                                ${report.reportedAt}
                                            </#if>
                                        </small>
                                    </div>
                                    <div class="report-card-body">
                                        <div class="collapsible-section">
                                            <div class="collapsible-header" data-toggle="reason-${report.id}">
                                                <h6>Reason</h6>
                                                <i class="fas fa-chevron-down"></i>
                                            </div>
                                            <div class="collapsible-content" id="reason-${report.id}">
                                                <p>${report.reason}</p>
                                            </div>
                                        </div>

                                        <div class="collapsible-section">
                                            <div class="collapsible-header" data-toggle="comment-${report.id}">
                                                <h6>Comment Details</h6>
                                                <i class="fas fa-chevron-down"></i>
                                            </div>
                                            <div class="collapsible-content" id="comment-${report.id}">
                                                <div class="comment-card">
                                                    <div class="d-flex align-items-center mb-2">
                                                        <img src="${report.comment.avatarSrc!'/pics/default-profile.jpg'}" class="reporter-avatar me-2" alt="${report.comment.username}">
                                                        <div>
                                                            <a href="/admin/users/view/${report.comment.username}" class="text-decoration-none text-light fw-bold">
                                                                ${report.comment.username}
                                                            </a>
                                                            <div class="reporter-info">
                                                                Comment ID: ${report.comment.commentId}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div>
                                                        <#if report.comment.text?contains("[Comment deleted")>
                                                            <span class="text-muted">${report.comment.text}</span>
                                                        <#else>
                                                            ${report.comment.text}
                                                        </#if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="reporter-info mt-2">
                                            <strong>Reported by:</strong>
                                            <a href="/admin/users/view/${report.reportedBy}" class="text-decoration-none text-light">
                                                ${report.reportedBy}
                                            </a>
                                        </div>

                                        <div class="action-buttons mt-3">
                                            <a href="/watchlists/${report.comment.watchlist.watchlistId}" class="btn btn-sm btn-outline-primary" target="_blank">
                                                <i class="fas fa-external-link-alt me-1"></i>View in Watchlist
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-success resolve-report-btn"
                                                    data-bs-toggle="modal" data-bs-target="#resolveReportModal"
                                                    data-report-id="${report.id}">
                                                <i class="fas fa-check me-1"></i>Resolve
                                            </button>
                                            <button type="button" class="btn btn-sm btn-outline-danger delete-reported-comment-btn"
                                                    data-bs-toggle="modal" data-bs-target="#deleteReportedCommentModal"
                                                    data-report-id="${report.id}"
                                                    data-comment-id="${report.comment.commentId}">
                                                <i class="fas fa-trash me-1"></i>Delete
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </#list>

                    <!-- Pagination for pending reports (page management) -->
                    <#if pendingTotalPages gt 1>
                        <nav class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${(pendingCurrentPage == 0)?then('disabled', '')}">
                                    <a class="page-link" href="?tab=pending&page=0${searchParams!''}" aria-label="First">
                                        <span aria-hidden="true">««</span>
                                    </a>
                                </li>
                                <li class="page-item ${(pendingCurrentPage == 0)?then('disabled', '')}">
                                    <a class="page-link" href="?tab=pending&page=${pendingCurrentPage - 1}${searchParams!''}" aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                </li>
                                <#list 0..pendingTotalPages-1 as i>
                                    <#if i == pendingCurrentPage>
                                        <li class="page-item active">
                                            <span class="page-link">${i + 1}</span>
                                        </li>
                                    <#elseif i < 3 || i >= pendingTotalPages - 3 || (i >= pendingCurrentPage - 1 && i <= pendingCurrentPage + 1)>
                                        <li class="page-item">
                                            <a class="page-link" href="?tab=pending&page=${i}${searchParams!''}">${i + 1}</a>
                                        </li>
                                    <#elseif i == 3 || i == pendingTotalPages - 4>
                                        <li class="page-item disabled">
                                            <span class="page-link">...</span>
                                        </li>
                                    </#if>
                                </#list>
                                <li class="page-item ${(pendingCurrentPage >= pendingTotalPages - 1)?then('disabled', '')}">
                                    <a class="page-link" href="?tab=pending&page=${pendingCurrentPage + 1}${searchParams!''}" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                                <li class="page-item ${(pendingCurrentPage >= pendingTotalPages - 1)?then('disabled', '')}">
                                    <a class="page-link" href="?tab=pending&page=${pendingTotalPages - 1}${searchParams!''}" aria-label="Last">
                                        <span aria-hidden="true">»»</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </#if>
                <#else>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>No pending reports found.
                    </div>
                </#if>
            </div>
    </div>

    <!-- Resolved Reports Tab -->
    <div class="tab-pane fade ${(tab?? && tab == 'resolved')?then('show active', '')}" id="resolved-reports" role="tabpanel">
            <div class="col-12">
                <#if resolvedReports?? && resolvedReports?size gt 0>
                    <div class="card">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Comment</th>
                                        <th>Reason</th>
                                        <th>Reporter</th>
                                        <th>Resolver</th>
                                        <th>Resolution</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <#list resolvedReports as report>
                                        <tr>
                                            <td>${report.id}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <img src="${report.comment.avatarSrc!'/pics/default-profile.jpg'}" class="comment-avatar me-3" alt="${report.comment.username}">
                                                    <div>
                                                        <div class="fw-semibold">
                                                            <a href="/admin/users/view/${report.comment.username}" class="text-decoration-none text-dark">
                                                                ${report.comment.username}
                                                            </a>
                                                        </div>
                                                        <div class="text-wrap">
                                                            <#if report.comment.text?contains("[Comment deleted")>
                                                                <span class="text-muted">${report.comment.text}</span>
                                                            <#else>
                                                                ${report.comment.text}
                                                            </#if>
                                                        </div>
                                                        <small class="text-muted">ID: ${report.comment.commentId}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="text-wrap">${report.reason}</div>
                                            </td>
                                            <td>${report.reportedBy}</td>
                                            <td>${report.resolvedBy}</td>
                                            <td>
                                                <div class="text-wrap">${report.resolutionNotes!}</div>
                                            </td>
                                            <td class="text-end">
                                                <div class="d-flex justify-content-end gap-2">
                                                    <button type="button" class="btn btn-outline-primary action-btn view-resolved-report-btn"
                                                            data-bs-toggle="modal" data-bs-target="#viewResolvedReportModal"
                                                            data-report-id="${report.id}"
                                                            data-comment-id="${report.comment.commentId}"
                                                            data-comment-text="${report.comment.text}"
                                                            data-comment-username="${report.comment.username}"
                                                            data-report-reason="${report.reason}"
                                                            data-reported-by="${report.reportedBy}"
                                                            data-resolved-by="${report.resolvedBy}"
                                                            data-resolution-notes="${report.resolutionNotes!}"
                                                            data-reported-at="<#if report.reportedAt?is_date>${report.reportedAt?string('yyyy-MM-dd HH:mm')}<#else>${report.reportedAt!''}</#if>"
                                                            data-resolved-at="<#if report.resolvedAt?is_date>${report.resolvedAt?string('yyyy-MM-dd HH:mm')}<#else>${report.resolvedAt!''}</#if>"
                                                            title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </#list>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Pagination for resolved reports -->
                    <#if resolvedTotalPages gt 1>
                        <nav class="mt-4">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${(resolvedCurrentPage == 0)?then('disabled', '')}">
                                    <a class="page-link" href="?tab=resolved&page=0${searchParams!''}" aria-label="First">
                                        <span aria-hidden="true">««</span>
                                    </a>
                                </li>
                                <li class="page-item ${(resolvedCurrentPage == 0)?then('disabled', '')}">
                                    <a class="page-link" href="?tab=resolved&page=${resolvedCurrentPage - 1}${searchParams!''}" aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                </li>
                                <#list 0..resolvedTotalPages-1 as i>
                                    <#if i == resolvedCurrentPage>
                                        <li class="page-item active">
                                            <span class="page-link">${i + 1}</span>
                                        </li>
                                    <#elseif i < 3 || i >= resolvedTotalPages - 3 || (i >= resolvedCurrentPage - 1 && i <= resolvedCurrentPage + 1)>
                                        <li class="page-item">
                                            <a class="page-link" href="?tab=resolved&page=${i}${searchParams!''}">${i + 1}</a>
                                        </li>
                                    <#elseif i == 3 || i == resolvedTotalPages - 4>
                                        <li class="page-item disabled">
                                            <span class="page-link">...</span>
                                        </li>
                                    </#if>
                                </#list>
                                <li class="page-item ${(resolvedCurrentPage >= resolvedTotalPages - 1)?then('disabled', '')}">
                                    <a class="page-link" href="?tab=resolved&page=${resolvedCurrentPage + 1}${searchParams!''}" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                                <li class="page-item ${(resolvedCurrentPage >= resolvedTotalPages - 1)?then('disabled', '')}">
                                    <a class="page-link" href="?tab=resolved&page=${resolvedTotalPages - 1}${searchParams!''}" aria-label="Last">
                                        <span aria-hidden="true">»»</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </#if>
                <#else>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>No resolved reports found.
                    </div>
                </#if>
            </div>
    </div>
</div>

<!-- Resolve Report Modal -->
<div class="modal fade" id="resolveReportModal" tabindex="-1" aria-labelledby="resolveReportModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resolveReportModalLabel">Resolve Report</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="resolveReportForm" action="/admin/reported-comments/resolve" method="POST">
                <div class="modal-body">
                    <input type="hidden" name="reportId" id="resolveReportId">
                    <div class="mb-3">
                        <label for="resolutionNotes" class="form-label">Resolution Notes</label>
                        <textarea class="form-control" id="resolutionNotes" name="resolutionNotes" rows="4" required></textarea>
                        <div class="form-text text-muted">Describe how you've addressed this report.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">Resolve Report</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Reported Comment Modal -->
<div class="modal fade" id="deleteReportedCommentModal" tabindex="-1" aria-labelledby="deleteReportedCommentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteReportedCommentModalLabel">Delete Comment & Resolve Report</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="deleteReportedCommentForm" action="/admin/reported-comments/delete-comment" method="POST">
                <div class="modal-body">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Are you sure you want to delete this comment? This action cannot be undone.
                    </div>
                    <p>The comment will be deleted and the report will be marked as resolved.</p>
                    <input type="hidden" name="reportId" id="deleteReportReportId">
                    <input type="hidden" name="commentId" id="deleteReportCommentId">
                    <div class="mb-3">
                        <label for="deleteResolutionNotes" class="form-label">Resolution Notes</label>
                        <textarea class="form-control" id="deleteResolutionNotes" name="resolutionNotes" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete Comment & Resolve</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- View Resolved Report Modal -->
<div class="modal fade" id="viewResolvedReportModal" tabindex="-1" aria-labelledby="viewResolvedReportModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewResolvedReportModalLabel">Report Details</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Report ID</label>
                            <div class="p-2 bg-dark rounded" id="viewReportId"></div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Reported At</label>
                            <div class="p-2 bg-dark rounded" id="viewReportedAt"></div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Reported By</label>
                            <div class="p-2 bg-dark rounded" id="viewReportedBy"></div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Resolved At</label>
                            <div class="p-2 bg-dark rounded" id="viewResolvedAt"></div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Resolved By</label>
                            <div class="p-2 bg-dark rounded" id="viewResolvedBy"></div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Resolution Notes</label>
                            <div class="p-2 bg-dark rounded" id="viewResolutionNotes" style="min-height: 60px;"></div>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">Report Reason</label>
                    <div class="p-3 bg-dark rounded" id="viewReportReason" style="min-height: 80px;"></div>
                </div>
                <hr class="border-secondary my-4">
                <h6 class="mb-3">Reported Comment</h6>
                <div class="comment-card">
                    <div class="d-flex align-items-center mb-2">
                        <img src="" id="viewCommentAvatar" class="reporter-avatar me-2" alt="">
                        <div>
                            <span id="viewCommentUsername" class="fw-bold"></span>
                            <div class="reporter-info">
                                Comment ID: <span id="viewCommentId"></span>
                            </div>
                        </div>
                    </div>
                    <div class="p-3 bg-dark rounded" id="viewCommentText" style="min-height: 100px;"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const tab = urlParams.get('tab');
    if (tab === 'resolved') {
        document.getElementById('resolved-tab').click();
    }

    // Collapsible sections
    document.querySelectorAll('.collapsible-header').forEach(header => {
        header.addEventListener('click', function() {
            const targetId = this.getAttribute('data-toggle');
            const content = document.getElementById(targetId);
            const icon = this.querySelector('i');
            content.classList.toggle('show');
            icon.classList.toggle('fa-chevron-down');
            icon.classList.toggle('fa-chevron-up');
        });
    });

    // Resolve Report Modal
    const resolveReportBtns = document.querySelectorAll('.resolve-report-btn');
    resolveReportBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const reportId = this.getAttribute('data-report-id');
            document.getElementById('resolveReportId').value = reportId;
        });
    });

    // Delete Reported Comment Modal
    const deleteReportedCommentBtns = document.querySelectorAll('.delete-reported-comment-btn');
    deleteReportedCommentBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const reportId = this.getAttribute('data-report-id');
            const commentId = this.getAttribute('data-comment-id');
            document.getElementById('deleteReportReportId').value = reportId;
            document.getElementById('deleteReportCommentId').value = commentId;
            document.getElementById('deleteResolutionNotes').value = 'Comment removed due to policy violation.';
        });
    });

    // View Resolved Report Modal
    const viewResolvedReportBtns = document.querySelectorAll('.view-resolved-report-btn');
    viewResolvedReportBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const reportId = this.getAttribute('data-report-id');
            const commentId = this.getAttribute('data-comment-id');
            const commentText = this.getAttribute('data-comment-text');
            const commentUsername = this.getAttribute('data-comment-username');
            const reportReason = this.getAttribute('data-report-reason');
            const reportedBy = this.getAttribute('data-reported-by');
            const resolvedBy = this.getAttribute('data-resolved-by');
            const resolutionNotes = this.getAttribute('data-resolution-notes');
            const reportedAt = this.getAttribute('data-reported-at');
            const resolvedAt = this.getAttribute('data-resolved-at');

            document.getElementById('viewReportId').textContent = reportId;
            document.getElementById('viewCommentId').textContent = commentId;
            document.getElementById('viewCommentText').textContent = commentText;
            document.getElementById('viewCommentUsername').textContent = commentUsername;
            document.getElementById('viewReportReason').textContent = reportReason;
            document.getElementById('viewReportedBy').textContent = reportedBy;
            document.getElementById('viewResolvedBy').textContent = resolvedBy;
            document.getElementById('viewResolutionNotes').textContent = resolutionNotes;
            document.getElementById('viewReportedAt').textContent = reportedAt;
            document.getElementById('viewResolvedAt').textContent = resolvedAt;

            document.getElementById('viewCommentAvatar').src = '/pics/default-profile.jpg';
        });
    });

    // The tab switching event to update the URL
    document.querySelectorAll('button[data-bs-toggle=\"tab\"]').forEach(tab => {
        tab.addEventListener('shown.bs.tab', function(event) {
            const id = event.target.id;
            const tabName = id.replace('-tab', '');
            const url = new URL(window.location);
            url.searchParams.set('tab', tabName);
            window.history.pushState({}, '', url);
        });
    });
});
</script>

</@layout.adminLayout>