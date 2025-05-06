<!-- src/main/resources/templates/admin/watchlists.ftlh -->
<#import "admin-layout.ftlh" as layout>

<@layout.adminLayout title="Watchlist Management" activeTab="watchlists" additionalStyles="
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

    .watchlist-thumbnail {
        width: 80px;
        height: 45px;
        border-radius: 6px;
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

    .rating-stars {
        color: var(--warning);
        letter-spacing: 1px;
    }

    .badge-views {
        background-color: rgba(58, 134, 255, 0.2);
        color: var(--primary);
    }
">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">All Watchlists</h4>

        <div class="search-container">
            <input type="text" id="watchlistSearch" class="form-control" placeholder="Search watchlists...">
            <i class="fas fa-search search-icon"></i>
        </div>
    </div>

    <div class="card">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Watchlist</th>
                        <th>Provider</th>
                        <th>Stats</th>
                        <th>Rating</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <#list watchlists as watchlist>
                        <tr>
                            <td>${watchlist.watchlistId}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${watchlist.thumbnail!'/pics/default-watchlist.jpg'}" alt="${watchlist.title}" class="watchlist-thumbnail me-3">
                                    <div>
                                        <div class="fw-semibold text-truncate" style="max-width: 200px;">${watchlist.title}</div>
                                        <small class="text-muted d-block text-truncate" style="max-width: 200px;">${watchlist.description!''}</small>
                                    </div>
                                </div>
                            </td>
                            <td>${watchlist.providerUsername}</td>
                            <td>
                                <span class="badge badge-views px-2 py-1 rounded-pill">
                                    <i class="fas fa-eye me-1"></i> ${watchlist.views}
                                </span>
                            </td>
                            <td>
                                <#if watchlist.rating?? && watchlist.rating gt 0>
                                    <span class="rating-stars">${getRatingStars(watchlist.rating)}</span>
                                    <span class="ms-1 text-muted">(${watchlist.rating?string("0.0")})</span>
                                <#else>
                                    <span class="rating-stars">☆☆☆☆☆</span>
                                    <span class="ms-1 text-muted">(0.0)</span>
                                </#if>
                            </td>
                            <td class="text-end">
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/watchlists/${watchlist.watchlistId}" class="btn btn-outline-primary action-btn" title="View Watchlist">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <form
                                    method="post"
                                    action="/admin/watchlist/${watchlist.watchlistId}/delete"
                                    onsubmit="return confirm('Are you sure you want to delete &quot;${watchlist.title}&quot;?');"
                                    style="display:inline"
                                  >
                                    <#-- Spring Security’s CSRF token (auto‐exposed into _csrf) -->
                                    <#if _csrf??>
                                      <input
                                        type="hidden"
                                        name="${_csrf.parameterName}"
                                        value="${_csrf.token}"
                                      >
                                    </#if>
                                  
                                    <button
                                      type="submit"
                                      class="btn btn-outline-danger action-btn"
                                      title="Delete Watchlist"
                                    >
                                      <i class="fas fa-trash"></i>
                                    </button>
                                  </form>
                                </div>
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </div>
    </div>

    <#-- Function to generate rating stars -->
    <#function getRatingStars rating>
        <#if rating?? && rating gt 0>
            <#-- To convert rating to integer stars (0 - 5) -->
            <#assign stars = (rating?round)>
            <#assign stars = (stars > 5)?then(5, stars)>
            <#assign stars = (stars < 0)?then(0, stars)>

            <#assign filledStars = "">
            <#assign emptyStars = "">

            <#list 1..stars as i>
                <#assign filledStars = filledStars + "★">
            </#list>

            <#list 1..(5-stars) as i>
                <#assign emptyStars = emptyStars + "☆">
            </#list>

            <#return filledStars + emptyStars>
        <#else>
            <#return "☆☆☆☆☆">
        </#if>
    </#function>

    <#assign additionalScripts>
        // script functionalities here
    </#assign>
</@layout.adminLayout>