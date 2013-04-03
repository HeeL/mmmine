$(document).ready(function(){
  track_remote_messages($('#sign_up_form, #sign_in_form'));

  $('#sign_up_form, #sign_in_form').on('ajax:success', function(data, response, xhr) {
    if (response.status == 'success') {
      window.location.href = '/profile/edit'
    }
  });
});
