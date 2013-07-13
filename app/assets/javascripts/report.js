$(document).ready(function(){
  track_remote_messages($('#report_create_form'));

  $('#report_create_form').on('submit', function(){
    product_id = $('.product-details:visible').data('product-id');
    $('#report_product_id').val(product_id);
  });

  $('#report_create_form').on('ajax:success', function(data, response, xhr) {
    if (response.status == 'success') {
      $('#report').modal('hide');
    }
  });
});