$(document).ready(function(){
  track_remote_messages($('#sign_up_form, #sign_in_form, #change_password_form'));

  $('#sign_up_form, #sign_in_form').on('ajax:success', function(data, response, xhr) {
    if (response.status == 'success') {
      window.location.href = '/profile/edit'
    }
  });

  $('#change_password_form').on('submit', function(){
    if ($('#new_password').val() != $('#confirm_password').val()) {
      show_message('Password do not match', 'Error', 'error');
      return false;
    }
    if ($('#new_password').val() == '' || $('#old_password').val() == '') {
      show_message('Password can not be empty', 'Error', 'error');
      return false;
    }
  });

  $('#change_password_form').on('ajax:success', function(data, response, xhr) {
    if (response.status == 'success') {    
      $('#password').modal('hide');
    }
  });

});
