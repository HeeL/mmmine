$(document).ready(function(){
  track_remote_messages($('#sign_up_form, #sign_in_form, #change_password_form'));

  function redirect_on_success(path, response){
    if (response.status == 'success') {
      window.location.href = path
    }
  }

  $('#register_with_email').on('click', function(){
    $('#signup').modal('show');
    email = $('#email_to_register').val();
    $('#sign_up_form input[name="email"]').val(email);
    return false;
  });

  $('#sign_up_form').on('ajax:success', function(data, response, xhr) {
    redirect_on_success('/profile/edit', response);
  });


  $('#sign_in_form').on('ajax:success', function(data, response, xhr) {
    redirect_on_success('/products/live_feed', response);
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
