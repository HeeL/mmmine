$(document).ready(function(){
  track_remote_messages($('#product_create_form'));

  $('#product_create_form').on('ajax:success', function(data, response, xhr) {
    if (response.status == 'success') {
      $('#post').modal('hide');
    }
  });
});