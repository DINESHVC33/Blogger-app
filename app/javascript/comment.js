// app/assets/javascripts/comments.js

$(document).on('turbolinks:load', function() {
    $('.rate-comment-button').on('click', function() {
        // Get the comment ID
        var commentId = $(this).data('comment-id');

        // Get the topic and post IDs from the data attributes or URL
        var topicId = $(this).data('topic-id'); // Adjust based on how you store topic ID
        var postId = $(this).data('post-id'); // Adjust based on how you store post ID

        // Alternatively, extract topic and post IDs from the URL
        // var topicId = window.location.pathname.split('/')[2];
        // var postId = window.location.pathname.split('/')[4];

        // Make an AJAX request to rate the comment
        $.ajax({
            url: '/topics/' + topicId + '/posts/' + postId + '/comments/' + commentId + '/rate',
            type: 'POST',
            dataType: 'script',
            success: function(response) {
                // Handle success
            },
            error: function(error) {
                // Handle error
            }
        });
    });
});

