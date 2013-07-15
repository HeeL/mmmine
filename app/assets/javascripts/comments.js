$(document).ready(function(){
  track_remote_messages($('.comment-form'));

  $('.comment-form').on('ajax:success', function(data, response, xhr) {
    if (response.status == 'success') {
      $('.comment-form:visible textarea').val('');
      $('.list-comments:visible ul').prepend(response.new_comment)
    }
  });
});