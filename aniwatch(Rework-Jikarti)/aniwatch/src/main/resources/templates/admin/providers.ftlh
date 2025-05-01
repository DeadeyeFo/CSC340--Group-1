<#import "admin-layout.ftlh" as layout>

<@layout.adminLayout title="Provider Management" activeTab="providers" additionalStyles="
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

    .provider-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
    }

    .verified-badge {
        color: var(--primary);
        margin-left: 5px;
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

    .provider-stats {
        display: flex;
        gap: 1rem;
    }

    .provider-stat {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .provider-stat i {
        color: var(--muted-text);
    }
">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">Content Providers</h4>

        <div class="search-container">
            <input type="text" id="providerSearch" class="form-control" placeholder="Search providers...">
            <i class="fas fa-search search-icon"></i>
        </div>
    </div>

    <div class="card">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Provider</th>
                        <th>Email</th>
                        <th>Joined</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <#list providers as provider>
                        <tr>
                            <td>${provider.providerId}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${provider.providerProfileImage!'/pics/default-profile.jpg'}" alt="${provider.providerUsername}" class="provider-avatar me-3">
                                    <div>
                                        <div class="fw-semibold">
                                            ${provider.providerUsername}
                                            <#if provider.verified>
                                                <i class="fas fa-check-circle verified-badge" title="Verified Provider"></i>
                                            </#if>
                                        </div>
                                        <small class="text-muted">Content Provider</small>
                                    </div>
                                </div>
                            </td>
                            <td>${provider.providerEmail!''}</td>
                            <td>${provider.createdAt!''}</td>
                            <td>
                                <#if provider.verified>
                                    <span class="badge bg-success bg-opacity-25 text-success px-3 py-2 rounded-pill">Verified</span>
                                <#else>
                                    <span class="badge bg-warning bg-opacity-25 text-warning px-3 py-2 rounded-pill">Unverified</span>
                                </#if>
                            </td>
                            <td class="text-end">
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/provider-profile/${provider.providerId}" class="btn btn-outline-primary action-btn" title="View Profile">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <form action="/admin/provider/${provider.providerId}/verify" method="post">
                                        <button type="submit"
                                                class="btn ${provider.verified?then('btn-outline-warning', 'btn-outline-success')} action-btn"
                                                title="${provider.verified?then('Remove Verification', 'Verify Provider')}">
                                            <i class="fas ${provider.verified?then('fa-times', 'fa-check')}"></i>
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

    <#assign additionalScripts>
        // Add scripts here
    </#assign>
</@layout.adminLayout>