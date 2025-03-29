$(document).ready(function () {
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

    let commentData = {};
    let replyData = {};

    const COMMENTS_PER_PAGE = 5; // Number of main comments to show initially

    function generateCommentId() {
        return 'comment-' + Date.now() + '-' + Math.floor(Math.random() * 1000);
    }

    function generateReplyId() {
        return 'reply-' + Date.now() + '-' + Math.floor(Math.random() * 1000);
    }

    document.querySelectorAll('[data-comment-id]').forEach(comment => {
        const id = comment.getAttribute('data-comment-id');
        commentData[id] = {
            likes: parseInt(comment.querySelector('.like-count').textContent) || 0,
            dislikes: parseInt(comment.querySelector('.dislike-count').textContent) || 0
        };
    });

    // Initialize the comment section with "View More" for main comments
    applyViewMoreComments();

    $(document).on('click', '.like-btn, .dislike-btn', function (e) {
        e.preventDefault();
        const $actionElement = $(this);
        const action = $actionElement.data('action');
        const $comment = $actionElement.closest('[data-comment-id]');
        const $reply = $actionElement.closest('[data-reply-id]');
        const id = $comment.length ? $comment.data('comment-id') : $reply.data('reply-id');
        const dataStore = $comment.length ? commentData : replyData;
        const $countElement = action === 'like' ? $actionElement.find('.like-count') : $actionElement.find('.dislike-count');

        console.log('Like/Dislike button clicked:', {
            action: action,
            id: id,
            isComment: $comment.length > 0,
            countElementFound: $countElement.length > 0
        });

        if (!id) {
            console.error('Error: Could not find comment or reply ID');
            return;
        }

        if (!dataStore[id]) {
            dataStore[id] = { likes: 0, dislikes: 0 };
            console.log('Initialized dataStore for ID:', id, dataStore[id]);
        }

        if (action === 'like') {
            dataStore[id].likes += 1;
            $countElement.text(dataStore[id].likes);
            console.log(`Updated likes for ID ${id}:`, dataStore[id].likes);
        } else if (action === 'dislike') {
            dataStore[id].dislikes += 1;
            $countElement.text(dataStore[id].dislikes);
            console.log(`Updated dislikes for ID ${id}:`, dataStore[id].dislikes);
        } else {
            console.error('Error: Invalid action:', action);
        }
    });

    $(document).on('click', '.reply-btn', function (e) {
        e.preventDefault();
        const $replyBtn = $(this);
        const $commentCard = $replyBtn.closest('.comment-card');
        let $replyInputWrapper = $commentCard.find('.reply-input-wrapper').first();

        if ($replyInputWrapper.length === 0) {
            $replyInputWrapper = $(createReplyInputWrapper());
            const $toggleLink = $commentCard.find('.toggle-replies');
            if ($toggleLink.length) {
                $toggleLink.after($replyInputWrapper);
            } else {
                $commentCard.find('.d-flex.justify-content-between').after($replyInputWrapper);
            }
        }

        const isVisible = $replyInputWrapper.is(':visible');
        $replyInputWrapper.slideToggle();
        if (!isVisible) {
            $replyInputWrapper.find('.reply-box').focus();
        }
    });

    $(document).on('click', '.post-reply-btn', function (e) {
        e.preventDefault();
        const $button = $(this);
        const $replyInputWrapper = $button.closest('.reply-input-wrapper');
        const $replyBox = $replyInputWrapper.find('.reply-box');
        const replyText = $replyBox.val().trim();
        const $commentCard = $replyInputWrapper.closest('.comment-card');

        if (!replyText) {
            alert("Please enter a reply.");
            $replyBox.focus();
            return;
        }

        let $currentCommentCard = $commentCard;
        let $repliesSectionAncestor = $currentCommentCard.closest('.replies-section');
        let $mainCommentCard;

        if ($repliesSectionAncestor.length) {
            $mainCommentCard = $repliesSectionAncestor.closest('.comment-card');
            console.log("Found main comment card via replies-section:", $mainCommentCard.find('.comment-author').text());
        } else {
            $mainCommentCard = $currentCommentCard;
            console.log("No replies-section ancestor, using current comment card as main:", $mainCommentCard.find('.comment-author').text());
        }

        const $mainParent = $mainCommentCard.closest('.d-flex');
        if ($mainParent.hasClass('reply') || $mainParent.hasClass('nested-reply')) {
            console.error("Error: $mainCommentCard is not a main comment! Found:", $mainCommentCard.find('.comment-author').text());
            return;
        }

        let $repliesSection = $mainCommentCard.find('.replies-section').first();
        if ($repliesSection.length === 0) {
            $repliesSection = $('<div class="replies-section mt-3"></div>');
            $mainCommentCard.find('.comment-card-body').append($repliesSection);
        }

        let nestingDepth = 0;
        let $current = $commentCard;
        while ($current.closest('.replies-section').length) {
            nestingDepth++;
            $current = $current.closest('.replies-section').closest('.comment-card');
        }

        const maxNestingDepth = 3;
        const cappedNestingDepth = Math.min(nestingDepth + 1, maxNestingDepth);

        const parentAuthor = $commentCard.data('username') || $commentCard.find('.comment-author').text();

        const newReply = createCommentElement(replyText, "DeadeyeFo", "../../pics/DeadeyeFo.png", true, cappedNestingDepth, parentAuthor);
        $repliesSection.prepend(newReply);

        updateToggleRepliesLink($mainCommentCard);

        if ($commentCard[0] !== $mainCommentCard[0]) {
            const $parentRepliesSection = $commentCard.find('.replies-section');
            if ($parentRepliesSection.length && $parentRepliesSection.find('> .d-flex.reply').length === 0) {
                $parentRepliesSection.remove();
                $commentCard.find('.toggle-replies').remove();
            }
        }

        $replyBox.val('');
        $replyInputWrapper.slideUp();

        updateToggleRepliesLink($mainCommentCard);
    });

    $(document).on('click', '.toggle-replies', function (e) {
        e.preventDefault();
        const $link = $(this);
        const $commentCard = $link.closest('.comment-card');
        const $repliesSection = $commentCard.find('.replies-section');
        const $replies = $repliesSection.find('.reply');

        console.log("Toggling replies. Current visibility:", $replies.is(':visible'), "Number of replies:", $replies.length);

        if ($link.hasClass('is-hidden')) {
            $repliesSection.slideDown({
                duration: 200,
                complete: function () {
                    $link.removeClass('is-hidden');
                    $link.text(`Hide ${$replies.length} replies`);
                    console.log("Replies shown");
                }
            });
        } else {
            $repliesSection.slideUp({
                duration: 200,
                complete: function () {
                    $link.addClass('is-hidden');
                    $link.text(`Show ${$replies.length} replies`);
                    console.log("Replies hidden");
                }
            });
        }
    });

    // Handle "View More" button click for main comments
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

    function applyViewMoreComments() {
        const $commentSection = $('#commentSection');
        const $mainComments = $commentSection.find('> .d-flex.flex-start.mb-4'); // Select only main comments
        const totalComments = $mainComments.length;
        const $viewMoreButton = $commentSection.find('.view-more-comments');

        console.log(`applyViewMoreComments called: ${totalComments} total main comments`);

        // Remove any existing "View More" button
        $viewMoreButton.remove();

        if (totalComments > COMMENTS_PER_PAGE) {
            console.log(`Showing ${COMMENTS_PER_PAGE} comments, hiding ${totalComments - COMMENTS_PER_PAGE}`);
            $mainComments.each(function (index) {
                const $comment = $(this);
                if (index >= COMMENTS_PER_PAGE) {
                    $comment.addClass('hidden').hide();
                    console.log(`Hiding comment ${index + 1}:`, $comment.find('.comment-author').text(), $comment.find('p').text());
                } else {
                    $comment.removeClass('hidden').show();
                    console.log(`Showing comment ${index + 1}:`, $comment.find('.comment-author').text(), $comment.find('p').text());
                }
            });

            const remainingComments = totalComments - COMMENTS_PER_PAGE;
            console.log(`Adding "View More" button for ${remainingComments} remaining comments after comment ${COMMENTS_PER_PAGE}`);

            // Insert the "View More" button after the last visible comment (the 5th comment)
            const $lastVisibleComment = $mainComments.eq(COMMENTS_PER_PAGE - 1);
            const $newViewMoreButton = $(`<a href="#" class="link-muted view-more-comments">View ${remainingComments} more comments</a>`);
            $lastVisibleComment.after($newViewMoreButton);
        } else {
            console.log("Total comments within limit, showing all comments");
            $mainComments.removeClass('hidden').show();
            $mainComments.each(function (index) {
                const $comment = $(this);
                console.log(`Showing comment ${index + 1}:`, $comment.find('.comment-author').text(), $comment.find('p').text());
            });
        }
    }

    function getCurrentTime() {
        const now = new Date();
        const hours = now.getHours();
        const minutes = now.getMinutes();
        const ampm = hours >= 12 ? 'PM' : 'AM';
        const formattedHours = hours % 12 || 12;
        const formattedMinutes = minutes < 10 ? `0${minutes}` : minutes;
        return `${formattedHours}:${formattedMinutes} ${ampm}`;
    }

    function getCurrentDate() {
        const now = new Date();
        const months = [
            "Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
        ];
        const month = months[now.getMonth()];
        const day = now.getDate();
        const year = now.getFullYear();
        return `${month} ${day}, ${year}`;
    }

    function createCommentElement(commentText, author = "DeadeyeFo", avatarSrc = "../../pics/DeadeyeFo.png", isReply = false, nestingLevel = 0, parentAuthor = null) {
        const commentId = isReply ? generateReplyId() : generateCommentId();
        const commentDiv = document.createElement("div");
        commentDiv.className = isReply ? "d-flex flex-start mb-3 reply" : "d-flex flex-start mb-4";

        const avatarImg = document.createElement("img");
        avatarImg.className = "rounded-circle shadow-1-strong";
        avatarImg.src = avatarSrc;
        avatarImg.alt = "avatar";
        avatarImg.width = isReply ? 40 : 65;
        avatarImg.height = isReply ? 40 : 65;

        const cardDiv = document.createElement("div");
        cardDiv.className = "comment-card w-100";
        cardDiv.setAttribute('data-username', author);

        const cardBody = document.createElement("div");
        cardBody.className = "comment-card-body p-4";

        const headerDiv = document.createElement("div");
        headerDiv.className = "comment-header";

        const authorHeading = document.createElement(isReply ? "h6" : "h5");
        authorHeading.className = "comment-author";
        authorHeading.textContent = author;

        const dateSpan = document.createElement("span");
        dateSpan.className = "comment-date";
        dateSpan.textContent = getCurrentDate();

        const timeSpan = document.createElement("span");
        timeSpan.className = "comment-time";
        timeSpan.textContent = getCurrentTime();

        const commentP = document.createElement("p");
        if (isReply && parentAuthor) {
            commentP.setAttribute('data-reply-to', parentAuthor);
            commentP.setAttribute('data-nesting-level', nestingLevel);
        }
        commentP.textContent = commentText;

        const actionDiv = document.createElement("div");
        actionDiv.className = "d-flex justify-content-between align-items-center mb-3";
        actionDiv.setAttribute(isReply ? 'data-reply-id' : 'data-comment-id', commentId);

        const likeDiv = document.createElement("div");
        likeDiv.className = "d-flex align-items-center gap-2";

        const likeLink = document.createElement("a");
        likeLink.href = "#";
        likeLink.className = "link-muted me-2 like-btn";
        likeLink.setAttribute('data-action', 'like');
        likeLink.innerHTML = '<i class="fas fa-thumbs-up me-1"></i><span class="like-count">0</span>';

        const dislikeLink = document.createElement("a");
        dislikeLink.href = "#";
        dislikeLink.className = "link-muted dislike-btn";
        dislikeLink.setAttribute('data-action', 'dislike');
        dislikeLink.innerHTML = '<i class="fas fa-thumbs-down me-1"></i><span class="dislike-count">0</span>';

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

        const dataStore = isReply ? replyData : commentData;
        dataStore[commentId] = { likes: 0, dislikes: 0 };

        return commentDiv;
    }

    function createReplyInputWrapper() {
        const replyInputWrapper = document.createElement("div");
        replyInputWrapper.className = "reply-input-wrapper mt-3";
        replyInputWrapper.style.display = "none";

        const inputContainer = document.createElement("div");
        inputContainer.className = "input-container position-relative";

        const replyTextarea = document.createElement("textarea");
        replyTextarea.className = "form-control border-0 bg-secondary reply-box";
        replyTextarea.placeholder = "Write a reply...";
        inputContainer.appendChild(replyTextarea);

        const emojiButton = document.createElement("button");
        emojiButton.className = "reply-emoji-button";
        emojiButton.innerHTML = "😊";
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
        const $parentComment = $commentCard.closest('.d-flex');
        const isReply = $parentComment.hasClass('reply') || $parentComment.hasClass('nested-reply');

        let $toggleLink = $commentCard.find('.toggle-replies');
        let $repliesSection = $commentCard.find('.replies-section');

        if ($repliesSection.length === 0) {
            $toggleLink.remove();
            return;
        }

        const $directReplies = $repliesSection.find('> .d-flex.reply');
        const replyCount = $directReplies.length;

        console.log(`Updating toggle for ${isReply ? 'reply' : 'main comment'} by ${$commentCard.find('.comment-author').text()}: ${replyCount} direct replies`);

        if (replyCount === 0) {
            $toggleLink.remove();
            $repliesSection.remove();
            return;
        }

        if ($toggleLink.length === 0) {
            $toggleLink = $('<a href="#" class="link-muted toggle-replies"></a>');
            $commentCard.find('.d-flex.justify-content-between').after($toggleLink);
        }

        const isHidden = $toggleLink.hasClass('is-hidden');
        $toggleLink.text(isHidden ? `Show ${replyCount} replies` : `Hide ${replyCount} replies`);
        $toggleLink.show();
    }

    function postComment() {
        try {
            const commentBox = document.getElementById("commentBox");
            if (!commentBox) {
                throw new Error("Comment box element not found.");
            }

            const rawValue = commentBox.value;
            const commentText = rawValue.trim();

            console.log("postComment called:", {
                rawValue: rawValue,
                trimmedValue: commentText,
                rawLength: rawValue.length,
                trimmedLength: commentText.length
            });

            if (!rawValue) {
                alert("Please enter a comment.");
                commentBox.focus();
                return;
            }

            if (!commentText) {
                alert("Comment cannot be only whitespace.");
                commentBox.focus();
                return;
            }

            const commentSection = document.getElementById("commentSection");
            if (!commentSection) {
                throw new Error("Comment section not found.");
            }

            const newComment = createCommentElement(commentText);
            commentSection.insertBefore(newComment, commentSection.firstChild);
            console.log("Added new comment:", commentText);

            commentBox.value = "";
            newComment.scrollIntoView({ behavior: "smooth", block: "nearest" });

            // Re-apply "View More" for main comments after adding a new comment
            applyViewMoreComments();

        } catch (error) {
            console.error("Error posting comment:", error.message);
            alert("An error occurred while posting your comment. Please try again.");
        }
    }

    window.postComment = postComment;
});