$(document).ready(function () {
    if (typeof watchlistId === "undefined") {
        console.error("watchlistId is not defined");
        alert("Error: Watchlist ID is missing. Cannot load comments.");
        return;
    }

    const COMMENTS_PER_PAGE = 5;

    const pickerContainer = document.createElement("div");
    pickerContainer.id = "emojiPickerContainer";
    pickerContainer.style.display = "none";
    pickerContainer.style.position = "absolute";
    pickerContainer.style.zIndex = "1000";
    document.querySelector(".comment-input-wrapper").appendChild(pickerContainer);

    let activeInput = null;

    const pickerOptions = {
        onEmojiSelect: function (emoji) {
            console.log("Emoji selected:", emoji);
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
        console.log("Main emoji button clicked");
        activeInput = $("#commentBox");
        const isVisible = pickerContainer.style.display === "block";
        pickerContainer.style.display = isVisible ? "none" : "block";
        if (!isVisible) {
            const buttonRect = this.getBoundingClientRect();
            pickerContainer.style.top = `${buttonRect.bottom + window.scrollY}px`;
            pickerContainer.style.left = `${buttonRect.left + window.scrollX - 150}px`;
        }
    });

    $(document).on("click", ".reply-emoji-button", function (e) {
        e.preventDefault();
        console.log("Reply emoji button clicked");
        activeInput = $(this).closest(".reply-input-wrapper").find(".reply-box");
        const isVisible = pickerContainer.style.display === "block";
        pickerContainer.style.display = isVisible ? "none" : "block";
        if (!isVisible) {
            const buttonRect = this.getBoundingClientRect();
            pickerContainer.style.top = `${buttonRect.bottom + window.scrollY}px`;
            pickerContainer.style.left = `${buttonRect.left + window.scrollX - 150}px`;
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

    fetchComments();

    function createCommentElement(comment, isReply = false, nestingLevel = 0, parentAuthor = null) {
        const commentId = comment.commentId || Math.floor(Math.random() * 10000);

        console.log(`Creating ${isReply ? 'reply' : 'comment'} element with ID: ${commentId}, mentioning: ${parentAuthor || 'none'}`);

        const commentDiv = document.createElement("div");
        commentDiv.className = isReply ? "d-flex flex-start mb-3 reply" : "d-flex flex-start mb-4";
        commentDiv.setAttribute('data-comment-id', commentId);

        commentDiv.setAttribute('data-nesting-level', isReply ? 1 : 0);

        commentDiv.style.marginLeft = '';

        const avatarImg = document.createElement("img");
        avatarImg.className = "rounded-circle shadow-1-strong";
        avatarImg.src = comment.avatarSrc || "../../pics/DeadeyeFo.png";
        avatarImg.alt = "avatar";
        avatarImg.width = isReply ? 40 : 65;
        avatarImg.height = isReply ? 40 : 65;

        const cardDiv = document.createElement("div");
        cardDiv.className = "comment-card w-100";
        cardDiv.setAttribute('data-username', comment.username);
        cardDiv.setAttribute('data-comment-id', commentId);

        const cardBody = document.createElement("div");
        cardBody.className = "comment-card-body p-4";

        const headerDiv = document.createElement("div");
        headerDiv.className = "comment-header";

        const authorHeading = document.createElement(isReply ? "h6" : "h5");
        authorHeading.className = "comment-author";
        authorHeading.textContent = comment.username;

        const dateSpan = document.createElement("span");
        dateSpan.className = "comment-date";
        dateSpan.textContent = new Date(comment.createdAt).toLocaleDateString();

        const timeSpan = document.createElement("span");
        timeSpan.className = "comment-time";
        timeSpan.textContent = new Date(comment.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        const commentP = document.createElement("p");

        if (isReply && parentAuthor) {
            // Create mention link (@) for parent author
            const mentionText = document.createElement("a");
            mentionText.href = "#";
            mentionText.style.color = "#007bff";
            mentionText.textContent = `@${parentAuthor}`;
            mentionText.style.textDecoration = "none";
            mentionText.style.marginRight = "5px";

            commentP.appendChild(mentionText);
            commentP.appendChild(document.createTextNode(" " + comment.text));
        } else {
            commentP.textContent = comment.text;
        }

        const actionDiv = document.createElement("div");
        actionDiv.className = "d-flex justify-content-between align-items-center mb-3";
        actionDiv.setAttribute('data-comment-id', commentId);

        const likeDiv = document.createElement("div");
        likeDiv.className = "d-flex align-items-center gap-2";

        const likeLink = document.createElement("a");
        likeLink.href = "#";
        likeLink.className = "link-muted me-2 like-btn";
        likeLink.setAttribute('data-action', 'like');
        likeLink.innerHTML = `<i class="fas fa-thumbs-up me-1"></i><span class="like-count">${comment.likes || 0}</span>`;

        const dislikeLink = document.createElement("a");
        dislikeLink.href = "#";
        dislikeLink.className = "link-muted dislike-btn";
        dislikeLink.setAttribute('data-action', 'dislike');
        dislikeLink.innerHTML = `<i class="fas fa-thumbs-down me-1"></i><span class="dislike-count">${comment.dislikes || 0}</span>`;

        const replyLink = document.createElement("a");
        replyLink.href = "#";
        replyLink.className = "link-muted reply-btn";
        replyLink.setAttribute('data-action', 'reply');
        replyLink.innerHTML = '<i class="fas fa-reply me-1"></i> Reply';

        headerDiv.appendChild(authorHeading);
        headerDiv.appendChild(dateSpan);
        headerDiv.appendChild(timeSpan);

        likeDiv.appendChild(likeLink);
        likeDiv.appendChild(dislikeLink);

        actionDiv.appendChild(likeDiv);
        actionDiv.appendChild(replyLink);

        cardBody.appendChild(headerDiv);
        cardBody.appendChild(commentP);
        cardBody.appendChild(actionDiv);

        cardDiv.appendChild(cardBody);
        commentDiv.appendChild(avatarImg);
        commentDiv.appendChild(cardDiv);

        return commentDiv;
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
        replyButton.className = "btn btn-primary btn-sm post-reply-btn";
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

        // Count all replies including nested ones
        const replyCount = $repliesSection.find('.reply').length;

        console.log(`Updating toggle for comment: ${replyCount} replies`);

        if (replyCount === 0) {
            $toggleLink.remove();
            $repliesSection.remove();
            return;
        }

        if ($toggleLink.length === 0) {
            $toggleLink = $('<a href="#" class="link-muted toggle-replies"></a>');
            $commentBody.find('.d-flex.justify-content-between').after($toggleLink);
        }

        const isHidden = $repliesSection.is(':hidden');
        $toggleLink.text(isHidden ?
            `Show ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}` :
            `Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
        $toggleLink.show();
    }

    function applyViewMoreComments() {
        const $commentSection = $('#commentSection');
        const $mainComments = $commentSection.find('> .d-flex.flex-start.mb-4');
        const totalComments = $mainComments.length;
        const $viewMoreButton = $commentSection.find('.view-more-comments');

        console.log(`applyViewMoreComments called: ${totalComments} total main comments`);

        $viewMoreButton.remove();

        if (totalComments > COMMENTS_PER_PAGE) {
            console.log(`Showing ${COMMENTS_PER_PAGE} comments, hiding ${totalComments - COMMENTS_PER_PAGE}`);
            $mainComments.each(function (index) {
                const $comment = $(this);
                if (index >= COMMENTS_PER_PAGE) {
                    $comment.addClass('hidden').hide();
                } else {
                    $comment.removeClass('hidden').show();
                }
            });

            const remainingComments = totalComments - COMMENTS_PER_PAGE;
            console.log(`Adding "View More" button for ${remainingComments} remaining comments`);

            const $lastVisibleComment = $mainComments.eq(COMMENTS_PER_PAGE - 1);
            const $newViewMoreButton = $(`<a href="#" class="link-muted view-more-comments">View ${remainingComments} more comments</a>`);
            $lastVisibleComment.after($newViewMoreButton);
        } else {
            console.log("Total comments within limit, showing all comments");
            $mainComments.removeClass('hidden').show();
        }
    }

    function fetchComments() {
        console.log("Fetching comments for watchlistId:", watchlistId);
        fetch(`/comments/list/${watchlistId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Failed to fetch comments: ${response.status}`);
                }
                return response.json();
            })
            .then(comments => {
                console.log("Comments fetched:", comments);
                const commentSection = document.getElementById("commentSection");
                commentSection.innerHTML = "";

                if (!comments || comments.length === 0) {
                    commentSection.innerHTML = '<p>No comments yet. Be the first to comment!</p>';
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
                alert("Failed to load comments. Please try again later.");
            });
    }

    function fetchRepliesFlat(commentId, commentElement, commentUsername) {
        console.log(`Fetching replies for comment ID: ${commentId}`);

        let repliesSection = commentElement.querySelector('.replies-section');
        let toggleLink = commentElement.querySelector('.toggle-replies');

        if (!repliesSection) {

            toggleLink = document.createElement('a');
            toggleLink.href = '#';
            toggleLink.className = 'link-muted toggle-replies mb-2';

            const actionDiv = commentElement.querySelector('.d-flex.justify-content-between');
            actionDiv.parentNode.insertBefore(toggleLink, actionDiv.nextSibling);

            repliesSection = document.createElement('div');
            repliesSection.className = 'replies-section mt-3';
            toggleLink.parentNode.insertBefore(repliesSection, toggleLink.nextSibling);
        }

        let allReplies = [];
        const processedReplies = new Set();

        // Function to gather ALL replies (direct and nested) recursively
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

                console.log(`Found ${replies.length} direct replies to ${parentId}`);

                for (const reply of replies) {
                    if (!processedReplies.has(reply.commentId)) {
                        allReplies.push({
                            reply: reply,
                            parentUsername: parentUsername,
                            nestingLevel: 1
                        });
                        processedReplies.add(reply.commentId);

                        // Recursively fetch replies to this reply
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

                console.log(`Total replies gathered for comment ${commentId}: ${allReplies.length}`);

                // Clear the replies section to avoid duplicates
                repliesSection.innerHTML = '';

                // Add all replies to the section
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
                    // Set initial visibility based on localStorage
                    const isVisible = localStorage.getItem(`reply-section-${commentId}`) === 'visible';
                    repliesSection.style.display = isVisible ? 'block' : 'none';

                    toggleLink.textContent = isVisible ?
                        `Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}` :
                        `Show ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`;

                    toggleLink.style.display = 'block';
                } else {
                    // No replies, hide both
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
            })
            .catch(error => {
                console.error(`Error ${action}ing comment:`, error);
                alert(`Failed to ${action} comment. Please try again.`);
            });
    });

    $(document).on('click', '.reply-btn', function (e) {
        e.preventDefault();
        const $replyBtn = $(this);
        const $actionDiv = $replyBtn.closest('.d-flex.justify-content-between');
        const $commentWithId = $replyBtn.closest('[data-comment-id]');
        const parentId = $commentWithId.attr('data-comment-id');

        console.log("Reply button clicked for comment ID:", parentId);

        if (!parentId) {
            console.error("Could not find parent comment ID");
            return;
        }

        // Check if there's already an input wrapper
        let $existingWrapper = $actionDiv.next('.reply-input-wrapper');

        if ($existingWrapper.length > 0) {
            $existingWrapper.slideUp(300, function() {
                $(this).remove();
            });
            return;
        }

        // Close any other open reply inputs
        $('.reply-input-wrapper').slideUp(200, function() {
            $(this).remove();
        });

        const $replyInputWrapper = $(createReplyInputWrapper(parentId));
        $actionDiv.after($replyInputWrapper);

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

        console.log("Posting reply to parent ID:", parentId);

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

        // Show loading state
        $button.prop('disabled', true).text('Posting...');

        fetch(`/comments/reply/${parentId}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                username: 'DeadeyeFo',
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
            const $parentElement = $replyInputWrapper.closest('[data-comment-id]');
            const username = $parentElement.find('.comment-author').text().trim();

            const $mainComment = $parentElement.hasClass('d-flex flex-start mb-4') ?
                              $parentElement :
                              $parentElement.closest('.d-flex.flex-start.mb-4');

            if (!$mainComment.length) {
                console.error("Could not find main comment");
                return;
            }

            const mainCommentId = $mainComment.data('comment-id');

            let $repliesSection = $mainComment.find('.replies-section');
            let $toggleLink = $mainComment.find('.toggle-replies');

            if ($repliesSection.length === 0) {
                $toggleLink = $('<a href="#" class="link-muted toggle-replies"></a>');
                $mainComment.find('.comment-card-body').find('.d-flex.justify-content-between').after($toggleLink);

                $repliesSection = $('<div class="replies-section mt-3"></div>');
                $toggleLink.after($repliesSection);
            }

            const newReply = createCommentElement(reply, true, 1, username);

            // Always add to the beginning for newest first order
            $repliesSection.prepend(newReply);

            const replyCount = $repliesSection.find('.reply').length;
            $toggleLink.text(`Hide ${replyCount} ${replyCount === 1 ? 'reply' : 'replies'}`);
            $toggleLink.show();

            // Show replies section and save state
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

        console.log("Toggling replies. Comment ID:", commentId, "Current visibility:", $repliesSection.is(':visible'), "Count:", replyCount);

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

    // View more comments
    $(document).on('click', '.view-more-comments', function (e) {
        e.preventDefault();
        const $button = $(this);
        const $commentSection = $('#commentSection');
        const $hiddenComments = $commentSection.find('.d-flex.flex-start.mb-4.hidden');

        console.log("View More Comments clicked, showing", $hiddenComments.length, "hidden comments");

        $hiddenComments.removeClass('hidden').slideDown({
            duration: 300,
            complete: function () {
                $button.remove();
            }
        });
    });

    // Post new comment
    window.postComment = function () {
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

            const username = document.querySelector(".comment-author")?.textContent || "DeadeyeFo";
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
                console.log("Comment posted:", comment);
                commentBox.value = "";
                const commentSection = document.getElementById("commentSection");
                const newComment = createCommentElement(comment);
                if (commentSection.firstChild) {
                    commentSection.insertBefore(newComment, commentSection.firstChild);
                } else {
                    commentSection.appendChild(newComment);
                }
                newComment.scrollIntoView({ behavior: "smooth", block: "nearest" });
                applyViewMoreComments();
            })
            .catch(error => {
                console.error("Error posting comment:", error);
                alert("Failed to post comment. Please try again.");
            });
        } catch (error) {
            console.error("Error posting comment:", error.message);
            alert("An error occurred while posting your comment. Please try again.");
        }
    };
});