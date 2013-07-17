$(document).ready(function(){
  track_remote_messages($('#product_create_form'));

  $('#product_create_form').on('ajax:success', function(data, response, xhr) {
    if (response.status == 'success') {
      $('#post').modal('hide');
      $('.products_list:first').prepend(response.new_product);
      $('#thing_popup' + response.product_id).modal('show');
    }
  });

  var page_num = 1

  if($('.products_list').length > 0) {
    $(window).on('scroll', function(){
      if(loading_hidden() && near_bottom()) {
        $('#products_loading').css('top', $(document).height() - 100);
        $('#products_loading').css('left', $(document).width() / 2);
        if(page_num > 0) {
          $('#products_loading').show();
          load_new_products();
        }
      }
    });
  }

  function load_new_products(){
    $.post('/products', {page: ++page_num}, function(data, e) {
      if(data == '') {
        page_num = 0;
        return false;
      }
      $('.products_list:last').parent().append(data);
      console.log(data);
    }).complete(function() {
      $('#products_loading').hide();
    });
  }

  function loading_hidden(){
    return $('#products_loading:visible').length == 0;
  }

  function near_bottom(){
    return $(window).scrollTop() > $(document).height() - $(window).height() - 50;
  }

});