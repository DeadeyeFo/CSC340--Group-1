<#import "admin-layout.ftlh" as layout>

<@layout.adminLayout title="User Management" activeTab="users" additionalStyles="
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

    .status-badge {
        padding: 0.35rem 0.75rem;
        border-radius: 50rem;
        font-size: 0.8rem;
        font-weight: 500;
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
">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">User Accounts</h4>

        <div class="search-container">
            <input type="text" id="userSearch" class="form-control" placeholder="Search users...">
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
                        <th>Roles</th>
                        <th>Joined</th>
                        <th>Status</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <#list users as user>
                        <tr>
                            <td>${user.id}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${user.profileImage!'/pics/default-profile.jpg'}" alt="${user.username}" class="avatar me-3">
                                    <div>
                                        <div class="fw-semibold">${user.username}</div>
                                        <small class="text-muted">User Account</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <#list user.roles as role>
                                    <span class="badge
                                        <#if role == 'ADMIN'>bg-danger<#elseif role == 'PROVIDER'>bg-success<#else>bg-secondary</#if>
                                        me-1">${role}</span>
                                </#list>
                            </td>
                            <td>${user.joinDate!''}</td>
                            <td>
                                <#if user.enabled>
                                    <span class="status-badge bg-success bg-opacity-25 text-success">Active</span>
                                <#else>
                                    <span class="status-badge bg-danger bg-opacity-25 text-danger">Disabled</span>
                                </#if>
                            </td>
                            <td class="text-end">
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/user-profile/${user.id}" class="btn btn-outline-primary action-btn" title="View Profile">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <form action="/admin/user/${user.id}/toggle-status" method="post">
                                        <button type="submit"
                                                class="btn ${user.enabled?then('btn-outline-warning', 'btn-outline-success')} action-btn"
                                                title="${user.enabled?then('Disable User', 'Enable User')}">
                                            <i class="fas ${user.enabled?then('fa-ban', 'fa-check')}"></i>
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
            //add more scripts for functionality
    </#assign>
    </@layout.adminLayout>