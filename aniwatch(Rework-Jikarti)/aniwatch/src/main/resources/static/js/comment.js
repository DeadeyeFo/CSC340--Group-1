$(document).ready(function () {
    if (typeof watchlistId === "undefined") {
        console.error("watchlistId is not defined");
        alert("Error: Watchlist ID is missing. Cannot load comments.");
        return;
    }

    const COMMENTS_PER_PAGE = 5;

    // Function to check if a comment has been reported by the current user
    function hasReportedComment(commentId) {
        // Get reported comments from localStorage
        const reportedComments = JSON.parse(localStorage.getItem('reportedComments') || '[]');
        return reportedComments.includes(String(commentId));
    }

    // Function to mark a comment as reported
    function markCommentAsReported(commentId) {
        const reportedComments = JSON.parse(localStorage.getItem('reportedComments') || '[]');

        // Add this comment if not already present
        if (!reportedComments.includes(String(commentId))) {
            reportedComments.push(String(commentId));
            localStorage.setItem('reportedComments', JSON.stringify(reportedComments));
        }
    }

    // A debounce function to prevent multiple calls
    function debounce(func, wait) {
        let timeout;
        return function (...args) {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    }

    // Post comment function
    function postComment() {
        try {
            const commentBox = document.getElementById("commentBox");
            if (!commentBox) {
                throw new Error("Comment box element not found.");
            }

            const commentText = commentBox.value.trim();
            if (!commentText) {
                alert("Please enter a comment.");
                commentBox.focus();
                return;
            }

            const username = document.querySelector(".comment-author")?.textContent?.trim();
            if (!username) {
                throw new Error("Unable to determine current user.");
            }

            const currentUserAvatar = document.querySelector(".current-user-avatar").src;
            const url = `/comments/add/${watchlistId}`;

            fetch(url, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({ username: username, text: commentText })
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(`Failed to post comment: ${response.status} ${text}`);
                    });
                }
                return response.json();
            })
            .then(comment => {
                commentBox.value = "";
                comment.avatarSrc = currentUserAvatar;
                commentsCache.unshift(comment);
                sortAndDisplayComments(currentSortType);

                if (currentSortType === "newest") {
                    const firstComment = document.querySelector(".d-flex.flex-start");
                    if (firstComment) {
                        firstComment.scrollIntoView({ behavior: "smooth", block: "nearest" });
                    }
                }
            })
            .catch(error => {
                console.error("Error posting comment:", error);
                alert("Failed to post comment. Please try again.");
            });
        } catch (error) {
            console.error("Error posting comment:", error.message);
            alert("An error occurred while posting your comment. Please try again.");
        }
    }

    const debouncedPostComment = debounce(postComment, 500);

    // Binded the debounced function to the comment button click
    // It ensures any previous bindings are removed to prevent duplicates
    $(".comment-card-body .btn-primary").off("click").on("click", function() {
        debouncedPostComment();
    });

    // Only initialize emoji picker if comment input exists (i.e., user is logged in)
    if (document.querySelector(".comment-input-wrapper")) {
        const pickerContainer = document.createElement("div");
        pickerContainer.id = "emojiPickerContainer";
        pickerContainer.style.display = "none";
        pickerContainer.style.position = "absolute";
        pickerContainer.style.zIndex = "9999";
        document.body.appendChild(pickerContainer);

        let activeInput = null;

        const pickerOptions = {
            onEmojiSelect: function (emoji) {
                if (!activeInput) return;
                const currentText = activeInput.val();
                const newText = currentText + emoji.native;
                activeInput.val(newText);
                pickerContainer.style.display = "none";
            },
            theme: "dark",
            set: "native",
            previewPosition: "bottom",
            maxFrequentRows: 2
        };

        const picker = new EmojiMart.Picker(pickerOptions);
        pickerContainer.appendChild(picker);

        $("#emojiPicker").on("click", function (e) {
            e.preventDefault();
            activeInput = $("#commentBox");
            const isVisible = pickerContainer.style.display === "block";
            pickerContainer.style.display = isVisible ? "none" : "block";
            if (!isVisible) {
                const buttonRect = this.getBoundingClientRect();
                const commentBoxRect = $("#commentBox")[0].getBoundingClientRect();
                pickerContainer.style.top = `${commentBoxRect.top + window.scrollY - pickerContainer.offsetHeight - 5}px`;
                pickerContainer.style.left = `${buttonRect.left + window.scrollX - 310}px`;
            }
        });

        $(document).on("click", ".reply-emoji-button", function (e) {
            e.preventDefault();
            activeInput = $(this).closest(".reply-input-wrapper").find(".reply-box");
            const isVisible = pickerContainer.style.display === "block";
            pickerContainer.style.display = isVisible ? "none" : "block";
            if (!isVisible) {
                const buttonRect = this.getBoundingClientRect();
                const replyBoxRect = $(this).closest(".reply-input-wrapper").find(".reply-box")[0].getBoundingClientRect();
                pickerContainer.style.top = `${replyBoxRect.top + window.scrollY - pickerContainer.offsetHeight - 5}px`;
                pickerContainer.style.left = `${buttonRect.left + window.scrollX - 310}px`;
            }
        });

        $(document).on("click", function (e) {
            if (
                !$(e.target).closest("#emojiPicker").length &&
                !$(e.target).closest(".reply-emoji-button").length &&
                !$(e.target).closest("#emojiPickerContainer").length
            ) {
                pickerContainer.style.display = "none";
            }
        });
    }

    // Always fetch comments (regardless of login status)
    fetchComments();

    function createCommentElement(comment, isReply = false, nestingLevel = 0, parentAuthor = null) {
        const commentId = comment.commentId || Math.floor(Math.random() * 10000);
        const isCurrentUser = comment.username === (document.querySelector(".comment-author")?.textContent?.trim() || '');
        const isDeleted = comment.text === "[Comment deleted by user]";
        const hasBeenReported = hasReportedComment(commentId);

        const commentDiv = document.createElement("div");
        commentDiv.className = isReply ? "d-flex flex-start reply" : "d-flex flex-start";
        commentDiv.setAttribute('data-comment-id', commentId);
        commentDiv.setAttribute('data-nesting-level', isReply ? 1 : 0);

        // Avatar image
        const avatarImg = document.createElement("img");
        avatarImg.className = "rounded-circle shadow-1-strong user-profile-link";
        avatarImg.src = comment.avatarSrc || "/pics/default-profile.jpg";
        avatarImg.alt = "avatar";
        avatarImg.width = isReply ? 65 : 65;
        avatarImg.height = isReply ? 65 : 65;
        avatarImg.style.cursor = "pointer";
        avatarImg.setAttribute('data-username', comment.username);

        // Comment card container
        const cardDiv = document.createElement("div");
        cardDiv.className = "comment-card w-100";
        cardDiv.setAttribute('data-username', comment.username);
        cardDiv.setAttribute('data-comment-id', commentId);

        // Card body
        const cardBody = document.createElement("div");
        cardBody.className = "comment-card-body p-4";

        // Header with username and date
        const headerDiv = document.createElement("div");
        headerDiv.className = "comment-header";

        const authorHeading = document.createElement(isReply ? "h5" : "h5");
        authorHeading.className = "comment-author user-profile-link";
        authorHeading.textContent = comment.username;
        authorHeading.style.cursor = "pointer";
        authorHeading.setAttribute('data-username', comment.username);

        const dateSpan = document.createElement("span");
        dateSpan.className = "comment-date";
        dateSpan.textContent = new Date(comment.createdAt).toLocaleDateString();

        const timeSpan = document.createElement("span");
        timeSpan.className = "comment-time";
        timeSpan.textContent = new Date(comment.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        // Comment text with mention if reply
        const commentP = document.createElement("p");
        commentP.className = "comment-text";
        if (isDeleted) {
            commentP.classList.add("deleted");
        }

        if (isReply && parentAuthor) {
            let cleanUsername = parentAuthor;
            if (cleanUsername.includes('@')) {
                cleanUsername = cleanUsername.replace(/^@+/, '').split('@').pop();
            }
            const mentionText = document.createElement("a");
            mentionText.href = "#";
            mentionText.style.color = "#007bff";
            mentionText.style.fontWeight = "600";
            mentionText.textContent = `@${cleanUsername}`;
            mentionText.style.textDecoration = "none";
            mentionText.style.marginRight = "5px";
            commentP.appendChild(mentionText);
            commentP.appendChild(document.createTextNode(" " + comment.text));
        } else {
            commentP.textContent = comment.text;
        }

        // Action buttons (like, dislike, reply) - only if not deleted
        const actionDiv = document.createElement("div");
        actionDiv.className = "action-buttons d-flex align-items-center";
        actionDiv.setAttribute('data-comment-id', commentId);

        if (!isDeleted) {
            const likeDiv = document.createElement("div");
            likeDiv.className = "d-flex align-items-center gap-2";

            const likeLink = document.createElement("a");
            likeLink.href = "#";
            likeLink.className = "link-muted me-2 like-btn";
            likeLink.setAttribute('data-action', 'like');
            likeLink.setAttribute('data-comment-id', commentId);
            likeLink.innerHTML = `<i class="fas fa-thumbs-up me-1"></i><span class="like-count">${comment.likes || 0}</span>`;

            const dislikeLink = document.createElement("a");
            dislikeLink.href = "#";
            dislikeLink.className = "link-muted dislike-btn";
            dislikeLink.setAttribute('data-action', 'dislike');
            likeLink.setAttribute('data-comment-id', commentId);
            dislikeLink.innerHTML = `<i class="fas fa-thumbs-down me-1"></i><span class="dislike-count">${comment.dislikes || 0}</span>`;

            // Only show reply button if user is logged in
            const isLoggedIn = document.querySelector(".comment-input-wrapper") !== null;

            likeDiv.appendChild(likeLink);
            likeDiv.appendChild(dislikeLink);
            actionDiv.appendChild(likeDiv);

            // Action buttons container (right side)
            const actionButtonsDiv = document.createElement("div");
            actionButtonsDiv.className = "report-delete-btn align-items-center";

            if (isLoggedIn) {
                const replyLink = document.createElement("a");
                replyLink.href = "#";
                replyLink.className = "link-muted reply-btn";
                replyLink.setAttribute('data-action', 'reply');
                replyLink.innerHTML = '<i class="fas fa-reply me-1"></i> Reply';
                actionButtonsDiv.appendChild(replyLink);
            }

            // Add report button - only show if user is logged in, not their own comment, and not already reported
            if (isLoggedIn && !isCurrentUser && !hasBeenReported) {
                const reportLink = document.createElement("a");
                reportLink.href = "#";
                reportLink.className = "link-muted report-btn ms-2";
                reportLink.setAttribute('data-action', 'report');
                reportLink.setAttribute('data-comment-id', commentId);
                reportLink.innerHTML = '<i class="fas fa-flag me-1"></i> Report';
                actionButtonsDiv.appendChild(reportLink);
            } else if (isLoggedIn && !isCurrentUser && hasBeenReported) {
                // Show "Reported" text if the comment has been reported
                const reportedSpan = document.createElement("span");
                reportedSpan.className = "text-muted small ms-2 reported-badge";
                reportedSpan.innerHTML = '<i class="fas fa-flag me-1"></i> Reported';
                actionButtonsDiv.appendChild(reportedSpan);
            }

            // Add delete button - only show if it's the current user's comment
            if (isCurrentUser) {
                const deleteLink = document.createElement("a");
                deleteLink.href = "#";
                deleteLink.className = "link-muted delete-btn ms-2";
                deleteLink.setAttribute('data-action', 'delete');
                deleteLink.setAttribute('data-comment-id', commentId);
                deleteLink.innerHTML = '<i class="fas fa-trash me-1"></i> Delete';
                actionButtonsDiv.appendChild(deleteLink);
            }

            actionDiv.appendChild(actionButtonsDiv);
        }

        headerDiv.appendChild(authorHeading);
        headerDiv.appendChild(dateSpan);
        headerDiv.appendChild(timeSpan);

        cardBody.appendChild(headerDiv);
        cardBody.appendChild(commentP);
        cardBody.appendChild(actionDiv);

        cardDiv.appendChild(cardBody);
        commentDiv.appendChild(avatarImg);
        commentDiv.appendChild(cardDiv);

        return commentDiv;
    }

    // Click event handler for profile links
    $(document).on('click', '.user-profile-link', function(e) {
        e.preventDefault();
        const username = $(this).data('username');
        if (!username) {
            console.error("Username not found on clicked element");
            return;
        }
        navigateToUserProfile(username);
    });

    function navigateToUserProfile(username) {
        fetch(`/user/check-type?username=${encodeURIComponent(username)}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to get user information");
                }
                return response.json();
            })
            .then(data => {
                if (data.exists) {
                    if (data.isProvider) {
                        window.location.href = `/provider-profile/${data.providerId}`;
                    } else {
                        window.location.href = `/user-profile/${data.userId}`;
                    }
                } else {
                    console.error("User not found:", username);
                    alert("User profile not found.");
                }
            })
            .catch(error => {
                console.error("Error navigating to profile:", error);
                alert("Could not navigate to user profile. Please try again.");
            });
    }

    function createReplyInputWrapper(parentId) {
        const replyInputWrapper = document.createElement("div");
        replyInputWrapper.className = "reply-input-wrapper mt-3";
        replyInputWrapper.setAttribute('data-parent-id', parentId);

        const inputContainer = document.createElement("div");
        inputContainer.className = "input-container position-relative";

        const replyTextarea = document.createElement("textarea");
        replyTextarea.className = "form-control border-0 bg-secondary reply-box";
        replyTextarea.placeholder = "Write a reply...";

        const emojiButton = document.createElement("button");
        emojiButton.className = "reply-emoji-button";
        emojiButton.innerHTML = "😊";

        inputContainer.appendChild(replyTextarea);
        inputContainer.appendChild(emojiButton);

        const replyButtonDiv = document.createElement("div");
        replyButtonDiv.className = "d-flex justify-content-end mt-2";

        const replyButton = document.createElement("button");
        replyButton.className = "btn btn-primary btn-sm post-reply-btn me-1";
        replyButton.textContent = "Reply";

        replyButtonDiv.appendChild(replyButton);
        replyInputWrapper.appendChild(inputContainer);
        replyInputWrapper.appendChild(replyButtonDiv);

        return replyInputWrapper;
    }

    function updateToggleRepliesLink($commentCard) {
        const $commentBody = $commentCard.is('.comment-card-body') ?
                            $commentCard :
                            $commentCard.find('.comment-card-body');

        let $toggleLink = $commentBody.find('.toggle-replies');
        let $repliesSection = $commentBody.find('.replies-section');

        if ($repliesSection.length === 0) {
            $toggleLink.remove();
            return;
        }

        const replyCount = $repliesSection.find('.reply').length;

        if (replyCount === 0) {
            $toggleLink.remove();
            $repliesSection.remove();
            return;
        }

        if ($toggleLink.length === 0) {
            $toggleLink = $('<a href="#" class="link-muted toggle-replies"></a>');
            $commentBody.find('.action-buttons').after($toggleLink);
        }

        const isHidden = $repliesSection.is(':hidden');
        $toggleLink.text(isHidden ?
            `Show ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}` :
            `Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
        $toggleLink.show();
    }

    function applyViewMoreComments() {
        const $commentSection = $('#commentSection');
        const $mainComments = $commentSection.find('> .d-flex.flex-start:not(.reply)');
        const totalComments = $mainComments.length;
        const $viewMoreButton = $commentSection.find('.view-more-comments-container');

        $viewMoreButton.remove();

        if (totalComments > COMMENTS_PER_PAGE) {
            $mainComments.removeClass('hidden');
            $mainComments.each(function (index) {
                if (index >= COMMENTS_PER_PAGE) {
                    $(this).addClass('hidden');
                }
            });

            const remainingComments = totalComments - COMMENTS_PER_PAGE;

            const $viewMoreButtonHtml = $(`
                <div class="text-center mt-3 mb-3 view-more-comments-container">
                    <a href="#" class="link-muted view-more-comments">View ${remainingComments} more comments</a>
                </div>
            `);
            $mainComments.eq(COMMENTS_PER_PAGE - 1).after($viewMoreButtonHtml);
        } else {
            $mainComments.removeClass('hidden');
        }
    }

    // The CSS for hiding comments and styling deleted comments
    const commentStyles = `
    <style>
    /* Hidden Main Comments */
    #commentSection .d-flex.flex-start.hidden {
        display: none !important;
    }

    /* Hidden Replies */
    .replies-section .reply.hidden {
        display: none !important;
    }

    /* Deleted Comment Style */
    .comment-text.deleted {
        color: #6c757d;
    }

    /* Toast Notification Styles */
    .toast-container {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
    }
    .report-toast {
        background-color: rgba(0, 128, 0, 0.85);
        color: white;
        padding: 12px 20px;
        border-radius: 8px;
        margin-bottom: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        font-size: 14px;
        max-width: 350px;
        display: flex;
        align-items: center;
        animation: slideIn 0.3s ease forwards;
    }
    .report-toast i {
        margin-right: 10px;
        font-size: 18px;
    }
    /* Reported Badge Style */
    .reported-badge {
        color: #ff3d3d !important;
    }
    .reported-badge i {
        color: #ff3d3d !important;
    }
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    @keyframes fadeOut {
        from {
            opacity: 1;
        }
        to {
            opacity: 0;
        }
    }
    </style>
    `;

    if (!$('head style:contains("Hidden Main Comments")').length) {
        $('head').append(commentStyles);
    }

    // Create toast container if it doesn't exist
    if (!$('.toast-container').length) {
        $('body').append('<div class="toast-container"></div>');
    }

    function showToastNotification(message, type = 'success') {
        const icon = type === 'success' ? 'check-circle' : 'exclamation-triangle';
        const bgColor = type === 'success' ? 'rgba(0, 128, 0, 0.85)' : 'rgba(220, 53, 69, 0.85)';

        const toast = document.createElement('div');
        toast.className = 'report-toast';
        toast.style.backgroundColor = bgColor;
        toast.innerHTML = `<i class="fas fa-${icon}"></i> ${message}`;

        $('.toast-container').append(toast);

        // Remove the toast after 3 seconds
        setTimeout(() => {
            toast.style.animation = 'fadeOut 0.5s ease forwards';
            setTimeout(() => {
                toast.remove();
            }, 500);
        }, 3000);
    }

    function fetchComments() {
        fetch(`/comments/list/${watchlistId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Failed to fetch comments: ${response.status}`);
                }
                return response.json();
            })
            .then(comments => {
                const commentSection = document.getElementById("commentSection");
                commentSection.innerHTML = "";

                if (!comments || comments.length === 0) {
                    commentSection.innerHTML = '<p class="text-center text-light">No comments yet.</p>';
                    return;
                }

                comments.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
                comments.forEach(comment => {
                    const commentElement = createCommentElement(comment);
                    commentSection.appendChild(commentElement);
                    fetchRepliesFlat(comment.commentId, commentElement, comment.username);
                });

                applyViewMoreComments();
            })
            .catch(error => {
                console.error("Error fetching comments:", error);
            });
    }

    function fetchRepliesFlat(commentId, commentElement, commentUsername) {
        let repliesSection = commentElement.querySelector('.replies-section');
        let toggleLink = commentElement.querySelector('.toggle-replies');

        if (!repliesSection) {
            toggleLink = document.createElement('a');
            toggleLink.href = '#';
            toggleLink.className = 'link-muted toggle-replies';

            const actionDiv = commentElement.querySelector('.action-buttons');
            actionDiv.parentNode.insertBefore(toggleLink, actionDiv.nextSibling);

            repliesSection = document.createElement('div');
            repliesSection.className = 'replies-section mt-3';
            toggleLink.parentNode.insertBefore(repliesSection, toggleLink.nextSibling);
        }

        let allReplies = [];
        const processedReplies = new Set();

        async function gatherAllReplies(parentId, parentUsername) {
            try {
                const response = await fetch(`/comments/replies/${parentId}`);
                if (!response.ok) {
                    throw new Error(`Failed to fetch replies for ${parentId}: ${response.status}`);
                }

                const replies = await response.json();
                if (!replies || replies.length === 0) {
                    return;
                }

                for (const reply of replies) {
                    if (!processedReplies.has(reply.commentId)) {
                        allReplies.push({
                            reply: reply,
                            parentUsername: parentUsername,
                            nestingLevel: 1
                        });
                        processedReplies.add(reply.commentId);
                        await gatherAllReplies(reply.commentId, reply.username);
                    }
                }
            } catch (error) {
                console.error(`Error gathering replies for ${parentId}:`, error);
            }
        }

        async function loadAndDisplayReplies() {
            try {
                await gatherAllReplies(commentId, commentUsername);
                allReplies.sort((a, b) => new Date(b.reply.createdAt) - new Date(a.reply.createdAt));

                repliesSection.innerHTML = '';
                for (const replyData of allReplies) {
                    const replyElement = createCommentElement(
                        replyData.reply,
                        true,
                        replyData.nestingLevel,
                        replyData.parentUsername
                    );
                    repliesSection.appendChild(replyElement);
                }

                if (allReplies.length > 0) {
                    const replyCount = allReplies.length;
                    const isVisible = localStorage.getItem(`reply-section-${commentId}`) === 'visible';
                    repliesSection.style.display = isVisible ? 'block' : 'none';
                    toggleLink.textContent = isVisible ?
                        `Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}` :
                        `Show ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`;
                    toggleLink.style.display = 'block';
                } else {
                    toggleLink.style.display = 'none';
                    repliesSection.style.display = 'none';
                }
            } catch (error) {
                console.error(`Error in loadAndDisplayReplies for comment ${commentId}:`, error);
            }
        }
        loadAndDisplayReplies();
    }

    $(document).on('click', '.like-btn, .dislike-btn', function (e) {
        e.preventDefault();
        const $actionElement = $(this);
        const action = $actionElement.data('action');
        const $comment = $actionElement.closest('[data-comment-id]');
        const id = $comment.data('comment-id');
        const url = action === 'like' ? `/comments/like/${id}` : `/comments/dislike/${id}`;

        fetch(url, { method: 'POST' })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Failed to ${action} comment: ${response.status}`);
                }
                return response.json();
            })
            .then(updatedComment => {
                $actionElement.find(`.${action}-count`).text(updatedComment[action + 's']);
                const commentIndex = commentsCache.findIndex(c => c.commentId === id);
                if (commentIndex !== -1) {
                    commentsCache[commentIndex][action + 's'] = updatedComment[action + 's'];
                    if (currentSortType === "top") {
                        sortAndDisplayComments("top");
                    }
                }
            })
            .catch(error => {
                console.error(`Error ${action}ing comment:`, error);
                alert(`Failed to ${action} comment. Please try again.`);
            });
    });

    if (document.querySelector(".comment-input-wrapper")) {
        $(document).on('click', '.reply-btn', function (e) {
            e.preventDefault();
            const $replyBtn = $(this);
            const $actionDiv = $replyBtn.closest('.action-buttons');
            const $commentCardBody = $replyBtn.closest('.comment-card-body');
            const $commentWithId = $replyBtn.closest('[data-comment-id]');
            const parentId = $commentWithId.attr('data-comment-id');

            if (!parentId) {
                console.error("Could not find parent comment ID");
                return;
            }

            let $existingWrapper;
            if ($actionDiv.length) {
                $existingWrapper = $actionDiv.next('.reply-input-wrapper');
            } else if ($commentCardBody.length) {
                $existingWrapper = $commentCardBody.find('.reply-input-wrapper');
            }

            if ($existingWrapper && $existingWrapper.length > 0) {
                $existingWrapper.slideUp(300, function() {
                    $(this).remove();
                });
                return;
            }

            $('.reply-input-wrapper').slideUp(200, function() {
                $(this).remove();
            });

            const $replyInputWrapper = $(createReplyInputWrapper(parentId));
            if ($actionDiv.length) {
                $actionDiv.after($replyInputWrapper);
            } else if ($commentCardBody.length) {
                $commentCardBody.append($replyInputWrapper);
            }

            $replyInputWrapper.hide().slideDown(300, function() {
                $replyInputWrapper.find('.reply-box').focus();
            });
        });

        $(document).on('click', '.post-reply-btn', function (e) {
                    e.preventDefault();
                    const $button = $(this);
                    const $replyInputWrapper = $button.closest('.reply-input-wrapper');
                    const $replyBox = $replyInputWrapper.find('.reply-box');
                    const replyText = $replyBox.val().trim();
                    const parentId = $replyInputWrapper.attr('data-parent-id');

                    if (!parentId) {
                        console.error("Parent comment ID is missing");
                        alert("Could not identify parent comment. Please try again.");
                        return;
                    }

                    if (!replyText) {
                        alert("Please enter a reply.");
                        $replyBox.focus();
                        return;
                    }

                    const username = document.querySelector(".comment-author")?.textContent?.trim();
                    if (!username) {
                        console.error("Could not determine current user for reply");
                        alert("Unable to post reply: user information missing.");
                        return;
                    }

                    const currentUserAvatar = document.querySelector(".current-user-avatar").src;

                    $button.prop('disabled', true).text('Posting...');

                    fetch(`/comments/reply/${parentId}`, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: new URLSearchParams({
                            username: username,
                            text: replyText
                        })
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`Failed to post reply: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(reply => {
                        reply.avatarSrc = currentUserAvatar;
                        const $parentElement = $replyInputWrapper.closest('[data-comment-id]');
                        const username = $parentElement.find('.comment-author').text().trim();

                        const $mainComment = $parentElement.hasClass('d-flex flex-start:not(.reply)') ?
                                          $parentElement :
                                          $parentElement.closest('.d-flex.flex-start:not(.reply)');

                        if (!$mainComment.length) {
                            console.error("Could not find main comment");
                            return;
                        }

                        const mainCommentId = $mainComment.data('comment-id');
                        let $repliesSection = $mainComment.find('.replies-section');
                        let $toggleLink = $mainComment.find('.toggle-replies');

                        if ($repliesSection.length === 0) {
                            $toggleLink = $('<a href="#" class="link-muted toggle-replies"></a>');
                            const $actionButtons = $mainComment.find('.action-buttons');
                            $actionButtons.after($toggleLink);

                            $repliesSection = $('<div class="replies-section mt-3"></div>');
                            $toggleLink.after($repliesSection);
                        }

                        const newReply = createCommentElement(reply, true, 1, username);
                        $repliesSection.prepend(newReply);

                        const replyCount = $repliesSection.find('.reply').length;
                        $toggleLink.text(`Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
                        $toggleLink.show();

                        $repliesSection.show();
                        localStorage.setItem(`reply-section-${mainCommentId}`, 'visible');

                        $replyBox.val('');
                        $replyInputWrapper.slideUp(function() {
                            $(this).remove();
                        });

                        $(newReply).hide().slideDown().get(0).scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                        $button.prop('disabled', false).text('Reply');
                    })
                    .catch(error => {
                        console.error("Error posting reply:", error);
                        alert("Failed to post reply. Please try again.");
                        $button.prop('disabled', false).text('Reply');
                    });
                });
            }

            $(document).on('click', '.toggle-replies', function (e) {
                e.preventDefault();
                const $link = $(this);
                const $repliesSection = $link.next('.replies-section');
                const $comment = $link.closest('[data-comment-id]');
                const commentId = $comment.data('comment-id');

                if (!$repliesSection.length) {
                    console.error("No replies section found");
                    return;
                }

                const $replies = $repliesSection.find('.reply');
                const replyCount = $replies.length;

                if (replyCount === 0) {
                    $link.hide();
                    return;
                }

                if ($repliesSection.is(':visible')) {
                    $repliesSection.slideUp(200, function() {
                        $link.text(`Show ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
                        localStorage.setItem(`reply-section-${commentId}`, 'hidden');
                    });
                } else {
                    $repliesSection.slideDown(200, function() {
                        $link.text(`Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
                        localStorage.setItem(`reply-section-${commentId}`, 'visible');
                    });
                }
            });

            $(document).on('click', '.view-more-comments', function (e) {
                e.preventDefault();
                const $button = $(this);
                const $commentSection = $('#commentSection');
                const $hiddenComments = $commentSection.find('.d-flex.flex-start.hidden');

                if ($hiddenComments.length > 0) {
                    $hiddenComments.removeClass('hidden');
                    $button.closest('.view-more-comments-container').fadeOut(300, function () {
                        $(this).remove();
                    });
                }
            });

            setTimeout(function() {
                if (typeof fetchComments === 'function' && $('.comment-sorting-controls').length === 0) {
                    fetchComments();
                }
            }, 500);

            const originalFetchComments = fetchComments;

            let currentSortType = "newest";
            let commentsCache = [];

            function createSortingControls() {
                $('.comments-header').remove();

                const headerHTML = `
                    <div class="comments-header">
                        <div class="comments-title">
                            <i class="far fa-comment-alt"></i>
                            <h5>Comments</h5>
                        </div>
                        <div class="sort-controls">
                            <span>Sort by:</span>
                            <div class="sort-buttons">
                                <button type="button" class="sort-btn active" data-sort="newest">Newest</button>
                                <button type="button" class="sort-btn" data-sort="oldest">Oldest</button>
                                <button type="button" class="sort-btn" data-sort="top">Top</button>
                            </div>
                        </div>
                    </div>
                `;

                const styles = `
                    <style>
                        .comments-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 35px;
                            width: 100%;
                            margin-top: 30px;
                            color: white;
                        }

                        .comments-title {
                            display: flex;
                            align-items: center;
                            gap: 10px;
                        }

                        .comments-title i {
                            font-size: 1.2rem;
                            color: white;
                        }

                        .comments-title h5 {
                            margin: 0;
                            font-size: 1.2rem;
                            font-weight: 600;
                            color: white;
                        }

                        .sort-controls {
                            display: flex;
                            align-items: center;
                            gap: 10px;
                        }

                        .sort-controls span {
                            color: white;
                            font-size: 0.9rem;
                        }

                        .sort-buttons {
                            display: flex;
                            gap: 5px;
                        }

                        .sort-btn {
                            background-color: rgba(44, 62, 80, 0.5);
                            color: white;
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            transition: all 0.2s ease;
                            font-size: 0.8rem;
                            padding: 4px 10px;
                            border-radius: 4px;
                            cursor: pointer;
                        }

                        .sort-btn:hover {
                            background-color: rgba(52, 152, 219, 0.3);
                            color: white;
                        }

                        .sort-btn.active {
                            background: linear-gradient(135deg, #3498db, #2980b9);
                            color: white;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                            box-shadow: 0 2px 8px rgba(52, 152, 219, 0.4);
                        }

                        @media (max-width: 576px) {
                            .comments-header {
                                flex-direction: column;
                                align-items: flex-start;
                            }

                            .sort-controls {
                                margin-top: 10px;
                                width: 100%;
                            }
                        }
                    </style>
                `;

                $('head style:contains("comments-header")').remove();
                $('head').append(styles);

                const existingHeader = $('h5:contains("Comments"), span:contains("Comments"), .comment-heading, div:contains("Comments")').filter(function() {
                    return $(this).clone().children().remove().end().text().trim() === "Comments";
                });

                const commentIcon = $('.fa-comment, .fa-comment-alt, .far.fa-comment-alt');

                if (existingHeader.length > 0) {
                    existingHeader.hide();
                }
                if (commentIcon.length > 0) {
                    commentIcon.hide();
                }

                const commentBox = $('.comment-input-wrapper, .comment-box-container, textarea[placeholder*="comment"], textarea[placeholder*="Leave a comment"]').closest('div.row, div.comment-section, div.container');
                const loginBanner = $('.login-banner, .comment-login, .login-prompt, div:contains("Please log in to leave a comment")');
                const commentSection = $('#commentSection');

                if (commentSection.length > 0) {
                    const animeCards = $('.anime-card, .anime-box, .card').last();

                    if (animeCards.length > 0) {
                        animeCards.closest('.row, .container').after(headerHTML);
                    } else {
                        if (loginBanner.length > 0) {
                            loginBanner.before(headerHTML);
                        } else if (commentBox.length > 0) {
                            commentBox.before(headerHTML);
                        } else {
                            commentSection.before(headerHTML);
                        }
                    }
                } else {
                    const content = $('.content, main, #main-content').first();
                    if (content.length > 0) {
                        const possibleHeaders = content.find('h1, h2, h3, h4, h5, h6, div').filter(function() {
                            return $(this).text().includes('Comments');
                        });

                        if (possibleHeaders.length > 0) {
                            possibleHeaders.first().replaceWith(headerHTML);
                        } else {
                            content.append(headerHTML);
                        }
                    } else {
                        $('body').append(headerHTML);
                    }
                }

                $('.sort-btn').off('click').on('click', function() {
                    const sortType = $(this).data('sort');
                    if (sortType === currentSortType) return;

                    $('.sort-btn').removeClass('active');
                    $(this).addClass('active');

                    currentSortType = sortType;
                    sortAndDisplayComments(sortType);
                });
            }

            function sortAndDisplayComments(sortType) {
                if (!commentsCache || commentsCache.length === 0) {
                    const commentSection = document.getElementById("commentSection");
                    commentSection.innerHTML = '<p class="text-center text-light">No comments yet.</p>';
                    return;
                }

                const sortedComments = [...commentsCache];
                switch (sortType) {
                    case "newest":
                        sortedComments.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
                        break;
                    case "oldest":
                        sortedComments.sort((a, b) => new Date(a.createdAt) - new Date(b.createdAt));
                        break;
                    case "top":
                        sortedComments.sort((a, b) => (b.likes || 0) - (a.likes || 0));
                        break;
                    default:
                        sortedComments.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
                }

                const commentSection = document.getElementById("commentSection");
                commentSection.innerHTML = "";

                sortedComments.forEach(comment => {
                    const commentElement = createCommentElement(comment);
                    commentSection.appendChild(commentElement);
                    fetchRepliesFlat(comment.commentId, commentElement, comment.username);
                });

                applyViewMoreComments();
                $("#commentSection > div").addClass("comment-sort-fade");
            }

            fetchComments = function() {
                fetch(`/comments/list/${watchlistId}`)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error(`Failed to fetch comments: ${response.status}`);
                        }
                        return response.json();
                    })
                    .then(comments => {
                        commentsCache = comments || [];

                        if ($(".comment-sorting-controls").length === 0) {
                            createSortingControls();

                            $(document).on("click", ".sort-btn", function() {
                                const sortType = $(this).data("sort");
                                if (sortType === currentSortType) return;

                                $(".sort-btn").removeClass("active");
                                $(this).addClass("active");

                                currentSortType = sortType;
                                sortAndDisplayComments(sortType);
                            });
                        }

                        sortAndDisplayComments(currentSortType);
                    })
                    .catch(error => {
                        console.error("Error fetching comments:", error);
                        const commentSection = document.getElementById("commentSection");
                        commentSection.innerHTML = '<p class="text-center text-danger">Failed to load comments. Please try again later.</p>';
                    });
            };

            const originalLikeDislikeHandler = $._data($(document)[0], "events")?.click?.find(
                handler => handler.selector === '.like-btn, .dislike-btn'
            );

            if (originalLikeDislikeHandler) {
                $(document).off('click', '.like-btn, .dislike-btn');

                $(document).on('click', '.like-btn, .dislike-btn', function (e) {
                    e.preventDefault();
                    const $actionElement = $(this);
                    const action = $actionElement.data('action');
                    const $comment = $actionElement.closest('[data-comment-id]');
                    const id = $comment.data('comment-id');
                    const url = action === 'like' ? `/comments/like/${id}` : `/comments/dislike/${id}`;

                    fetch(url, { method: 'POST' })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error(`Failed to ${action} comment: ${response.status}`);
                            }
                            return response.json();
                        })
                        .then(updatedComment => {
                            $actionElement.find(`.${action}-count`).text(updatedComment[action + 's']);
                            const commentIndex = commentsCache.findIndex(c => c.commentId === id);
                            if (commentIndex !== -1) {
                                commentsCache[commentIndex][action + 's'] = updatedComment[action + 's'];
                                if (currentSortType === "top") {
                                    sortAndDisplayComments("top");
                                }
                            }
                        })
                        .catch(error => {
                            console.error(`Error ${action}ing comment:`, error);
                            alert(`Failed to ${action} comment. Please try again.`);
                        });
                });
            }

            // Delete comment handler
            $(document).on('click', '.delete-btn', function(e) {
                e.preventDefault();
                const $button = $(this);
                const commentId = $button.data('comment-id');

                if (!commentId) {
                    console.error("Comment ID not found");
                    alert("Unable to delete comment: Comment ID missing.");
                    return;
                }

                if (!confirm("Are you sure you want to delete this comment? This action cannot be undone.")) {
                    return;
                }

                const username = document.querySelector(".comment-author")?.textContent?.trim();
                if (!username) {
                    console.error("Could not determine current user for deletion");
                    alert("Unable to delete comment: user information missing.");
                    return;
                }

                $button.prop('disabled', true);

                fetch(`/comments/delete/${commentId}`, {
                    method: 'DELETE',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: new URLSearchParams({ username: username })
                })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(data => {
                            throw new Error(data.message || `Failed to delete comment: ${response.status}`);
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    const $commentElement = $(`[data-comment-id="${commentId}"]`);
                    const commentIndex = commentsCache.findIndex(c => c.commentId.toString() === commentId.toString());

                    if (data.isReply) {
                        // Reply was fully deleted
                        $commentElement.remove();

                        // Find the parent comment and re-fetch its replies to update the UI
                        const $parentComment = $commentElement.closest('.d-flex.flex-start:not(.reply)');
                        const parentCommentId = $parentComment.data('comment-id');
                        const parentCommentUsername = $parentComment.find('.comment-author').text().trim();

                        if (parentCommentId) {
                            fetchRepliesFlat(parentCommentId, $parentComment[0], parentCommentUsername);
                        }
                    } else if (data.hasReplies) {
                        // Parent comment was marked as deleted (has replies)
                        const $commentText = $commentElement.find('.comment-text');
                        $commentText.text('[Comment deleted by user]');
                        $commentText.addClass('deleted');

                        const $actionDiv = $commentElement.find('.action-buttons');
                        $actionDiv.empty();

                        if (commentIndex !== -1) {
                            commentsCache[commentIndex].text = "[Comment deleted by user]";
                        }

                        // Re-fetch replies to ensure they are displayed
                        const commentUsername = $commentElement.find('.comment-author').text().trim();
                        fetchRepliesFlat(commentId, $commentElement[0], commentUsername);
                    } else {
                        // Parent comment was fully deleted (no replies)
                        $commentElement.remove();
                        if (commentIndex !== -1) {
                            commentsCache.splice(commentIndex, 1);
                        }
                    }

                    alert(data.message || "Comment deleted successfully.");
                })
                .catch(error => {
                    console.error("Error deleting comment:", error);
                    alert(`Failed to delete comment: ${error.message}`);
                })
                .finally(() => {
                    $button.prop('disabled', false);
                });
            });

            // Report comment handler
            $(document).on('click', '.report-btn', function(e) {
                e.preventDefault();
                const commentId = $(this).data('comment-id');

                if (!commentId) {
                    console.error("Comment ID not found");
                    return;
                }

                showReportModal(commentId);
            });

            window.showReportModal = function(commentId) {
                let reportModal = document.getElementById('reportCommentModal');

                if (!reportModal) {
                    const modalHTML = `
                        <div class="modal fade" id="reportCommentModal" tabindex="-1" aria-labelledby="reportCommentModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content bg-dark text-light">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="reportCommentModalLabel">Report Comment</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Please select a reason for reporting this comment:</p>
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="reportReason" id="reasonSpam" value="Spam or misleading">
                                            <label class="form-check-label" for="reasonSpam">Spam or misleading</label>
                                        </div>
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="reportReason" id="reasonHateful" value="Hateful or abusive content">
                                            <label class="form-check-label" for="reasonHateful">Hateful or abusive content</label>
                                        </div>
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="reportReason" id="reasonHarassment" value="Harassment or bullying">
                                            <label class="form-check-label" for="reasonHarassment">Harassment or bullying</label>
                                        </div>
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="reportReason" id="reasonInappropriate" value="Inappropriate content">
                                            <label class="form-check-label" for="reasonInappropriate">Inappropriate content</label>
                                        </div>
                                        <div class="form-check mb-3">
                                            <input class="form-check-input" type="radio" name="reportReason" id="reasonOther" value="other">
                                            <label class="form-check-label" for="reasonOther">Other</label>
                                        </div>
                                        <div class="mb-3" id="otherReasonContainer" style="display: none;">
                                            <label for="otherReason" class="form-label">Please specify:</label>
                                            <textarea class="form-control bg-secondary text-light" id="otherReason" rows="3"></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <button type="button" id="submitReportBtn" class="btn btn-danger">Submit Report</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `;

                    document.body.insertAdjacentHTML('beforeend', modalHTML);
                    reportModal = document.getElementById('reportCommentModal');

                    document.querySelectorAll('input[name="reportReason"]').forEach(radio => {
                        radio.addEventListener('change', function() {
                            const otherContainer = document.getElementById('otherReasonContainer');
                            otherContainer.style.display = this.value === 'other' ? 'block' : 'none';
                        });
                    });

                    document.getElementById('submitReportBtn').addEventListener('click', function() {
                        const commentId = this.getAttribute('data-comment-id');
                        submitReport(commentId);
                    });
                }

                const radioButtons = reportModal.querySelectorAll('input[name="reportReason"]');
                radioButtons.forEach(radio => radio.checked = false);

                const otherReasonContainer = reportModal.querySelector('#otherReasonContainer');
                otherReasonContainer.style.display = 'none';

                const otherReason = reportModal.querySelector('#otherReason');
                if (otherReason) otherReason.value = '';

                const submitButton = reportModal.querySelector('#submitReportBtn');
                submitButton.setAttribute('data-comment-id', commentId);

                const bsModal = new bootstrap.Modal(reportModal);
                bsModal.show();
            };

            function submitReport(commentId) {
                const reportModal = document.getElementById('reportCommentModal');
                const selectedReason = reportModal.querySelector('input[name="reportReason"]:checked');

                if (!selectedReason) {
                    alert('Please select a reason for reporting this comment.');
                    return;
                }

                let reason = selectedReason.value;

                if (reason === 'other') {
                    const otherReasonText = reportModal.querySelector('#otherReason').value.trim();
                    if (!otherReasonText) {
                        alert('Please specify a reason for reporting this comment.');
                        return;
                    }
                    reason = otherReasonText;
                }

                const submitButton = reportModal.querySelector('#submitReportBtn');
                submitButton.disabled = true;
                submitButton.textContent = 'Submitting...';

                fetch(`/comments/report/${commentId}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams({
                        reason: reason
                    })
                })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(data => {
                            throw new Error(data.message || `Failed to report comment: ${response.status}`);
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    bootstrap.Modal.getInstance(reportModal).hide();

                    // Mark this comment as reported in the localStorage
                    markCommentAsReported(commentId);

                    // Replace the report button with "Reported" text
                    const $reportBtn = $(`.report-btn[data-comment-id="${commentId}"]`);
                    $reportBtn.replaceWith('<span class="text-muted small ms-2 reported-badge"><i class="fas fa-flag me-1"></i> Reported</span>');

                    showToastNotification('Comment reported successfully. Thank you for helping keep our community safe.', 'success');
                })
                .catch(error => {
                    console.error("Error reporting comment:", error);
                    showToastNotification('Failed to report comment: ' + error.message, 'error');
                })
                .finally(() => {
                    submitButton.disabled = false;
                    submitButton.textContent = 'Submit Report';
                });
            }
        });